module external.rt.dmain;

static import os = freertos;

nothrow:
@nogc:

struct MainTaskProperties
{
    ushort taskStackSizeWords; // words, not bytes!
    void* stackBottom; // filled out after task starts

    void setTaskStackSizeBytes(size_t s = ushort.max * 4)
    {
        taskStackSizeWords = cast(ushort) (s / 4);
    }
}

__gshared static MainTaskProperties mainTaskProperties;
/+
template _d_cmain()
{
    nothrow:
    @nogc:
    extern(C):

    version(ARM)
        void systick_interrupt_disable(); // provided by libopencm3
    else version(RISCV32)
        void systick_interrupt_disable()
        {
            assert(false, "FIXME: find way to do same on RISC-V");
        }

    int _Dmain(char[][] args);

    /// Type of the D main() function (`_Dmain`).
    private alias int function(char[][] args) MainFunc;

    int _d_run_main2(char[][] args, object.size_t totalArgsLength, MainFunc mainFunc);

    import external.rt.dmain: MainTaskProperties, mainTaskProperties;

    void _d_run_main(void* mtp)
    {
        import core.stdc.stdlib: _Exit;
        import external.core.thread: getStackTop;

        // stack isn't used yet, so assumed what we on top
        (cast(MainTaskProperties*) mtp).stackBottom = getStackTop();

        __gshared int main_ret = 7; // _d_run_main2 uncatched exception occured
        scope(exit)
        {
            systick_interrupt_disable(); // tell FreeRTOS to doesn't interfere with exiting code
            _Exit(main_ret); // It is impossible to escape from FreeRTOS main loop, thus just exit
        }

        main_ret = _d_run_main2(null, 0, &_Dmain);
    }

    int main(int argc, char** argv)
    {
        pragma(LDC_profile_instr, false);

        import external.core.thread: DefaultTaskPriority;

        auto creation_res = xTaskCreate(
            &_d_run_main,
            cast(const(char*)) "_d_run_main",
            mainTaskProperties.taskStackSizeWords, // usStackDepth
            cast(void*) &mainTaskProperties, // pvParameters*
            DefaultTaskPriority,
            null // task handler
        );

        if(creation_res != pdTRUE /* FIXME: pdPASS */)
            return 2; // task creation error

        // Init needed FreeRTOS interrupts handlers
        import external.rt.dmain;

        assert(&interruptsVector.sv_call == cast (void*) 0x002c);
        assert(&interruptsVector.pend_sv == cast (void*) 0x0038);

        //~ immutable uint SCB_AIRCR_PRIGROUP_GROUP16_NOSUB = 0x3 << 8 + 0xf;
        //~ scb_set_priority_grouping(SCB_AIRCR_PRIGROUP_GROUP16_NOSUB);

        vTaskStartScheduler(); // infinity loop

        return 6; // Out of memory
    }
}
+/
private extern(C) void vApplicationGetIdleTaskMemory(os.StaticTask_t** tcb, os.StackType_t** stackBuffer, uint* stackSize)
{
  __gshared static os.StaticTask_t idle_TCB;
  __gshared static os.StackType_t[os.configMINIMAL_STACK_SIZE] idle_Stack;

  *tcb = &idle_TCB;
  *stackBuffer = &idle_Stack[0];
  *stackSize = os.configMINIMAL_STACK_SIZE;
}

extern(C) void vApplicationStackOverflowHook(os.TaskHandle_t xTask, char* pcTaskName)
{
    import core.stdc.stdio;

    printf("Stack overflow at task \"%s\" (%p)\n", pcTaskName, xTask);

    while(true)
    {}
}

extern(C) void malloc_stats();

extern(C) void vApplicationTickHook(os.TaskHandle_t xTask, char* pcTaskName)
{
    //TODO: remove this
}

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
