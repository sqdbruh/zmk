#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/i2c.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/gpio.h>
#include <zmk/events/keycode_state_changed.h>

#include <zephyr/bluetooth/services/bas.h>

#include <zephyr/logging/log.h>
LOG_MODULE_DECLARE(zmk, CONFIG_ZMK_LOG_LEVEL);

#include <zmk/ble.h>
#include <zmk/usb.h>
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

#define HIGH GPIO_OUTPUT_ACTIVE
#define LOW GPIO_OUTPUT_INACTIVE
#define NO GPIO_DISCONNECTED

#include "digits.h"

static void display_charging() {

    const struct segment_info segs[] = {c1, b1, a2, a3, b3, c3, d3, d2};
    for (int i = 0; i < ArrayCount(segs); i++) {
        struct segment_info seg = segs[i];

        for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
            struct gpio_dt_spec pin = led188[ledPinIndex];
            gpio_pin_configure_dt(&pin, NO);
        }

        for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
            struct gpio_dt_spec pin = led188[ledPinIndex];
            uint32_t val = NO;
            if (ledPinIndex == seg.high - 1) {
                val = HIGH;
            } else if (ledPinIndex == seg.low - 1) {
                val = LOW;
            }
            gpio_pin_configure_dt(&pin, val);
        }

        k_msleep(50);
    }
}

static void display_int(int val) {
    uint16_t digit = digits188[val];
    for (int i = 0; i < ArrayCount(segments); i++) {
        uint16_t mask = (1 << i);
        bool isSegmentSet = (mask & digit) == mask;

        if (isSegmentSet) {
            struct segment_info seg = segments[i];

            for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
                struct gpio_dt_spec pin = led188[ledPinIndex];
                gpio_pin_configure_dt(&pin, NO);
            }

            for (int ledPinIndex = 0; ledPinIndex < ArrayCount(led188); ledPinIndex++) {
                struct gpio_dt_spec pin = led188[ledPinIndex];
                uint32_t val = NO;
                if (ledPinIndex == seg.high - 1) {
                    val = HIGH;
                } else if (ledPinIndex == seg.low - 1) {
                    val = LOW;
                }
                gpio_pin_configure_dt(&pin, val);
            }

            k_usleep(100);
        }
    }
}

volatile int cycle;
volatile int displayInt;

static void my_led_work(void) {
    while (1) {
        int val = gpio_pin_get_dt(&charging_status);
        uint8_t charge = zmk_battery_state_of_charge();
        display_int(charge);
        // cycle += 1;
        // if (cycle > 200) {
        //     displayInt++;
        //     if (displayInt > 188) {
        //         displayInt = 0;
        //     }
        //     cycle = 0;
        // }
    }
}

static void my_init_work(void) {
    gpio_pin_configure_dt(&charging_enable, GPIO_OUTPUT_ACTIVE);
    gpio_pin_configure_dt(&charging_status, GPIO_INPUT);
}

#define MY_STACK_SIZE 1024
#define MY_PRIORITY 5

K_THREAD_DEFINE(tid2, MY_STACK_SIZE, my_led_work, NULL, NULL, NULL, MY_PRIORITY, 0, 0);
K_THREAD_DEFINE(tid1, MY_STACK_SIZE, my_init_work, NULL, NULL, NULL, MY_PRIORITY, 0, 0);

/*static int led_init(const struct device *_arg){};*/

/*SYS_INIT(led_init, APPLICATION, CONFIG_APPLICATION_INIT_PRIORITY);*/
