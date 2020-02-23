//import std.stdio;

//extern(C) void vApplicationTickHook();

//~ extern(C) void reset_handler()
//~ {}

// Place the FreeRTOS System Calls first in the unprivileged region.
//~ extern(C) int* __syscalls_flash_start__ = rom;

extern(C) __gshared void _d_dso_registry(void* arg) {}

import gpio;
import freertos;

export extern(C) int main()
{
	gpio_setup();

	//~ vInitSystem();

	//~ xTaskCreate(
		//~ &blinkTask, 
		//~ cast (byte*) "LED Blink",
		//~ 32, // usStackDepth
		//~ null, // *pvParameters
		//~ 1, // uxPriority
		//~ null // task handler
	//~ );

	return 0;
}

extern(C) void blinkTask(void *pvParametres)
{
	gpio_toggle(GPIOB, GPIO1);

	//~ vTaskDelay(1000);
}
