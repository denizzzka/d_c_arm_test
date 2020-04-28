module external.core.pthread;

//TODO: maybe it will be removed

version (ARM)
{
    enum __SIZEOF_PTHREAD_ATTR_T = 36;
    enum __SIZEOF_PTHREAD_MUTEX_T = 24;
    enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;
    enum __SIZEOF_PTHREAD_COND_T = 48;
    enum __SIZEOF_PTHREAD_COND_COMPAT_T = 12;
    enum __SIZEOF_PTHREAD_CONDATTR_T = 4;
    enum __SIZEOF_PTHREAD_RWLOCK_T = 32;
    enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;
    enum __SIZEOF_PTHREAD_BARRIER_T = 20;
    enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;
}

import libc.config: c_long, c_ulong;

alias pthread_spinlock_t = int;
alias pthread_t = c_ulong;

union pthread_mutex_t
{
    byte[__SIZEOF_PTHREAD_MUTEX_T] __size;
    c_long __align;
}

union pthread_mutexattr_t
{
    byte[__SIZEOF_PTHREAD_MUTEXATTR_T] __size;
    c_long __align;
}

immutable size_t PAGESIZE = 28;
immutable size_t PTHREAD_STACK_MIN = 0x004c;

alias ThreadID = pthread_t;

ThreadID createLowLevelThread(void delegate() nothrow dg, uint stacksize = 0,
                              void delegate() nothrow cbDllUnload = null) nothrow @nogc
{
    assert(false, "Not implemented");
}

class Thread
{
}
