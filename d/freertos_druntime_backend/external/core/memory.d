module external.core.memory;

size_t getPageSize() @nogc nothrow
{
    return 4096; //page size
}
