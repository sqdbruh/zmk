#ifndef CONFIG_BOARD_GAMMA_DONGLE
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif
#include <math.h>
#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/pm/device.h>
#include <zephyr/bluetooth/conn.h>
#include <zephyr/drivers/i2c.h>
#include <zephyr/drivers/sensor.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/gpio.h>
#include <zmk/events/keycode_state_changed.h>
#include <zmk/events/usb_conn_state_changed.h>
#include <zmk/event_manager.h>
#include <zmk/events/battery_state_changed.h>

#include <zephyr/bluetooth/services/bas.h>

#include <zephyr/logging/log.h>
LOG_MODULE_DECLARE(zmk, CONFIG_ZMK_LOG_LEVEL);

#include <zmk/events/endpoint_changed.h>
#include <zmk/endpoints.h>
#include <zmk/ble.h>
#include <zmk/usb.h>
#include <zmk/split/bluetooth/peripheral.h>
#include <zmk/activity.h>
#include <zmk/event_manager.h>
#include <zmk/events/ble_active_profile_changed.h>
#include <zmk/events/activity_state_changed.h>
#include <zmk/events/split_peripheral_status_changed.h>
#include <zmk/events/battery_state_changed.h>
#include <zmk/battery.h>
#include <zephyr/drivers/led_strip.h>

#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/drivers/pwm.h>
#include <zmk/workqueue.h>
#define BLE_LED 0
#define BATTERY_LED 1
#define CURRENT_BRIGHTNESS 255

#define ArrayCount(Array) (sizeof(Array) / sizeof((Array)[0]))
static float remap(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
    return toLow + (value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow);
}

static const struct device *spi_dev = DEVICE_DT_GET(DT_NODELABEL(spi3));

static const struct device *apds9960_dev = DEVICE_DT_GET(DT_NODELABEL(apds9960));

static const struct gpio_dt_spec charging_status =
    GPIO_DT_SPEC_GET_OR(DT_NODELABEL(chrg_status), gpios, {0});

static const struct gpio_dt_spec led_enable =
    GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led_enable), gpios, {0});

#define STRIP_NODE DT_ALIAS(led_strip)

#if DT_NODE_HAS_PROP(DT_ALIAS(led_strip), chain_length)
#define STRIP_NUM_PIXELS DT_PROP(DT_ALIAS(led_strip), chain_length)
#else
#error Unable to determine length of LED strip
#endif

static struct led_rgb leds_buffer[STRIP_NUM_PIXELS];

static const struct device *const strip = DEVICE_DT_GET(STRIP_NODE);

static void buffer_single_led_color(int index, uint8_t r, uint8_t g, uint8_t b) {
    leds_buffer[index].r = r;
    leds_buffer[index].g = g;
    leds_buffer[index].b = b;
}

static void buffer_all_leds_color(uint8_t r, uint8_t g, uint8_t b) {
    for (int i = 0; i < STRIP_NUM_PIXELS; i++) {
        buffer_single_led_color(i, r, g, b);
    }
}

static void update_leds() {
    int rc = led_strip_update_rgb(strip, leds_buffer, STRIP_NUM_PIXELS);
    if (rc) {
        LOG_ERR("Couldn't update strip: %d", rc);
    }
}

static void update_leds_color(uint8_t r, uint8_t g, uint8_t b) {
    buffer_all_leds_color(r, g, b);
    update_leds();
}

static void soc_to_led_buffer(uint8_t soc, struct led_rgb *buffer) {
    int num_leds = STRIP_NUM_PIXELS;

    // Calculate how many LEDs should be fully lit based on SoC
    int full_leds = (soc * num_leds) / 100;
    if (full_leds == 0)
        full_leds = 1; // Ensure at least one LED is lit
    if (soc > 90) {
        full_leds = num_leds;
    }

    // Set the color for each LED
    for (int i = 0; i < num_leds; i++) {
        uint8_t r = 0, g = 0, b = 0;

        // Determine brightness based on the fully lit segment count
        if (i < full_leds) {
            if (i == 0) {
                r = CURRENT_BRIGHTNESS; // Red for the first LED
            } else if (i == 1) {
                r = CURRENT_BRIGHTNESS;
                g = (uint8_t)(CURRENT_BRIGHTNESS * 0.7f); // Yellow for the second LED
            } else {
                g = CURRENT_BRIGHTNESS; // Green for the remaining LEDs
            }
        }

        // Assign calculated colors to the buffer
        buffer[i].r = r;
        buffer[i].g = g;
        buffer[i].b = b;
    }
}

