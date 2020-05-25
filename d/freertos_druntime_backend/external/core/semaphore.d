module external.core.semaphore;

import freertos;
import core.sync.exception: SyncError;

// druntime's Posix implementation, version() conditionals removed
class Semaphore
{
    private sem_t m_hndl;

    this(uint count = 0)
    {
        int rc = sem_init( &m_hndl, 0, count );
        if ( rc )
            throw new SyncError( "Unable to create semaphore" );
    }

    ~this()
    {
        int rc = sem_destroy( &m_hndl );
        assert( !rc, "Unable to destroy semaphore" );
    }

    void wait()
    {
        while ( true )
        {
            if ( !sem_wait( &m_hndl ) )
                return;
            if ( errno != EINTR )
                throw new SyncError( "Unable to wait for semaphore" );
        }
    }

    void notify()
    {
        int rc = sem_post( &m_hndl );
        if ( rc )
            throw new SyncError( "Unable to notify semaphore" );
    }
}
