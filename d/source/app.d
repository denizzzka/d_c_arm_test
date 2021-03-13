import libopencm3;
import freertos;
import martian: MartianChar, capitalizedSymbol2martian;

enum Sign
{
    None,
    Minus,
    Plus,
}

/// Converts one martian string to buffer
/// (Display contains two martian strings)
// TODO: reuse return buffer
ref ubyte[8*2] martian2bytes(ref return ubyte[8*2] ret, MartianChar[8] str, Sign sign = Sign.None, ubyte delimMask = 0b000)
{
    import std.bitmanip: nativeToLittleEndian;

    foreach(i, c; str)
    {
        const curr = i+i;

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

        if(sign == Sign.Minus)
            ret[4] |= 0b10000000;

        if(sign == Sign.Plus)
        {
            ret[4] |= 0b10000000;
            ret[2] |= 0b10000000;
        }

        // Left ":" symbol
        if(delimMask & 0b100)
            ret[6] |= 0b10000000;

        // Center ":" symbol
        if(delimMask & 0b010)
            ret[8+4] |= 0b10000000;

        // Right ":" symbol
        if(delimMask & 0b001)
            ret[8+6] |= 0b10000000;
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

    immutable wstring str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";

    MartianChar[str.length] chars;
    foreach(i, c; str)
        chars[i] = c.capitalizedSymbol2martian;

    int curr;
    int incr = 8;
    bool displaySign;

    while(true)
    {
        martian2bytes(display.buf[ 0 .. 16], chars[curr .. curr + incr][0..8], displaySign ? Sign.Minus : Sign.None, 0b010);
        curr += incr;
        martian2bytes(display.buf[16 .. 32], chars[curr .. curr + incr][0..8], displaySign ? Sign.Plus : Sign.None, 0b101);
        curr += incr;

        displaySign = !displaySign;

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