// #define CHECK_BATTERY_EVERY 10000
// int tickToCheckBattery = CHECK_BATTERY_EVERY;
volatile bool showBattery;
volatile bool showBatteryDisplay;
volatile bool isPowered;
volatile bool isConnected;

struct gamma_led_state {
    void (*onTick)(struct gamma_led_state *);
    void (*onComplete)();
    uint32_t currentTick;
    uint32_t durationInTicks;
    float t01;
};

#define QUEUE_SIZE (128)
struct gamma_led_queue {
    struct gamma_led_state queue[QUEUE_SIZE];
    int head;
    int tail;
    int count;
};

volatile struct gamma_led_queue led_queue;

static void init_queue(volatile struct gamma_led_queue *q) {
    q->head = 0;
    q->tail = 0;
    q->count = 0;
}

static bool is_queue_full(volatile struct gamma_led_queue *q) { return q->count == QUEUE_SIZE; }

static bool is_queue_empty(volatile struct gamma_led_queue *q) { return q->count == 0; }

static void gamma_tick(struct k_work *work);
K_WORK_DEFINE(gamma_tick_work, gamma_tick);

static void gamma_tick_handler(struct k_timer *timer) {
    k_work_submit_to_queue(zmk_workqueue_lowprio_work_q(), &gamma_tick_work);
}
K_TIMER_DEFINE(gamma_tick_timer, gamma_tick_handler, NULL);

static void enable_led_power(bool enable) {
    gpio_pin_set_dt(&led_enable, enable);
    if (device_is_ready(spi_dev)) {
        int ret = pm_device_action_run(spi_dev,
                                       enable ? PM_DEVICE_ACTION_RESUME : PM_DEVICE_ACTION_SUSPEND);
        if (ret < 0) {
            LOG_ERR("Failed SPI3: %d", ret);
        } else {
            LOG_INF("SPI3 success.");
        }
    }
}

static bool enqueue(volatile struct gamma_led_queue *q, struct gamma_led_state value) {
    if (is_queue_full(q)) {
        return false;
    }
    q->queue[q->tail] = value;
    q->tail = (q->tail + 1) % QUEUE_SIZE;
    q->count++;
    LOG_INF("Enqueue. Queue count: %i ", q->count);

    if (k_timer_remaining_get(&gamma_tick_timer) == 0) {
        enable_led_power(true);
        k_timer_start(&gamma_tick_timer, K_NO_WAIT, K_MSEC(1));
        LOG_INF("Start timer and led");
    }

    return true;
}

static bool dequeue(volatile struct gamma_led_queue *q, struct gamma_led_state *value) {
    if (is_queue_empty(q)) {
        return false;
    }
    *value = q->queue[q->head];
    q->head = (q->head + 1) % QUEUE_SIZE;
    q->count--;
    LOG_INF("Dequeue. Queue count: %i ", q->count);
    return true;
}

static struct gamma_led_state currentState;

