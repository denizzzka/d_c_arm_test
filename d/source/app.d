import core.exception;

void main()
{
    // To ensure what this is not betterC
    try
        throw new Exception("test");
    catch(Exception) {}

    // FIXME: return from main() broken at least for FreeRTOS
    import core.stdc.stdlib: exit;
    exit(0);
}
