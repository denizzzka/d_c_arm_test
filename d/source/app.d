import libopencm3;
import freertos;
import martian: IELFont;

/// Converts one martian string to buffer
/// (Display contains two martian strings)
// TODO: reuse return buffer
ref ubyte[8*2] martian2bytes(ref return ubyte[8*2] ret, IELFont[8] str, bool setMinus = false)
{
    import std.bitmanip: nativeToLittleEndian;

    foreach(i, c; str)
    {
        // First displaying symbols started from half of buffer (PCB bug)
        auto curr = i + ((i < 4) ? 4 : -4);
        curr += curr; // convert position to  offset

        ret[curr .. curr + 2] = nativeToLittleEndian(c);
        ret[curr] &= ~0b10000000; // clean special segment

        // Handling left decimal dots as parts of characters
        if(c & 0b10000000) // left dot is set in this symbol?
        {
            if(i == 0)
            {
                // most left dot of most left symbol
                ret[curr] |= 0b10000000;
            }
            else
            {
                // 5 symbol needs to use first symbol's right dot as left dot
                if(i == 4)
                    ret[8+7] |= 0b10000000; // enables right dot
                else
                {
                    // all other cases use decimal point of previous symbol as left dot
                    ret[curr-1] |= 0b10000000;
                }
            }
        }

        if(setMinus)
            ret[8+4] |= 0b10000000;
    }

    return ret;
}

int main()
{
    import drivers.max7219;

    auto display = new MAX7219Display(4);

    display.setIntensity(0b10);
    display.testBlink();
    display.setIntensity(0b1111);

    IELFont[] chars;

    with(IELFont)
    chars = [
        Д, space, Д, space, Д, space, Д, space,
        space, Д, space, Д, space, Д, space, Д,

        space, Д, space, Д, space, Д, space, Д,
        Д, space, Д, space, Д, space, Д, space,

        Д, space, Д, space, Д, space, Д, space,
        space, Д, space, Д, space, Д, space, Д,

        _0, _1, _2, _3, _4, _5, _6, _7, _8, _9,
        А, Б, В, Г, Д, Е, Ж, З, И, Й, К, Л, М, Н, О, П,
        Р, С, Т, У, Ф, Х, Ц, Ч, Ш, Щ, Ы, Ь, Э, Ю, Я,
    ];

    int curr;
    int incr = 8;
    bool displayMinus;

    while(true)
    {
        martian2bytes(display.buf[ 0 .. 16], chars[curr .. curr + incr][0..8], displayMinus);
        curr += incr;
        martian2bytes(display.buf[16 .. 32], chars[curr .. curr + incr][0..8], displayMinus);
        curr += incr;

        displayMinus = !displayMinus;

        display.refreshImageFromBuffer();

        vTaskDelay(2000);

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
