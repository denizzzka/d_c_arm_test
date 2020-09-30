import gpio;
import freertos;

int main()
{
	malloc_stats();

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

extern(C) __gshared string[] rt_options = [ "gcopt=minPoolSize:128B maxPoolSize:2M incPoolSize:512B" ];

//~ extern (C) bool logUnwinding() //FIXME: remove it
//~ {
	//~ return true;
//~ }

extern(C) void malloc_stats();
