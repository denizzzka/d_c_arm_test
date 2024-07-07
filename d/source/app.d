import freertos;

void main()
{
    // To ensure what this is not betterC
    class TestClass {}
    auto c = new TestClass;

    // FIXME: return from main() broken at least for FreeRTOS
    import core.stdc.stdlib: exit;
    exit(0);
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
