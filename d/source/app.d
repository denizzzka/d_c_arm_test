import libopencm3;
import freertos;

int main()
{
    initDisplay();

    foreach(_; 0 .. 3)
    {
        sendToWholeSegmentDisplay(SegmentCmd.DisplayTest, 0b1);

        vTaskDelay(500);

        sendToWholeSegmentDisplay(SegmentCmd.DisplayTest, 0);

        vTaskDelay(500);
    }

    //~ string s = "dLAnG-2021";

    ubyte[allDisplaysSize] buf;
    ubyte[] str;

    with(Segment7Font)
    str = [d,L,A,n,G,dash,_2,_0,_2,_1]; //dLAnG-2021
    //~ str = [dash]; //dLAnG-2021

    byte curr;
    byte increment = 1;

    ubyte*[DisplayIcsNum] displaysStarts;
    foreach(i, ref p; displaysStarts)
        p = &buf[eachICdisplaySize * i];

    while(true)
    {
        if(curr >= allDisplaysSize - str.length) increment = -1;
        if(curr <= 0) increment = 1;

        // "Move" text
        buf = buf.init;
        buf[curr .. curr + str.length] = str[0 .. $];

        // print buffer
        displayBuff(buf);

        vTaskDelay(100);

        curr += increment;
    }
}

private void displayBuff(T)(T buff)
{
    //TODO: improve performance here

    foreach(pos; 0 .. eachICdisplaySize)
    {
        beginRefresh();

        foreach_reverse(dispNum; 0 .. DisplayIcsNum)
        {
            ubyte c = buff[eachICdisplaySize * dispNum + pos];
            sendToSegmentDisplay(cast(SegmentCmd) (eachICdisplaySize - pos), c);
        }

        endRefresh();
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
    FeatureRegister = 0b1110, // AS1106 extension?
    DisplayTest = 0b1111,
}

void initDisplay()
{
    spi_setup();

    // empty displays latch buffer
    sendToWholeSegmentDisplay(SegmentCmd.NoOp, 0b0);

    // reset displays
    sendToWholeSegmentDisplay(SegmentCmd.FeatureRegister, 0b10);

    // enable displaying of all digits
    sendToWholeSegmentDisplay(SegmentCmd.ScanLimit, 0b111);

    // adjust maximum intensity
    sendToWholeSegmentDisplay(SegmentCmd.Intensity, 0b11);

    // wake up displays
    sendToWholeSegmentDisplay(SegmentCmd.Shutdown, 0b1);
}

enum allDisplaysSize = 16;
enum eachICdisplaySize = 8;
enum DisplayIcsNum = allDisplaysSize / eachICdisplaySize;

private void sendToWholeSegmentDisplay(SegmentCmd code, ubyte data)
{
    ushort arg = cast(ushort) code << 8 | data;

    beginRefresh();

    foreach(_; 0 .. DisplayIcsNum)
        sendDataToSegmentDisplay(arg);

    //~ foreach(_; 0 .. DisplayIcsNum - 1)
        //~ sendDataToSegmentDisplay(0x0 /* no-op */);

    endRefresh();
}

//~ private void displayChar(uint place, ubyte charImage)
//~ {
    //~ const displayNum = place / eachICdisplaySize;
    //~ const displayCharNum = place % eachICdisplaySize;

    //~ sendToSegmentDisplay(cast(SegmentCmd) (displayCharNum + 1), charImage);

    //~ skipDisplays(displayNum);
//~ }

//~ private void sendToDisplayNum(uint dispNum, ushort arg)
//~ {
    //~ sendDataToSegmentDisplay(arg);

    //~ skipDisplays(dispNum);
//~ }

//~ private void skipDisplays(uint numToSkip)
//~ {
    //~ foreach(_; 0 .. numToSkip)
        //~ sendDataToSegmentDisplay(0 /* no-op */);
//~ }

private void sendToSegmentDisplay(SegmentCmd code, ubyte data)
{
    ushort arg = cast(ushort) code << 8 | data;

    sendDataToSegmentDisplay(arg);
}

enum Segment7Font : ubyte {
//         abcdefg
//         |||||||
    _0 = 0b1111110,
    _1 = 0b0110000,
    _2 = 0b1101101,

    A =  0b1110111,
    d =  0b0111101,
    G =  0b1011110,
    L =  0b0001110,
    n =  0b0010101,

  dash = 0b0000001,
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
