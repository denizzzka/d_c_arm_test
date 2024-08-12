module main;

import esp_idf_binding;

enum CONFIG_FREERTOS_HZ = 1000;
enum portTICK_PERIOD_MS = 1000 / CONFIG_FREERTOS_HZ;
enum CONFIG_BLINK_PERIOD = 20;

enum BLINK_GPIO = gpio_num_t.GPIO_NUM_12; // LuatOS ESP32-C3 Development Board (CORE-ESP32)

void configure_led() nothrow
{
    gpio_reset_pin(BLINK_GPIO);

    /* Set the GPIO as a push/pull output */
    gpio_set_direction(BLINK_GPIO, gpio_mode_t.GPIO_MODE_OUTPUT);
}

extern(C) export void d_app_main() nothrow
{
    configure_led();
    ubyte s_led_state = 0;

    while (1) {
        gpio_set_level(BLINK_GPIO, s_led_state);

        s_led_state = !s_led_state;
        vTaskDelay(CONFIG_BLINK_PERIOD / portTICK_PERIOD_MS);
    }
}
