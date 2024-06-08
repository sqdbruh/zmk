#if CONFIG_BOARD_GAMMA_DONGLE
#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>
#include <zmk/split/bluetooth/central.h>
#include <zephyr/drivers/pwm.h>

// static const struct gpio_dt_spec led_r = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led_red), gpios, {0});
// static const struct gpio_dt_spec led_g = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led_green), gpios, {0});
// static const struct gpio_dt_spec led_b = GPIO_DT_SPEC_GET_OR(DT_NODELABEL(led_blue), gpios, {0});
static const struct pwm_dt_spec pwm_led0 = PWM_DT_SPEC_GET(DT_ALIAS(pwm_led0));
static const struct pwm_dt_spec pwm_led1 = PWM_DT_SPEC_GET(DT_ALIAS(pwm_led1));
static const struct pwm_dt_spec pwm_led2 = PWM_DT_SPEC_GET(DT_ALIAS(pwm_led2));

#define NUM_STEPS	20U
#define SLEEP_MSEC	25U

uint32_t step;
uint32_t dir;
uint32_t pulse_width;

void led_step(const struct pwm_dt_spec* spec, uint32_t maxPeriod) {
    pwm_set_pulse_dt(spec, pulse_width);
}

static void my_led_work(void) {
    while (1) {
        int connectedCount = count_connected_peripherals();
        if (connectedCount == 0) {
            pwm_set_pulse_dt(&pwm_led0, pulse_width);
            pwm_set_pulse_dt(&pwm_led1, 0);
            pwm_set_pulse_dt(&pwm_led2, 0);
        } else if (connectedCount == 1) {
            pwm_set_pulse_dt(&pwm_led0, pulse_width);
            pwm_set_pulse_dt(&pwm_led1, pulse_width / 4);
            pwm_set_pulse_dt(&pwm_led2, 0);
        } else if (connectedCount == 2) {
            pwm_set_pulse_dt(&pwm_led0, 0);
            pwm_set_pulse_dt(&pwm_led1, pwm_led1.period);
            pwm_set_pulse_dt(&pwm_led2, 0);
        }


        if (dir) {
            pulse_width += step;
            if (pulse_width >= pwm_led0.period) {
                pulse_width = pwm_led0.period - step;
                dir = 0U;
            }
        } else {
            if (pulse_width >= step) {
                pulse_width -= step;
            } else {
                pulse_width = step;
                dir = 1U;
            }
        }

        k_sleep(K_MSEC(SLEEP_MSEC));
    }
}

static void my_init_work(void) {
	pulse_width = 0U;
	step = pwm_led0.period / NUM_STEPS;
	dir = 1U;
}

#define MY_STACK_SIZE 1024
#define MY_PRIORITY 5

K_THREAD_DEFINE(tid2, MY_STACK_SIZE, my_led_work, NULL, NULL, NULL, MY_PRIORITY, 0, 0);
K_THREAD_DEFINE(tid1, MY_STACK_SIZE, my_init_work, NULL, NULL, NULL, MY_PRIORITY, 0, 0);
#endif
