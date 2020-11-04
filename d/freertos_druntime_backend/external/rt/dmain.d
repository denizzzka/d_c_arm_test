module external.rt.dmain;

import freertos;

nothrow:
@nogc:

template _d_cmain()
{
    nothrow:
    @nogc:
    extern(C):

    void systick_interrupt_disable(); // provided by FreeRTOS

    int _Dmain(char[][] args);

    /// Type of the D main() function (`_Dmain`).
    private alias int function(char[][] args) MainFunc;

    int _d_run_main2(char[][] args, size_t totalArgsLength, MainFunc mainFunc);

    void _d_run_main(void* unused_param)
    {
        //~ systick_interrupt_disable(); // FIXME remove
        import core.stdc.stdlib: _Exit;

        int main_ret = 7; // _d_run_main2 uncatched exception occured
        scope(exit) systick_interrupt_disable(); // disable FreeRTOS tasks switching
        scope(exit) _Exit(main_ret);

        main_ret = _d_run_main2(null, 0, &_Dmain);
    }

    int main(int argc, char** argv)
    {
        pragma(LDC_profile_instr, false);

        auto creation_res = xTaskCreate(
            &_d_run_main,
            cast(const(char*)) "_d_run_main",
            512, // usStackDepth
            null, // *pvParameters
            5, // uxPriority
            null // task handler
        );

        if(creation_res != pdTRUE /* FIXME: pdPASS */)
            return 2; // task creation error

        // Init needed FreeRTOS interrupts handlers
        import external.rt.dmain;

        interruptsVector.sv_call = &vPortSVCHandler;
        interruptsVector.pend_sv = &xPortPendSVHandler;
        interruptsVector.systick = &xPortSysTickHandler;

        vTaskStartScheduler(); // infinity loop

        return 6; // Out of memory
    }
}

extern(C) void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName)
{
    while(true)
    {}
}

import ldc.attributes;
extern(C) void vPortSVCHandler() @naked; // provided by FreeRTOS
extern(C) void xPortPendSVHandler() @naked; // provided by FreeRTOS
extern(C) void xPortSysTickHandler(); // provided by FreeRTOS

/// ARM Cortex-M3 interrupts vector
extern(C) __gshared InterruptsVector* interruptsVector = null;

//TODO: move to ARM Cortex-M3 related module
struct InterruptsVector
{
    void* initial_sp_value;
    void* reset;
    void* nmi_handler;
    void* hard_fault;
    void* memory_manage_fault;
    void* bus_fault;
    void* usage_fault;
    void*[4] reserved1;
    void* sv_call;
    void*[2] reserved2;
    void* pend_sv;
    void* systick;
    void* irq;
}
