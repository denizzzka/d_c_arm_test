module drivers.max7219;

import libopencm3;

class MAX7219Display
{
    enum eachICdisplaySize = 8;
    ubyte[] buf; // TODO: receive from outside?
    private ubyte*[] startPoints;

    this(int _displayIcsNum)
    {
        startPoints.length = _displayIcsNum;
        const segmentsTotal = eachICdisplaySize * startPoints.length;

        buf = new ubyte[segmentsTotal];

        foreach(i, ref ptr; startPoints)
            ptr = &buf[eachICdisplaySize * i];

        spi_setup();

        // empty displays latch buffer
        sendToWholeSegmentDisplay(SegmentCmd.NoOp, 0b0);

        // wake up displays
        sendToWholeSegmentDisplay(SegmentCmd.Shutdown, 0b1);

        // reset displays
        sendToWholeSegmentDisplay(SegmentCmd.FeatureRegister, 0b10);

        // enable displaying of all digits
        sendToWholeSegmentDisplay(SegmentCmd.ScanLimit, 0b111);
    }

    void testBlink()
    {
        import freertos;

        foreach(_; 0 .. 3)
        {
            sendToWholeSegmentDisplay(SegmentCmd.DisplayTest, 0b1);
            vTaskDelay(500);
            sendToWholeSegmentDisplay(SegmentCmd.DisplayTest, 0);
            vTaskDelay(500);
        }
    }

    private void sendToWholeSegmentDisplay(SegmentCmd code, ubyte data)
    {
        ushort arg = cast(ushort) code << 8 | data;

        beginRefresh();

        foreach(_; 0 .. startPoints.length)
            sendDataToSegmentDisplay(arg);

        endRefresh();
    }

    void setIntensity(byte intensity)
    {
        sendToWholeSegmentDisplay(SegmentCmd.Intensity, intensity);
    }

    void refreshImageFromBuffer()
    {
        foreach(pos; 0 .. eachICdisplaySize)
        {
            beginRefresh();

            foreach_reverse(screen_ptr; startPoints)
            {
                ubyte c = screen_ptr[pos];
                sendToSegmentDisplay(cast(SegmentCmd) (eachICdisplaySize - pos), c);
            }

            endRefresh();
        }
    }

    private void sendToSegmentDisplay(SegmentCmd code, ubyte data)
    {
        ushort arg = cast(ushort) code << 8 | data;

        sendDataToSegmentDisplay(arg);
    }
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

enum Segment7Font : ubyte {
//         abcdefg
//         |||||||
    _0 = 0b1111110,
    _1 = 0b0110000,
    _2 = 0b1101101,
    _3 = 0b1111001,
    _4 = 0b0110011,
    _5 = 0b1011011,
    _6 = 0b1011111,
    _7 = 0b1110000,
    _8 = 0b1111111,
    _9 = 0b1111011,

    A =  0b1110111,
    b =  0b0011111,
    C =  0b1001110,
    c =  0b0001101,
    d =  0b0111101,
    I =  0b0000110,
    G =  0b1011110,
    H =  0b0110111,
    L =  0b0001110,
    n =  0b0010101,
    Y =  0b0111011,

  dash = 0b0000001,
}
