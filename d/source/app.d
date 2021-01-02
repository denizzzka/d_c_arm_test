import libopencm3;
import freertos;

int main()
{
	//~ blink_gpio_setup();

	//~ xTaskCreate(
		//~ &blinkTask,
		//~ cast(const(char*)) "LED Blink",
		//~ 32, // usStackDepth
		//~ null, // *pvParameters
		//~ 1, // uxPriority
		//~ null // task handler
	//~ );

	initDisplay();

	while(true)
	{
		sendToSegmentDisplay(SegmentCmd.DisplayTest, 0b1);
		vTaskDelay(500);
		sendToSegmentDisplay(SegmentCmd.DisplayTest, 0);
		vTaskDelay(500);
	}
}

extern(C) void blinkTask(void *pvParametres) @nogc nothrow
{
	gpio_toggle(GPIO_PORT_B_BASE, GPIO1);

	vTaskDelay(500);
}

enum SegmentCmd : ubyte
{
	NoOp = 0,
	DecodeMode =  0b1001,
	Intensity =   0b1010,
	ScanLimit =   0b1011,
	Shutdown =    0b1100,
	DisplayTest = 0b1111,
}

void initDisplay()
{
	spi_setup();

	// display all digits
	sendToSegmentDisplay(SegmentCmd.ScanLimit, 0b111);

	// set maximum intensity
	sendToSegmentDisplay(SegmentCmd.Intensity, 0b1111);
}

private void sendToSegmentDisplay(SegmentCmd code, ubyte data)
{
	ushort arg = cast(ushort) code << 8 | data;

	sendDataToSegmentDisplay(arg);
}

shared static this()
{
	import external.rt.dmain: mainTaskProperties;

	mainTaskProperties.taskStackSizeWords = 128;
}
