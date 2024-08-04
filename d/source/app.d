import core.exception;

int main()
{
    // To ensure what this is not betterC
    try
        throw new Exception("test");
    catch(Exception) {}

    return 0;
}
