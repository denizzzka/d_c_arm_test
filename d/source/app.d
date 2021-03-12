import libopencm3;
import freertos;

int main()
{
    import drivers.max7219;

    auto display = new MAX7219Display(4);

    display.testBlink();

    import martian: IELFont;

    IELFont[8 * 2] nums_rows;

    with(IELFont)
    nums_rows = [
        _0, _1, _2, _3, _4, _5, _6, _7,
        _8, _9, _0, _1, _2, _3, _4, _5,
    ];

    display.buf[0 .. display.buf.length] = cast(ubyte[]) nums_rows[0 .. $];

    //~ display.buf[0 .. $] = 0;
    //~ display.buf[curr .. curr + str.length] = str[0 .. $];

    while(true)
    {
        display.refreshImageFromBuffer();

        vTaskDelay(200);
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