void startup_tick(struct gamma_led_state *state) {
    uint8_t soc = zmk_battery_state_of_charge();
    int num_leds = STRIP_NUM_PIXELS;

    // Calculate how many LEDs should be fully lit based on SoC
    int full_leds = (soc * num_leds) / 100;
    if (full_leds == 0)
        full_leds = 1; // Ensure at least one LED is lit

    if (soc > 90) {
        full_leds = num_leds;
    }

    // Calculate fade-in and fade-out factors
    float fade_factor = 1.0f;
    uint32_t fade_in_ticks = (state->durationInTicks * 30) / 100;       // First 10% for fade-in
    uint32_t fade_out_start_tick = (state->durationInTicks * 80) / 100; // Last 20% for fadie-out

    if (state->currentTick <= fade_in_ticks) {
        // Fade-in: Brightness increases from 0 to 1 during the first 10% of the animation
        fade_factor = (float)state->currentTick / fade_in_ticks;
    } else if (state->currentTick >= fade_out_start_tick) {
        // Fade-out: Brightness decreases from 1 to 0 during the last 20% of the animation
        uint32_t fade_ticks = state->currentTick - fade_out_start_tick;
        fade_factor = 1.0f - ((float)fade_ticks / (state->durationInTicks - fade_out_start_tick));
    }

    for (int i = 0; i < num_leds; i++) {
        // Determine brightness for each LED
        uint8_t brightness = 0;
        if (i < full_leds) {
            brightness = CURRENT_BRIGHTNESS; // Fully lit
        } else {
            brightness = 0; // Minimal brightness for uncharged sections
        }

        // Apply fade factor to brightness
        brightness = (uint8_t)(brightness * fade_factor);

        // Set the color for each LED
        uint8_t r = 0, g = 0, b = 0;
        if (i == 0) {
            // RED
            r = brightness;
            g = 0;
            b = 0;
        } else if (i == 1) {
            // YELLOW
            r = brightness;
            g = brightness * 0.7f;
            b = 0;
        } else {
            // GREEN
            r = 0;
            g = brightness;
            b = 0;
        }

        uint32_t total_duration_ticks = state->durationInTicks;
        uint32_t wave_duration_ticks = (total_duration_ticks * 10) / 100;
        uint32_t led_delay_ticks = wave_duration_ticks / num_leds;
        uint32_t led_start_tick = i * led_delay_ticks;
        uint32_t led_end_tick = led_start_tick + led_delay_ticks;

        if (state->currentTick <= wave_duration_ticks) {
            if (state->currentTick >= led_start_tick && state->currentTick <= led_end_tick) {
                // Quadratic fade-in effect
                uint32_t elapsed_ticks = state->currentTick - led_start_tick;
                uint32_t progress = (elapsed_ticks * 255) / led_delay_ticks;
                uint32_t fade_brightness = (progress * progress) / 255; // Quadratic easing

                // Apply fade brightness to the target brightness
                leds_buffer[i].r = (r * fade_brightness) / 255;
                leds_buffer[i].g = (g * fade_brightness) / 255;
                leds_buffer[i].b = (b * fade_brightness) / 255;
            } else if (state->currentTick > led_end_tick) {
                // LED has already fully lit up
                leds_buffer[i].r = r;
                leds_buffer[i].g = g;
                leds_buffer[i].b = b;
            } else {
                // LED has not started fading in yet
                leds_buffer[i].r = 0;
                leds_buffer[i].g = 0;
                leds_buffer[i].b = 0;
            }
        } else {
            // Apply global fade factor during fade-out
            leds_buffer[i].r = r;
            leds_buffer[i].g = g;
            leds_buffer[i].b = b;
        }
    }

    // Update the LED strip
    int rc = led_strip_update_rgb(strip, leds_buffer, STRIP_NUM_PIXELS);
    if (rc) {
        LOG_ERR("Couldn't update strip: %d", rc);
    }
}

void ble_disconnected_tick(struct gamma_led_state *state) {
    float brightness = 0.0f;
    if (state->t01 < 0.5f) {
        brightness = remap(state->t01, 0.0f, 0.5f, 0.0f, 1.0f);
    } else {
        brightness = remap(state->t01, 0.5f, 1.0f, 1.0f, 0.0f);
    }
    int v = brightness * 255;
    buffer_all_leds_color(0, 0, v);

    update_leds();
}

