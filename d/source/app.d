import gpio;
import freertos;

int main()
{
	//~ import std.stdio;
	//~ writeln("Entering into D main()");

	gpio_setup();

	xTaskCreate(
		&blinkTask,
		cast(const(char*)) "LED Blink",
		32, // usStackDepth
		null, // *pvParameters
		1, // uxPriority
		null // task handler
	);

	vTaskStartScheduler();

	// Will not get here unless there is insufficient RAM
	return 1;
}

extern(C) void blinkTask(void *pvParametres) @nogc nothrow
{
	gpio_toggle(GPIOB, GPIO1);

	vTaskDelay(500);
}

extern(C) __gshared string[] rt_options = [ "gcopt=minPoolSize:512B maxPoolSize:2048B incPoolSize:128B" ];
