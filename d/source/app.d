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

MartianChar[] string2martian(in wchar[] str)
{
    MartianChar[] ret;
    ret.length = str.length;

    foreach(i, c; str)
        ret[i] = c.capitalizedSymbol2martian;

    return ret;
}

class MartianYautjaDisplay
{
    import drivers.max7219;

    private MAX7219Display hwDisp;

    this()
    {
        hwDisp = new MAX7219Display(4);

        hwDisp.setIntensity(0b10);
        hwDisp.testBlink();
        hwDisp.setIntensity(0b1111);
    }

    void setRow(bool isUpperRow, in MartianChar[8] chars, Sign sign = Sign.None, ubyte delimMask = 0b000)
    {
        ubyte[] bufSlice = isUpperRow ? (hwDisp.buf[16 .. 32]) : (hwDisp.buf[0 .. 16]);

        // decodes chars with left decimal points for some letters and sets sign
        martian2bytes(bufSlice[0 .. 16], chars, sign, delimMask);
    }

    void refresh()
    {
        hwDisp.refreshImageFromBuffer();
    }
}

struct FloatingText
{
    const MartianChar[] text;
    int speed = 1;
    private int pos;

    this(wstring s)
    {
        text = string2martian(s);
    }

    enum DispSize = 8;

    const(MartianChar[DispSize]) getDisplayBuf() const
    {
        return text[pos .. pos + DispSize][0 .. DispSize];
    }

    void step()
    {
        pos += speed;

        if(pos >= text.length - DispSize)
            speed = -abs(speed);
        else if(pos <= 0)
            speed = abs(speed);
    }
}

private int abs(int x) pure
{
    if(x < 0)
        return -x;
    else
        return x;
}

struct Content
{
    MartianChar[8] str;
    Sign sign;
    ubyte delimMask;
}

abstract class ContentBase
{
    private static MartianYautjaDisplay display;
    private static ContentBase[] list;
    private static size_t currContentIdx;

    this()
    {
        list ~= this;
    }

    protected abstract const(Content) getUpperRow();
    protected abstract const(Content) getBottomRow();

    static void renderAndSendUpdateToDisplay()
    {
        auto curr = list[currContentIdx];

        const up = curr.getUpperRow();
        const bottom = curr.getBottomRow();

        display.setRow(true, up.str, up.sign, up.delimMask);
        display.setRow(false, bottom.str, bottom.sign, bottom.delimMask);

        display.refresh();
    }

    protected abstract void step(float dt);

    static void performStep(float dt)
    {
        foreach(item; list)
            item.step(dt);
    }

    static void switchContent()
    {
        currContentIdx++;

        if(currContentIdx >= list.length)
            currContentIdx = 0;
    }
}

static this()
{
    ContentBase.display = new MartianYautjaDisplay;
}

class Clock : ContentBase
{
    private Content upCont;
    private Content downCont;

    this()
    {
        upCont.str = string2martian(" ВРЕМЯ  ");
        upCont.delimMask = 0b001;
    }

    override const(Content) getUpperRow()
    {
        return upCont;
    }

    override const(Content) getBottomRow()
    {
        downCont.str = string2martian("  214356");

        return downCont;
    }

    override void step(float dt)
    {
        static float seconds = 0;

        seconds += dt;

        if(seconds >= 0.5)
            downCont.delimMask = 0b011;
        else
            downCont.delimMask = 0;

        if(seconds >= 1)
            seconds = 0;
    }
}


class Stopwatch : ContentBase
{
    private Content upCont;
    private Content downCont;

    this()
    {
        upCont.str = string2martian("ОТСЧЁТ  ");
        upCont.delimMask = 0b001;

        downCont.delimMask = 0b111;
    }

    override const(Content) getUpperRow()
    {
        return upCont;
    }

    override const(Content) getBottomRow()
    {
        return downCont;
    }

    override void step(float dt)
    {
        static float counter = 0;

        counter += dt;

        //~ import std.conv: to; //FIXME: enable Phobos library

        //~ downCont.str = string2martian(counter.to!wstring);
    }
}

class Weather : ContentBase
{
    private Content upCont;
    private Content downCont;

    this()
    {
        upCont.str = string2martian("  ПОГОДА");
    }

    override const(Content) getUpperRow()
    {
        return upCont;
    }

    override const(Content) getBottomRow()
    {
        return downCont;
    }

    override void step(float dt)
    {
        static float seconds = 0;

        seconds += dt;

        if(seconds >= 2)
        {
            downCont.sign = Sign.Plus;
            downCont.str = string2martian("27 ДНЁМ ");
        }
        else
        {
            downCont.sign = Sign.Minus;
            downCont.str = string2martian("16 НОЧЬЮ");
        }

        if(seconds >= 4)
            seconds = 0;
    }
}

int main()
{
    //~ auto floatingText = FloatingText("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ");
        //~ floatingText.step();

    new Clock;
    new Stopwatch;
    new Weather;

    float switchDelay = 0;

    import core.time;
    TickDuration prevTick = TickDuration.currSystemTick();

    while(true)
    {
        auto currTick = TickDuration.currSystemTick();
        float dt = 1.0f * (currTick - prevTick).msecs() / 1000;

        ContentBase.performStep(dt);

        prevTick = currTick;

        switchDelay += dt;

        if(switchDelay >= 5)
        {
            switchDelay = 0;
            ContentBase.switchContent();
        }

        ContentBase.renderAndSendUpdateToDisplay();

        import core.memory: GC;
        GC.collect();

        vTaskDelay(20);
    }
}

// Init FreeRTOS main task stack size:
import ldc.attributes;

@section(".init_array")
immutable initMainStackSize_ptr = &initMainStackSize;

void initMainStackSize()
{
    import external.rt.dmain: mainTaskProperties;

    mainTaskProperties.taskStackSizeWords = 10 * 1024 / 4;
}