void battery_charging_tick() {
    static uint32_t animation_tick = 0;
    animation_tick++;

    uint8_t soc = zmk_battery_state_of_charge(); // Get the state of charge (0-100%)
    buffer_all_leds_color(0, 0, 0);              // Clear all LEDs

    int num_leds = STRIP_NUM_PIXELS;
    int segment_size = 100 / num_leds; // Percentage per LED segment

    if (soc >= 95) {
        // Show all LEDs fully green at high SoC
        buffer_all_leds_color(0, 255, 0);
    } else {
        // Calculate fully charged segments and current segment progress
        int full_leds = soc / segment_size;   // Fully charged LEDs
        int segment_soc = soc % segment_size; // Remainder within the current segment

        // Set fully charged LEDs to green
        for (int i = 0; i < full_leds; i++) {
            buffer_single_led_color(i, 0, 255, 0);
        }

        // If there is a segment currently charging (not fully charged yet)
        if (full_leds < num_leds) {
            // t based on how far into the current segment we are (0 to 1)
            float t = (float)segment_soc / (float)segment_size;

            // Add a time-based component for animation
            // For example, cycle every ~100 ticks: adjust the 0.1f factor as desired for speed
            float time_factor = animation_tick * 0.004f;

            // Combine position-based t and time_factor for a continuous sine wave
            float brightness = 0.5f + 0.5f * sinf((t * M_PI * 2.0f) + time_factor);

            uint8_t value = (uint8_t)(brightness * 255);
            buffer_single_led_color(full_leds, 0, value, 0);
        }
    }

    update_leds(); // Update the LED strip
}

void ble_connected_tick(struct gamma_led_state *state) {
    float brightness = 0.0f;
    if (state->t01 < 0.8f) {
        brightness = remap(state->t01, 0.0f, 0.8f, 0.0f, 1.0f);
    } else {
        brightness = remap(state->t01, 0.8f, 1.0f, 1.0f, 0.0f);
    }
    int v = 255 * brightness;
    buffer_all_leds_color(0, 0, v);

    update_leds();
}

// static void low_battery_tick(struct gamma_led_state *state) {
//     buffer_all_leds_color(0, 0, 0);
//     buffer_single_led_color(0, 100, 0, 0);
//     update_leds();
// }

// static bool showingLowBattery;

// static void on_show_low_battery_complete() { showingLowBattery = false; }

// static void show_low_battery_animation() {
//     showingLowBattery = true;
//     struct gamma_led_state state = {};
//     state.onTick = low_battery_tick;
//     state.currentTick = 0;
//     state.onComplete = on_show_low_battery_complete;
//     state.durationInTicks = 500;
//     enqueue(&led_queue, state);
// }

static void gamma_tick(struct k_work *work) {
    if (((currentState.currentTick < currentState.durationInTicks) && currentState.onTick) ||
        dequeue(&led_queue, &currentState)) {
        if (currentState.onTick) {
            currentState.t01 = (float)currentState.currentTick / currentState.durationInTicks;
            currentState.onTick(&currentState);
            currentState.currentTick++;
            if (currentState.currentTick == currentState.durationInTicks) {
                if (currentState.onComplete) {
                    currentState.onComplete();
                }
            }
        }
    } else if (isPowered) {
        enable_led_power(true);
        battery_charging_tick();
    } else {
        update_leds_color(0, 0, 0);
        k_timer_stop(&gamma_tick_timer);
        enable_led_power(false);
        LOG_INF("Disable timer and led");
    }
}

static void show_ble_connected_animation() {
    LOG_INF("Show ble conn animation");
    struct gamma_led_state state = {};
    state.onTick = ble_connected_tick;
    state.onComplete = 0;
    state.currentTick = 0;
    state.durationInTicks = 300;
    enqueue(&led_queue, state);
}

static void show_ble_disconnected_animation();
static void check_for_connection() {
    if (isConnected) {
        show_ble_connected_animation();
    } else {
        show_ble_disconnected_animation();
    }
}

static void show_ble_disconnected_animation() {
    if (!isConnected) {
        LOG_INF("Show ble disconn animation");
        struct gamma_led_state state = {};
        state.onTick = ble_disconnected_tick;
        state.onComplete = check_for_connection;
        state.currentTick = 0;
        state.durationInTicks = 2500;
        enqueue(&led_queue, state);
    }
}

void show_startup_animation() {
    LOG_INF("Show startup");
    struct gamma_led_state state = {};
    state.onTick = startup_tick;
    state.onComplete = check_for_connection;
    state.currentTick = 0;
    state.durationInTicks = 2000;
    enqueue(&led_queue, state);
}

