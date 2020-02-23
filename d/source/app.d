extern(C) __gshared void _d_dso_registry(void* arg) {}

import gpio;
import freertos;

export extern(C) int main()
{
	gpio_setup();

	//~ vInitSystem();

	xTaskCreate(
		&blinkTask,
		cast(const(char*)) "LED Blink",
		32, // usStackDepth
		null, // *pvParameters
		1, // uxPriority
		null // task handler
	);

	return 0;
}

extern(C) void blinkTask(void *pvParametres)
{
	gpio_toggle(GPIOB, GPIO1);

	vTaskDelay(500);
}
