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