static void apds9960_timer_handler(struct k_timer *timer) {
    if (!device_is_ready(apds9960_dev)) {
        // If sensor is not ready, just exit silently (or log an error)
        LOG_INF("APDS9960 not ready:");
        return;
    }

    /* Trigger a new sample from the sensor. */
    LOG_INF("APDS9960 fetching...");
    int rc = sensor_sample_fetch(apds9960_dev);
    if (rc < 0) {
        LOG_ERR("APDS9960: sensor_sample_fetch failed (%d)", rc);
        return;
    }

    /* Read proximity data from the sensor. */
    LOG_INF("APDS9960 fetching proximity...");
    struct sensor_value prox;
    rc = sensor_channel_get(apds9960_dev, SENSOR_CHAN_PROX, &prox);
    if (rc < 0) {
        LOG_ERR("APDS9960: sensor_channel_get failed (%d)", rc);
        return;
    }

    /*
     * Usually prox.val1 holds the proximity reading.
     * The driver returns an integer range 0..255, or 0..1023, depending on the driver specifics.
     */
    LOG_INF("APDS9960 prox: %d", prox.val1);
}

/* Define the timer (single shot or repeated) */
K_TIMER_DEFINE(apds9960_timer, apds9960_timer_handler, NULL);

static void gamma_init_delayed() {
    k_msleep(10);
    LOG_INF("Init delayed");
    // NOTE(sqd): This will prevent first led tick from freezing for a while
    // (ZMK does something heavy on startup?)

    LOG_INF("Init queue");
    init_queue(&led_queue);
    show_startup_animation();

    if (!device_is_ready(apds9960_dev)) {
        LOG_ERR("APDS9960 not ready");
    } else {
        // Start timer to trigger every 100 ms
        LOG_INF("APDS9960 timer started (500 ms).");
        k_timer_start(&apds9960_timer, K_MSEC(500), K_MSEC(500));
    }

    // update_leds_color(0, 0, 0);
}

K_WORK_DEFINE(gamma_init_delayed_work, gamma_init_delayed);

static int gamma_init(void) {
    LOG_INF("Gamma init");
    showBattery = false;

    if (device_is_ready(strip)) {
        LOG_INF("Found LED strip device %s", strip->name);
    } else {
        LOG_ERR("LED strip device %s is not ready", strip->name);
    }

    int ret = gpio_pin_configure_dt(&led_enable, GPIO_OUTPUT);
    if (ret < 0) {
        printk("Error %d: failed to configure LED pin\n", ret);
    }

    enable_led_power(false);

    if (!device_is_ready(charging_status.port)) {
        printk("Error: Charging status GPIO device not ready.\n");
    }

    ret = gpio_pin_configure_dt(&charging_status, GPIO_INPUT);
    if (ret < 0) {
        printk("Error: Failed to configure charging status GPIO (%d).\n", ret);
    }

    k_work_submit_to_queue(zmk_workqueue_lowprio_work_q(), &gamma_init_delayed_work);

    return 0;
}

static float calc_fade_in_factor(struct gamma_led_state *state) {
    float factor = (float)state->currentTick / (float)state->durationInTicks;
    return factor > 1.0f ? 1.0f : factor;
}

static float calc_fade_out_factor(struct gamma_led_state *state) {
    float factor = 1.0f - (float)state->currentTick / (float)state->durationInTicks;
    return factor < 0.0f ? 0.0f : factor;
}

static void show_battery_fade_in_tick(struct gamma_led_state *state) {
    uint8_t soc = zmk_battery_state_of_charge();
    struct led_rgb temp_buffer[STRIP_NUM_PIXELS];
    soc_to_led_buffer(soc, temp_buffer);

    float fade_factor = calc_fade_in_factor(state);
    for (int i = 0; i < STRIP_NUM_PIXELS; i++) {
        leds_buffer[i].r = (uint8_t)(temp_buffer[i].r * fade_factor);
        leds_buffer[i].g = (uint8_t)(temp_buffer[i].g * fade_factor);
        leds_buffer[i].b = (uint8_t)(temp_buffer[i].b * fade_factor);
    }
    update_leds();
}

