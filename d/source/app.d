import libopencm3;
import freertos;

int main()
{
    import drivers.max7219;

    vTaskDelay(500); // prevents glitch at cold start

    auto display = new MAX7219Display(2);

    display.testBlink();

    ubyte[] str;

    with(Segment7Font)
    str = [d,L,A,n,G,dash,_2,_0,_2,_1]; //dLAnG-2021

    byte curr;
    byte increment = 1;
    byte intensity = 0b11;
    byte intensity_increment = 1;

    while(true)
    {
        if(curr >= display.buf.length - str.length) increment = -1;
        if(curr <= 0) increment = 1;

        if(intensity >= 0b1111) intensity_increment = -1;
        if(intensity <= 0) intensity_increment = 1;

        // "Move" text
        display.buf[0 .. $] = 0;
        display.buf[curr .. curr + str.length] = str[0 .. $];

        // prints buffer
        display.setIntensity(intensity);
        display.refreshImageFromBuffer();

        vTaskDelay(100);

        curr += increment;
        intensity += intensity_increment;
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
