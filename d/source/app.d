import libopencm3;
import freertos;

int main()
{
    import drivers.max7219;

    auto display = new MAX7219Display(4);

    display.testBlink();

    import martian: IELFont;

    IELFont[] chars;

    with(IELFont)
    chars = [
        _0, _1, _2, _3, _4, _5, _6, _7, _8, _9,
        А, Б, В, Г, Д, Е, Ж, З, И, Й, К, Л, М, Н, О, П,
        Р, С, Т, У, Ф, Х, Ц, Ч, Ш, Щ, Ы, Ь, Э, Ю, Я,
    ];

    //~ display.buf[0 .. $] = 0;
    //~ display.buf[curr .. curr + str.length] = str[0 .. $];
    int curr;
    int incr = 8*2;

    while(true)
    {
        display.buf[0 .. display.buf.length] = cast(ubyte[]) chars[curr .. curr + incr];
        display.refreshImageFromBuffer();

        vTaskDelay(2000);

        curr += incr;
        if(curr >= chars.length)
            curr = 0;
    }
}

extern(C) void blinkTask(void *pvParametres) @nogc nothrow
{
    gpio_toggle(GPIO_PORT_B_BASE, GPIO1);

    vTaskDelay(500);
}

// Init FreeRTOS main task stack size:
import ldc.attributes;

@section(".init_array")
immutable initMainStackSize_ptr = &initMainStackSize;

void initMainStackSize()
{
    import external.rt.dmain: mainTaskProperties;

    mainTaskProperties.taskStackSizeWords = 25 * 1024 / 4;
}