static void show_battery_fade_out_tick(struct gamma_led_state *state) {
    uint8_t soc = zmk_battery_state_of_charge();
    struct led_rgb temp_buffer[STRIP_NUM_PIXELS];
    soc_to_led_buffer(soc, temp_buffer);

    float fade_factor = calc_fade_out_factor(state);
    for (int i = 0; i < STRIP_NUM_PIXELS; i++) {
        leds_buffer[i].r = (uint8_t)(temp_buffer[i].r * fade_factor);
        leds_buffer[i].g = (uint8_t)(temp_buffer[i].g * fade_factor);
        leds_buffer[i].b = (uint8_t)(temp_buffer[i].b * fade_factor);
    }
    update_leds();
}

static void show_battery_static_tick() {
    uint8_t soc = zmk_battery_state_of_charge();
    soc_to_led_buffer(soc, leds_buffer);
    update_leds();
}

static void check_show_battery_animation();

static void start_show_battery_animation() {
    struct gamma_led_state state = {};
    state.onTick = show_battery_fade_in_tick;
    state.currentTick = 0;
    state.onComplete = check_show_battery_animation;
    state.durationInTicks = 100;
    enqueue(&led_queue, state);
}

static void keep_show_battery_animation() {
    struct gamma_led_state state = {};
    state.onTick = show_battery_static_tick;
    state.currentTick = 0;
    state.onComplete = check_show_battery_animation;
    state.durationInTicks = 1;
    enqueue(&led_queue, state);
}

static void on_hide_battery() { showBatteryDisplay = false; }

static void hide_show_battery_animation() {
    struct gamma_led_state state = {};
    state.onTick = show_battery_fade_out_tick;
    state.currentTick = 0;
    state.onComplete = on_hide_battery;
    state.durationInTicks = 100;
    enqueue(&led_queue, state);
}

static void check_show_battery_animation() {
    if (showBattery) {
        keep_show_battery_animation();
    } else {
        hide_show_battery_animation();
    }
}

void show_battery() {
    if (!isPowered) {
        showBattery = true;
        if (!showBatteryDisplay) {
            showBatteryDisplay = true;
            start_show_battery_animation();
        }
    }
}
void hide_battery() { showBattery = false; }

static int gamma_event_listener(const zmk_event_t *eh) {
    if (as_zmk_split_peripheral_status_changed(eh)) {
        bool newConnected = zmk_split_bt_peripheral_is_connected();
        LOG_INF("BLE EVENT %i ", isConnected);
        if (newConnected != isConnected) {
            isConnected = newConnected;
            if (isConnected) {
                show_ble_connected_animation();
            } else {
                show_ble_disconnected_animation();
            }
        }
    }
    if (as_zmk_usb_conn_state_changed(eh)) {
        LOG_INF("USB CONN EVENT");
        isPowered = zmk_usb_is_powered();

        if (isPowered) {
            enable_led_power(true);
            k_timer_start(&gamma_tick_timer, K_NO_WAIT, K_MSEC(1));
        }
    }

    return 0;
}

ZMK_LISTENER(gamma_board, gamma_event_listener);

ZMK_SUBSCRIPTION(gamma_board, zmk_activity_state_changed);
ZMK_SUBSCRIPTION(gamma_board, zmk_battery_state_changed);
ZMK_SUBSCRIPTION(gamma_board, zmk_split_peripheral_status_changed);
#if IS_ENABLED(CONFIG_USB_DEVICE_STACK)
ZMK_SUBSCRIPTION(gamma_board, zmk_usb_conn_state_changed);
#endif /* IS_ENABLED(CONFIG_USB_DEVICE_STACK) */

// TODO(sqd): Non-dongle mode with animations and stuff
#if false
static int gamma_ble_event_listener(const zmk_event_t *eh) {
    LOG_INF("BLE EVENT");

    return 0;
}
ZMK_LISTENER(gamma_ble_listener, gamma_ble_event_listener);
ZMK_SUBSCRIPTION(gamma_ble_listener, zmk_ble_active_profile_changed);
ZMK_SUBSCRIPTION(gamma_ble_listener, zmk_endpoint_changed);

#endif

SYS_INIT(gamma_init, APPLICATION, CONFIG_APPLICATION_INIT_PRIORITY);
#endif
