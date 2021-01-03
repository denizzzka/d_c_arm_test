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

        // adjust maximum intensity
        sendToWholeSegmentDisplay(SegmentCmd.Intensity, 0b11);
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

    A =  0b1110111,
    d =  0b0111101,
    G =  0b1011110,
    L =  0b0001110,
    n =  0b0010101,

  dash = 0b0000001,
}
