module external.rt.monitor_;

public import external.core.pthread: Mutex;
import external.core.pthread;

nothrow:
@nogc:

void initMutex(pthread_mutex_t* mtx)
{
    pthread_mutex_init(mtx, &gattr) && assert(0);
}

void destroyMutex(pthread_mutex_t* mtx)
{
    pthread_mutex_destroy(mtx) && assert(0);
}

void lockMutex(pthread_mutex_t* mtx)
{
    pthread_mutex_lock(mtx) && assert(0);
}

void unlockMutex(pthread_mutex_t* mtx)
{
    pthread_mutex_unlock(mtx) && assert(0);
}
