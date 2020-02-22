///Types not avail from core.stdc.config for bare-metal
module bindings.types;

version (ARM)
{
    alias c_long = int;
    alias c_ulong = uint;
}
