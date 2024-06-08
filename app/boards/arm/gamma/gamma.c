#ifndef CONFIG_BOARD_GAMMA_DONGLE
#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/bluetooth/conn.h>
#include <zephyr/drivers/i2c.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/gpio.h>
#include <zmk/events/keycode_state_changed.h>

#include <zephyr/bluetooth/services/bas.h>

#include <zephyr/logging/log.h>
LOG_MODULE_DECLARE(zmk, CONFIG_ZMK_LOG_LEVEL);

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

#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/drivers/pwm.h>
#include <zmk/workqueue.h>

#define NUM_STEPS 200
#define SLEEP_MSEC 2
#define ArrayCount(Array) (sizeof(Array) / sizeof((Array)[0]))

static const struct gpio_dt_spec led188_1 = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led188_1), gpios, {0});
static const struct gpio_dt_spec led188_2 = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led188_2), gpios, {0});
static const struct gpio_dt_spec led188_3 = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led188_3), gpios, {0});
static const struct gpio_dt_spec led188_4 = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led188_4), gpios, {0});
static const struct gpio_dt_spec led188_5 = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led188_5), gpios, {0});
static const struct gpio_dt_spec charging_enable =
    GPIO_DT_SPEC_GET_OR(DT_NODELABEL(chrg_enable), gpios, {0});
static const struct gpio_dt_spec charging_status =
    GPIO_DT_SPEC_GET_OR(DT_NODELABEL(chrg_status), gpios, {0});

static const struct gpio_dt_spec led188[] = {led188_1, led188_2, led188_3, led188_4, led188_5};
// uint32_t ledCache[ArrayCount(led188)];

#define HIGH GPIO_OUTPUT_ACTIVE
#define LOW GPIO_OUTPUT_INACTIVE
#define NO GPIO_DISCONNECTED

#include "digits.h"

static void set_pin(uint32_t index, uint32_t val) {
    // uint32_t cached = ledCache[index];
    // if (cached != val) {
    struct gpio_dt_spec pin = led188[index];

    // bool configure = (cached == NO && (val == HIGH || val == LOW)) ||
    // ((cached == HIGH || cached == LOW) && val == NO);

    //         if (configure) {
    gpio_pin_configure_dt(&pin, val);
    // } else {
    //     gpio_pin_set_dt(&pin, val == HIGH ? 1 : 0);
    // }

    // ledCache[index] = val;
    // }
}

// static void display_charging() {

//     const struct segment_info segs[] = {c1, b1, a2, a3, b3, c3, d3, d2};
//     for (int i = 0; i < ArrayCount(segs); i++) {
//         struct segment_info seg = segs[i];

//         for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
//             set_pin(ledPinIndex, NO);
//         }

//         for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
//             uint32_t val = NO;
//             if (ledPinIndex == seg.high - 1) {
//                 val = HIGH;
//             } else if (ledPinIndex == seg.low - 1) {
//                 val = LOW;
//             }
//             set_pin(ledPinIndex, val);
//         }

//         k_msleep(50);
//     }
// }

static void disable_all_leds() {
    for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
        set_pin(ledPinIndex, NO);
    }
}

volatile int cycle;
volatile int displayInt;

static void display_digit(uint16_t digit) {
    int maxSegments = ArrayCount(segments);
    int litSegmentTimeUsec = 50;
    int segmentsLit = 0;
    for (int i = 0; i < ArrayCount(segments); i++) {
        uint16_t mask = (1 << i);
        bool isSegmentSet = (mask & digit) == mask;

        if (isSegmentSet) {
            struct segment_info seg = segments[i];

            for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
                struct gpio_dt_spec pin = led188[ledPinIndex];
                uint32_t val = NO;
                if (ledPinIndex == seg.high - 1) {
                    val = HIGH;
                } else if (ledPinIndex == seg.low - 1) {
                    val = LOW;
                }
                set_pin(ledPinIndex, val);
            }

            k_usleep(litSegmentTimeUsec);
            disable_all_leds();
            segmentsLit++;
        }
    }
    k_usleep((maxSegments - segmentsLit) * litSegmentTimeUsec);
}

volatile bool showBattery;

static void my_led_work(void) {
    // TODO(sqd): Rewrite to events
    while (1) {
        bool charged = gpio_pin_get_dt(&charging_status);
        uint32_t connStatus = zmk_usb_get_conn_state();
        bool isConnected = zmk_split_bt_peripheral_is_connected();
        bool isPowered = zmk_usb_is_powered();

        if (showBattery) {
            uint8_t charge = zmk_battery_state_of_charge();
            display_digit(digits188[charge]);
        } else {
            if (isPowered) {
                if (charged) {
                    display_digit(digits188[100]);
                } else {
                    display_digit(digit_xCh);
                }
            } else {
                if (isConnected) {
                    k_msleep(50);
                } else {
                    display_digit(digit_xbt);
                }
            }
        }
    }
}

static void my_init_work(void) {
    gpio_pin_configure_dt(&charging_enable, GPIO_OUTPUT_ACTIVE);
    gpio_pin_configure_dt(&charging_status, GPIO_INPUT);
    showBattery = false;
}

void show_battery() { showBattery = true; }
void hide_battery() { showBattery = false; }

#define MY_STACK_SIZE 1024
#define MY_PRIORITY 5

K_THREAD_DEFINE(tid1, MY_STACK_SIZE, my_init_work, NULL, NULL, NULL, MY_PRIORITY + 0, 0, 0);
K_THREAD_DEFINE(tid2, MY_STACK_SIZE, my_led_work, NULL, NULL, NULL, MY_PRIORITY + 1, 0, 0);

/*static int led_init(const struct device *_arg){};*/

/*SYS_INIT(led_init, APPLICATION, CONFIG_APPLICATION_INIT_PRIORITY);*/
#endif
