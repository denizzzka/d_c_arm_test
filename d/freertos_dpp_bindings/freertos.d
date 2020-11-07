module freertos;


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    alias wchar_t = int;
    //~ alias size_t = c_ulong;
    //~ alias ptrdiff_t = c_long;
    struct max_align_t
    {
        long __clang_max_align_nonce1;
        real __clang_max_align_nonce2;
    }
    alias __sig_atomic_t = int;
    alias __socklen_t = uint;
    alias __intptr_t = c_long;
    alias __caddr_t = char*;
    alias __loff_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __syscall_slong_t = c_long;
    alias __ssize_t = c_long;
    alias __fsword_t = c_long;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsblkcnt_t = c_ulong;
    alias __blkcnt64_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blksize_t = c_long;
    alias __timer_t = void*;
    alias __clockid_t = int;
    alias __key_t = int;
    alias __daddr_t = int;
    alias __suseconds_t = c_long;
    alias __useconds_t = uint;
    alias __time_t = c_long;
    alias __id_t = uint;
    alias __rlim64_t = c_ulong;
    alias __rlim_t = c_ulong;
    alias __clock_t = c_long;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __pid_t = int;
    alias __off64_t = c_long;
    alias __off_t = c_long;
    alias __nlink_t = c_ulong;
    alias __mode_t = uint;
    alias __ino64_t = c_ulong;
    alias __ino_t = c_ulong;
    alias __gid_t = uint;
    alias __uid_t = uint;
    alias __dev_t = c_ulong;
    alias __uintmax_t = c_ulong;
    alias __intmax_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __quad_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __int_least64_t = c_long;
    alias __uint_least32_t = uint;
    alias __int_least32_t = int;
    alias __uint_least16_t = ushort;
    alias __int_least16_t = short;
    alias __uint_least8_t = ubyte;
    alias __int_least8_t = byte;
    alias __uint64_t = c_ulong;
    alias __int64_t = c_long;
    alias __uint32_t = uint;
    alias __int32_t = int;
    alias __uint16_t = ushort;
    alias __int16_t = short;
    alias __uint8_t = ubyte;
    alias __int8_t = byte;
    alias __u_long = c_ulong;
    alias __u_int = uint;
    alias __u_short = ushort;
    alias __u_char = ubyte;
    alias uint64_t = ulong;
    alias uint32_t = uint;
    alias uint16_t = ushort;
    alias uint8_t = ubyte;
    alias int64_t = c_long;
    alias int32_t = int;
    alias int16_t = short;
    alias int8_t = byte;
    alias uintmax_t = c_ulong;
    alias intmax_t = c_long;
    alias uintptr_t = c_ulong;
    alias intptr_t = c_long;
    alias uint_fast64_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast16_t = c_ulong;
    alias uint_fast8_t = ubyte;
    alias int_fast64_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast16_t = c_long;
    alias int_fast8_t = byte;
    alias uint_least64_t = c_ulong;
    alias uint_least32_t = uint;
    alias uint_least16_t = ushort;
    alias uint_least8_t = ubyte;
    alias int_least64_t = c_long;
    alias int_least32_t = int;
    alias int_least16_t = short;
    alias int_least8_t = byte;
    extern __gshared uint SystemCoreClock;
    static void vPortSetBASEPRI(uint) @nogc nothrow;
    static uint ulPortRaiseBASEPRI() @nogc nothrow;
    static void vPortRaiseBASEPRI() @nogc nothrow;
    static c_long xPortIsInsideInterrupt() @nogc nothrow;
    static ubyte ucPortCountLeadingZeros(uint) @nogc nothrow;
    void vPortSuppressTicksAndSleep(uint) @nogc nothrow;
    void vPortExitCritical() @nogc nothrow;
    void vPortEnterCritical() @nogc nothrow;
    alias TickType_t = uint;
    alias UBaseType_t = c_ulong;
    alias BaseType_t = c_long;
    alias StackType_t = uint;
    void vTaskInternalSetTimeOutState(xTIME_OUT*) @nogc nothrow;
    tskTaskControlBlock* pvTaskIncrementMutexHeldCount() @nogc nothrow;
    eSleepModeStatus eTaskConfirmSleepModeStatus() @nogc nothrow;
    c_long xTaskCatchUpTicks(uint) @nogc nothrow;
    void vTaskStepTick(const(uint)) @nogc nothrow;
    void vTaskSetTaskNumber(tskTaskControlBlock*, const(c_ulong)) @nogc nothrow;
    c_ulong uxTaskGetTaskNumber(tskTaskControlBlock*) @nogc nothrow;
    void vTaskPriorityDisinheritAfterTimeout(const(tskTaskControlBlock*), c_ulong) @nogc nothrow;
    c_long xTaskPriorityDisinherit(const(tskTaskControlBlock*)) @nogc nothrow;
    c_long xTaskPriorityInherit(const(tskTaskControlBlock*)) @nogc nothrow;
    c_long xTaskGetSchedulerState() @nogc nothrow;
    void vTaskMissedYield() @nogc nothrow;
    tskTaskControlBlock* xTaskGetCurrentTaskHandle() @nogc nothrow;
    uint uxTaskResetEventItemValue() @nogc nothrow;
    void vTaskSwitchContext() @nogc nothrow;
    void vTaskRemoveFromUnorderedEventList(xLIST_ITEM*, const(uint)) @nogc nothrow;
    c_long xTaskRemoveFromEventList(const(const(xLIST)*)) @nogc nothrow;
    void vTaskPlaceOnEventListRestricted(xLIST*, uint, const(c_long)) @nogc nothrow;
    void vTaskPlaceOnUnorderedEventList(xLIST*, const(uint), const(uint)) @nogc nothrow;
    void vTaskPlaceOnEventList(xLIST*, const(uint)) @nogc nothrow;
    c_long xTaskIncrementTick() @nogc nothrow;
    c_long xTaskCheckForTimeOut(xTIME_OUT*, uint*) @nogc nothrow;
    void vTaskSetTimeOutState(xTIME_OUT*) @nogc nothrow;
    uint ulTaskNotifyValueClear(tskTaskControlBlock*, uint) @nogc nothrow;
    c_long xTaskNotifyStateClear(tskTaskControlBlock*) @nogc nothrow;
    uint ulTaskNotifyTake(c_long, uint) @nogc nothrow;
    void vTaskNotifyGiveFromISR(tskTaskControlBlock*, c_long*) @nogc nothrow;
    c_long xTaskNotifyWait(uint, uint, uint*, uint) @nogc nothrow;
    c_long xTaskGenericNotifyFromISR(tskTaskControlBlock*, uint, eNotifyAction, uint*, c_long*) @nogc nothrow;
    c_long xTaskGenericNotify(tskTaskControlBlock*, uint, eNotifyAction, uint*) @nogc nothrow;
    uint ulTaskGetIdleRunTimeCounter() @nogc nothrow;
    void vTaskGetRunTimeStats(char*) @nogc nothrow;
    void vTaskList(char*) @nogc nothrow;
    c_ulong uxTaskGetSystemState(xTASK_STATUS*, const(c_ulong), uint*) @nogc nothrow;
    tskTaskControlBlock* xTaskGetIdleTaskHandle() @nogc nothrow;
    c_long xTaskCallApplicationTaskHook(tskTaskControlBlock*, void*) @nogc nothrow;
    ushort uxTaskGetStackHighWaterMark2(tskTaskControlBlock*) @nogc nothrow;
    c_ulong uxTaskGetStackHighWaterMark(tskTaskControlBlock*) @nogc nothrow;
    tskTaskControlBlock* xTaskGetHandle(const(char)*) @nogc nothrow;
    char* pcTaskGetName(tskTaskControlBlock*) @nogc nothrow;
    c_ulong uxTaskGetNumberOfTasks() @nogc nothrow;
    uint xTaskGetTickCountFromISR() @nogc nothrow;
    uint xTaskGetTickCount() @nogc nothrow;
    c_long xTaskResumeAll() @nogc nothrow;
    void vTaskSuspendAll() @nogc nothrow;
    void vTaskEndScheduler() @nogc nothrow;
    void vTaskStartScheduler() @nogc nothrow;
    c_long xTaskResumeFromISR(tskTaskControlBlock*) @nogc nothrow;
    void vTaskResume(tskTaskControlBlock*) @nogc nothrow;
    void vTaskSuspend(tskTaskControlBlock*) @nogc nothrow;
    void vTaskPrioritySet(tskTaskControlBlock*, c_ulong) @nogc nothrow;
    void vTaskGetInfo(tskTaskControlBlock*, xTASK_STATUS*, c_long, eTaskState) @nogc nothrow;
    eTaskState eTaskGetState(tskTaskControlBlock*) @nogc nothrow;
    c_ulong uxTaskPriorityGetFromISR(const(tskTaskControlBlock*)) @nogc nothrow;
    c_ulong uxTaskPriorityGet(const(tskTaskControlBlock*)) @nogc nothrow;
    c_long xTaskAbortDelay(tskTaskControlBlock*) @nogc nothrow;
    void vTaskDelayUntil(uint*, const(uint)) @nogc nothrow;
    void vTaskDelay(const(uint)) @nogc nothrow;
    void vTaskDelete(tskTaskControlBlock*) @nogc nothrow;
    void vTaskAllocateMPURegions(tskTaskControlBlock*, const(const(xMEMORY_REGION)*)) @nogc nothrow;
    c_long xTaskCreate(void function(void*), const(const(char)*), const(ushort), void*, c_ulong, tskTaskControlBlock**) @nogc nothrow;
    enum _Anonymous_0
    {
        eAbortSleep = 0,
        eStandardSleep = 1,
        eNoTasksWaitingTimeout = 2,
    }
    enum eAbortSleep = _Anonymous_0.eAbortSleep;
    enum eStandardSleep = _Anonymous_0.eStandardSleep;
    enum eNoTasksWaitingTimeout = _Anonymous_0.eNoTasksWaitingTimeout;
    alias eSleepModeStatus = _Anonymous_0;
    struct xTASK_STATUS
    {
        tskTaskControlBlock* xHandle;
        const(char)* pcTaskName;
        c_ulong xTaskNumber;
        eTaskState eCurrentState;
        c_ulong uxCurrentPriority;
        c_ulong uxBasePriority;
        uint ulRunTimeCounter;
        uint* pxStackBase;
        ushort usStackHighWaterMark;
    }
    alias TaskStatus_t = xTASK_STATUS;
    struct xTASK_PARAMETERS
    {
        void function(void*) pvTaskCode;
        const(const(char)*) pcName;
        ushort usStackDepth;
        void* pvParameters;
        c_ulong uxPriority;
        uint* puxStackBuffer;
        xMEMORY_REGION[1] xRegions;
    }
    alias TaskParameters_t = xTASK_PARAMETERS;
    struct xMEMORY_REGION
    {
        void* pvBaseAddress;
        uint ulLengthInBytes;
        uint ulParameters;
    }
    alias MemoryRegion_t = xMEMORY_REGION;
    struct xTIME_OUT
    {
        c_long xOverflowCount;
        uint xTimeOnEntering;
    }
    alias TimeOut_t = xTIME_OUT;
    enum _Anonymous_1
    {
        eNoAction = 0,
        eSetBits = 1,
        eIncrement = 2,
        eSetValueWithOverwrite = 3,
        eSetValueWithoutOverwrite = 4,
    }
    enum eNoAction = _Anonymous_1.eNoAction;
    enum eSetBits = _Anonymous_1.eSetBits;
    enum eIncrement = _Anonymous_1.eIncrement;
    enum eSetValueWithOverwrite = _Anonymous_1.eSetValueWithOverwrite;
    enum eSetValueWithoutOverwrite = _Anonymous_1.eSetValueWithoutOverwrite;
    alias eNotifyAction = _Anonymous_1;
    enum _Anonymous_2
    {
        eRunning = 0,
        eReady = 1,
        eBlocked = 2,
        eSuspended = 3,
        eDeleted = 4,
        eInvalid = 5,
    }
    enum eRunning = _Anonymous_2.eRunning;
    enum eReady = _Anonymous_2.eReady;
    enum eBlocked = _Anonymous_2.eBlocked;
    enum eSuspended = _Anonymous_2.eSuspended;
    enum eDeleted = _Anonymous_2.eDeleted;
    enum eInvalid = _Anonymous_2.eInvalid;
    alias eTaskState = _Anonymous_2;
    alias TaskHookFunction_t = c_long function(void*);
    alias TaskHandle_t = tskTaskControlBlock*;
    struct tskTaskControlBlock;
    alias SemaphoreHandle_t = QueueDefinition*;
    ubyte ucQueueGetQueueType(QueueDefinition*) @nogc nothrow;
    c_ulong uxQueueGetQueueNumber(QueueDefinition*) @nogc nothrow;
    void vQueueSetQueueNumber(QueueDefinition*, c_ulong) @nogc nothrow;
    c_long xQueueGenericReset(QueueDefinition*, c_long) @nogc nothrow;
    void vQueueWaitForMessageRestricted(QueueDefinition*, uint, const(c_long)) @nogc nothrow;
    QueueDefinition* xQueueSelectFromSetFromISR(QueueDefinition*) @nogc nothrow;
    QueueDefinition* xQueueSelectFromSet(QueueDefinition*, const(uint)) @nogc nothrow;
    c_long xQueueRemoveFromSet(QueueDefinition*, QueueDefinition*) @nogc nothrow;
    struct xSTATIC_LIST_ITEM
    {
        uint xDummy2;
        void*[4] pvDummy3;
    }
    alias StaticListItem_t = xSTATIC_LIST_ITEM;
    struct xSTATIC_MINI_LIST_ITEM
    {
        uint xDummy2;
        void*[2] pvDummy3;
    }
    alias StaticMiniListItem_t = xSTATIC_MINI_LIST_ITEM;
    alias StaticList_t = xSTATIC_LIST;
    struct xSTATIC_LIST
    {
        c_ulong uxDummy2;
        void* pvDummy3;
        xSTATIC_MINI_LIST_ITEM xDummy4;
    }
    alias StaticTask_t = xSTATIC_TCB;
    struct xSTATIC_TCB
    {
        void* pxDummy1;
        xSTATIC_LIST_ITEM[2] xDummy3;
        c_ulong uxDummy5;
        void* pxDummy6;
        ubyte[16] ucDummy7;
        c_ulong[2] uxDummy12;
        uint ulDummy18;
        ubyte ucDummy19;
    }
    alias StaticQueue_t = xSTATIC_QUEUE;
    struct xSTATIC_QUEUE
    {
        void*[3] pvDummy1;
        static union _Anonymous_3
        {
            void* pvDummy2;
            c_ulong uxDummy2;
        }
        _Anonymous_3 u;
        xSTATIC_LIST[2] xDummy3;
        c_ulong[3] uxDummy4;
        ubyte[2] ucDummy5;
    }
    alias StaticSemaphore_t = xSTATIC_QUEUE;
    alias StaticEventGroup_t = xSTATIC_EVENT_GROUP;
    struct xSTATIC_EVENT_GROUP
    {
        uint xDummy1;
        xSTATIC_LIST xDummy2;
    }
    alias StaticTimer_t = xSTATIC_TIMER;
    struct xSTATIC_TIMER
    {
        void* pvDummy1;
        xSTATIC_LIST_ITEM xDummy2;
        uint xDummy3;
        void* pvDummy5;
        void function(void*) pvDummy6;
        ubyte ucDummy8;
    }
    alias StaticStreamBuffer_t = xSTATIC_STREAM_BUFFER;
    struct xSTATIC_STREAM_BUFFER
    {
        c_ulong[4] uxDummy1;
        void*[3] pvDummy2;
        ubyte ucDummy3;
    }
    alias StaticMessageBuffer_t = xSTATIC_STREAM_BUFFER;
    c_long xQueueAddToSet(QueueDefinition*, QueueDefinition*) @nogc nothrow;
    QueueDefinition* xQueueCreateSet(const(c_ulong)) @nogc nothrow;
    QueueDefinition* xQueueGenericCreate(const(c_ulong), const(c_ulong), const(ubyte)) @nogc nothrow;
    const(char)* pcQueueGetName(QueueDefinition*) @nogc nothrow;
    void vQueueUnregisterQueue(QueueDefinition*) @nogc nothrow;
    struct xLIST
    {
        c_ulong uxNumberOfItems;
        xLIST_ITEM* pxIndex;
        xMINI_LIST_ITEM xListEnd;
    }
    struct xLIST_ITEM
    {
        uint xItemValue;
        xLIST_ITEM* pxNext;
        xLIST_ITEM* pxPrevious;
        void* pvOwner;
        xLIST* pvContainer;
    }
    alias ListItem_t = xLIST_ITEM;
    struct xMINI_LIST_ITEM
    {
        uint xItemValue;
        xLIST_ITEM* pxNext;
        xLIST_ITEM* pxPrevious;
    }
    alias MiniListItem_t = xMINI_LIST_ITEM;
    alias List_t = xLIST;
    void vQueueAddToRegistry(QueueDefinition*, const(char)*) @nogc nothrow;
    c_long xQueueGiveMutexRecursive(QueueDefinition*) @nogc nothrow;
    c_long xQueueTakeMutexRecursive(QueueDefinition*, uint) @nogc nothrow;
    tskTaskControlBlock* xQueueGetMutexHolderFromISR(QueueDefinition*) @nogc nothrow;
    tskTaskControlBlock* xQueueGetMutexHolder(QueueDefinition*) @nogc nothrow;
    c_long xQueueSemaphoreTake(QueueDefinition*, uint) @nogc nothrow;
    void vListInitialise(xLIST*) @nogc nothrow;
    void vListInitialiseItem(xLIST_ITEM*) @nogc nothrow;
    void vListInsert(xLIST*, xLIST_ITEM*) @nogc nothrow;
    void vListInsertEnd(xLIST*, xLIST_ITEM*) @nogc nothrow;
    c_ulong uxListRemove(xLIST_ITEM*) @nogc nothrow;
    QueueDefinition* xQueueCreateCountingSemaphoreStatic(const(c_ulong), const(c_ulong), xSTATIC_QUEUE*) @nogc nothrow;
    QueueDefinition* xQueueCreateCountingSemaphore(const(c_ulong), const(c_ulong)) @nogc nothrow;
    QueueDefinition* xQueueCreateMutexStatic(const(ubyte), xSTATIC_QUEUE*) @nogc nothrow;
    QueueDefinition* xQueueCreateMutex(const(ubyte)) @nogc nothrow;
    c_long xQueueCRReceive(QueueDefinition*, void*, uint) @nogc nothrow;
    c_long xQueueCRSend(QueueDefinition*, const(void)*, uint) @nogc nothrow;
    c_long xQueueCRReceiveFromISR(QueueDefinition*, void*, c_long*) @nogc nothrow;
    uint* pxPortInitialiseStack(uint*, void function(void*), void*) @nogc nothrow;
    alias HeapRegion_t = HeapRegion;
    struct HeapRegion
    {
        ubyte* pucStartAddress;
        c_ulong xSizeInBytes;
    }
    alias HeapStats_t = xHeapStats;
    struct xHeapStats
    {
        c_ulong xAvailableHeapSpaceInBytes;
        c_ulong xSizeOfLargestFreeBlockInBytes;
        c_ulong xSizeOfSmallestFreeBlockInBytes;
        c_ulong xNumberOfFreeBlocks;
        c_ulong xMinimumEverFreeBytesRemaining;
        c_ulong xNumberOfSuccessfulAllocations;
        c_ulong xNumberOfSuccessfulFrees;
    }
    void vPortDefineHeapRegions(const(const(HeapRegion)*)) @nogc nothrow;
    void vPortGetHeapStats(xHeapStats*) @nogc nothrow;
    void* pvPortMalloc(c_ulong) @nogc nothrow;
    void vPortFree(void*) @nogc nothrow;
    void vPortInitialiseBlocks() @nogc nothrow;
    c_ulong xPortGetFreeHeapSize() @nogc nothrow;
    c_ulong xPortGetMinimumEverFreeHeapSize() @nogc nothrow;
    c_long xPortStartScheduler() @nogc nothrow;
    void vPortEndScheduler() @nogc nothrow;
    c_long xQueueCRSendFromISR(QueueDefinition*, const(void)*, c_long) @nogc nothrow;
    alias TaskFunction_t = void function(void*);
    c_ulong uxQueueMessagesWaitingFromISR(const(QueueDefinition*)) @nogc nothrow;
    c_long xQueueIsQueueFullFromISR(const(QueueDefinition*)) @nogc nothrow;
    c_long xQueueIsQueueEmptyFromISR(const(QueueDefinition*)) @nogc nothrow;
    c_long xQueueReceiveFromISR(QueueDefinition*, void*, c_long*) @nogc nothrow;
    c_long xQueueGiveFromISR(QueueDefinition*, c_long*) @nogc nothrow;
    c_long xQueueGenericSendFromISR(QueueDefinition*, const(const(void)*), c_long*, const(c_long)) @nogc nothrow;
    void vQueueDelete(QueueDefinition*) @nogc nothrow;
    c_ulong uxQueueSpacesAvailable(const(QueueDefinition*)) @nogc nothrow;
    c_ulong uxQueueMessagesWaiting(const(QueueDefinition*)) @nogc nothrow;
    c_long xQueueReceive(QueueDefinition*, void*, uint) @nogc nothrow;
    c_long xQueuePeekFromISR(QueueDefinition*, void*) @nogc nothrow;
    c_long xQueuePeek(QueueDefinition*, void*, uint) @nogc nothrow;
    c_long xQueueGenericSend(QueueDefinition*, const(const(void)*), uint, const(c_long)) @nogc nothrow;
    alias QueueSetMemberHandle_t = QueueDefinition*;
    alias QueueSetHandle_t = QueueDefinition*;
    alias QueueHandle_t = QueueDefinition*;
    struct QueueDefinition;



    static if(!is(typeof(pdFREERTOS_ERRNO_EBADE))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EBADE = `enum pdFREERTOS_ERRNO_EBADE = 50;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EBADE); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EBADE);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EFTYPE))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EFTYPE = `enum pdFREERTOS_ERRNO_EFTYPE = 79;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EFTYPE); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EFTYPE);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENMFILE))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENMFILE = `enum pdFREERTOS_ERRNO_ENMFILE = 89;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENMFILE); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENMFILE);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOTEMPTY))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOTEMPTY = `enum pdFREERTOS_ERRNO_ENOTEMPTY = 90;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOTEMPTY); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOTEMPTY);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENAMETOOLONG))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENAMETOOLONG = `enum pdFREERTOS_ERRNO_ENAMETOOLONG = 91;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENAMETOOLONG); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENAMETOOLONG);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EOPNOTSUPP))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EOPNOTSUPP = `enum pdFREERTOS_ERRNO_EOPNOTSUPP = 95;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EOPNOTSUPP); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EOPNOTSUPP);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOBUFS))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOBUFS = `enum pdFREERTOS_ERRNO_ENOBUFS = 105;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOBUFS); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOBUFS);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOPROTOOPT))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOPROTOOPT = `enum pdFREERTOS_ERRNO_ENOPROTOOPT = 109;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOPROTOOPT); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOPROTOOPT);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EADDRINUSE))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EADDRINUSE = `enum pdFREERTOS_ERRNO_EADDRINUSE = 112;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EADDRINUSE); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EADDRINUSE);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ETIMEDOUT))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ETIMEDOUT = `enum pdFREERTOS_ERRNO_ETIMEDOUT = 116;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ETIMEDOUT); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ETIMEDOUT);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EINPROGRESS))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EINPROGRESS = `enum pdFREERTOS_ERRNO_EINPROGRESS = 119;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EINPROGRESS); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EINPROGRESS);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EALREADY))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EALREADY = `enum pdFREERTOS_ERRNO_EALREADY = 120;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EALREADY); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EALREADY);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EADDRNOTAVAIL))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EADDRNOTAVAIL = `enum pdFREERTOS_ERRNO_EADDRNOTAVAIL = 125;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EADDRNOTAVAIL); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EADDRNOTAVAIL);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EISCONN))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EISCONN = `enum pdFREERTOS_ERRNO_EISCONN = 127;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EISCONN); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EISCONN);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOTCONN))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOTCONN = `enum pdFREERTOS_ERRNO_ENOTCONN = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOTCONN); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOTCONN);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOMEDIUM))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOMEDIUM = `enum pdFREERTOS_ERRNO_ENOMEDIUM = 135;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOMEDIUM); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOMEDIUM);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EILSEQ))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EILSEQ = `enum pdFREERTOS_ERRNO_EILSEQ = 138;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EILSEQ); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EILSEQ);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ECANCELED))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ECANCELED = `enum pdFREERTOS_ERRNO_ECANCELED = 140;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ECANCELED); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ECANCELED);
        }
    }




    static if(!is(typeof(pdFREERTOS_LITTLE_ENDIAN))) {
        private enum enumMixinStr_pdFREERTOS_LITTLE_ENDIAN = `enum pdFREERTOS_LITTLE_ENDIAN = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr_pdFREERTOS_LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(pdFREERTOS_BIG_ENDIAN))) {
        private enum enumMixinStr_pdFREERTOS_BIG_ENDIAN = `enum pdFREERTOS_BIG_ENDIAN = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_BIG_ENDIAN); }))) {
            mixin(enumMixinStr_pdFREERTOS_BIG_ENDIAN);
        }
    }




    static if(!is(typeof(pdLITTLE_ENDIAN))) {
        private enum enumMixinStr_pdLITTLE_ENDIAN = `enum pdLITTLE_ENDIAN = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_pdLITTLE_ENDIAN); }))) {
            mixin(enumMixinStr_pdLITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(pdBIG_ENDIAN))) {
        private enum enumMixinStr_pdBIG_ENDIAN = `enum pdBIG_ENDIAN = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_pdBIG_ENDIAN); }))) {
            mixin(enumMixinStr_pdBIG_ENDIAN);
        }
    }






    static if(!is(typeof(pdFREERTOS_ERRNO_EUNATCH))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EUNATCH = `enum pdFREERTOS_ERRNO_EUNATCH = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EUNATCH); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EUNATCH);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EROFS))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EROFS = `enum pdFREERTOS_ERRNO_EROFS = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EROFS); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EROFS);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ESPIPE))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ESPIPE = `enum pdFREERTOS_ERRNO_ESPIPE = 29;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ESPIPE); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ESPIPE);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOSPC))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOSPC = `enum pdFREERTOS_ERRNO_ENOSPC = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOSPC); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOSPC);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EINVAL))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EINVAL = `enum pdFREERTOS_ERRNO_EINVAL = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EINVAL); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EINVAL);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EISDIR))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EISDIR = `enum pdFREERTOS_ERRNO_EISDIR = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EISDIR); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EISDIR);
        }
    }




    static if(!is(typeof(queueSEND_TO_BACK))) {
        private enum enumMixinStr_queueSEND_TO_BACK = `enum queueSEND_TO_BACK = ( cast( BaseType_t ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_queueSEND_TO_BACK); }))) {
            mixin(enumMixinStr_queueSEND_TO_BACK);
        }
    }




    static if(!is(typeof(queueSEND_TO_FRONT))) {
        private enum enumMixinStr_queueSEND_TO_FRONT = `enum queueSEND_TO_FRONT = ( cast( BaseType_t ) 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_queueSEND_TO_FRONT); }))) {
            mixin(enumMixinStr_queueSEND_TO_FRONT);
        }
    }




    static if(!is(typeof(queueOVERWRITE))) {
        private enum enumMixinStr_queueOVERWRITE = `enum queueOVERWRITE = ( cast( BaseType_t ) 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_queueOVERWRITE); }))) {
            mixin(enumMixinStr_queueOVERWRITE);
        }
    }




    static if(!is(typeof(queueQUEUE_TYPE_BASE))) {
        private enum enumMixinStr_queueQUEUE_TYPE_BASE = `enum queueQUEUE_TYPE_BASE = ( cast( uint8_t ) 0U );`;
        static if(is(typeof({ mixin(enumMixinStr_queueQUEUE_TYPE_BASE); }))) {
            mixin(enumMixinStr_queueQUEUE_TYPE_BASE);
        }
    }




    static if(!is(typeof(queueQUEUE_TYPE_SET))) {
        private enum enumMixinStr_queueQUEUE_TYPE_SET = `enum queueQUEUE_TYPE_SET = ( cast( uint8_t ) 0U );`;
        static if(is(typeof({ mixin(enumMixinStr_queueQUEUE_TYPE_SET); }))) {
            mixin(enumMixinStr_queueQUEUE_TYPE_SET);
        }
    }




    static if(!is(typeof(queueQUEUE_TYPE_MUTEX))) {
        private enum enumMixinStr_queueQUEUE_TYPE_MUTEX = `enum queueQUEUE_TYPE_MUTEX = ( cast( uint8_t ) 1U );`;
        static if(is(typeof({ mixin(enumMixinStr_queueQUEUE_TYPE_MUTEX); }))) {
            mixin(enumMixinStr_queueQUEUE_TYPE_MUTEX);
        }
    }




    static if(!is(typeof(queueQUEUE_TYPE_COUNTING_SEMAPHORE))) {
        private enum enumMixinStr_queueQUEUE_TYPE_COUNTING_SEMAPHORE = `enum queueQUEUE_TYPE_COUNTING_SEMAPHORE = ( cast( uint8_t ) 2U );`;
        static if(is(typeof({ mixin(enumMixinStr_queueQUEUE_TYPE_COUNTING_SEMAPHORE); }))) {
            mixin(enumMixinStr_queueQUEUE_TYPE_COUNTING_SEMAPHORE);
        }
    }




    static if(!is(typeof(queueQUEUE_TYPE_BINARY_SEMAPHORE))) {
        private enum enumMixinStr_queueQUEUE_TYPE_BINARY_SEMAPHORE = `enum queueQUEUE_TYPE_BINARY_SEMAPHORE = ( cast( uint8_t ) 3U );`;
        static if(is(typeof({ mixin(enumMixinStr_queueQUEUE_TYPE_BINARY_SEMAPHORE); }))) {
            mixin(enumMixinStr_queueQUEUE_TYPE_BINARY_SEMAPHORE);
        }
    }




    static if(!is(typeof(queueQUEUE_TYPE_RECURSIVE_MUTEX))) {
        private enum enumMixinStr_queueQUEUE_TYPE_RECURSIVE_MUTEX = `enum queueQUEUE_TYPE_RECURSIVE_MUTEX = ( cast( uint8_t ) 4U );`;
        static if(is(typeof({ mixin(enumMixinStr_queueQUEUE_TYPE_RECURSIVE_MUTEX); }))) {
            mixin(enumMixinStr_queueQUEUE_TYPE_RECURSIVE_MUTEX);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOTDIR))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOTDIR = `enum pdFREERTOS_ERRNO_ENOTDIR = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOTDIR); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOTDIR);
        }
    }






    static if(!is(typeof(pdFREERTOS_ERRNO_ENODEV))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENODEV = `enum pdFREERTOS_ERRNO_ENODEV = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENODEV); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENODEV);
        }
    }
    static if(!is(typeof(pdFREERTOS_ERRNO_EXDEV))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EXDEV = `enum pdFREERTOS_ERRNO_EXDEV = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EXDEV); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EXDEV);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EEXIST))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EEXIST = `enum pdFREERTOS_ERRNO_EEXIST = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EEXIST); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EEXIST);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EBUSY))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EBUSY = `enum pdFREERTOS_ERRNO_EBUSY = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EBUSY); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EBUSY);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EFAULT))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EFAULT = `enum pdFREERTOS_ERRNO_EFAULT = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EFAULT); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EFAULT);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EACCES))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EACCES = `enum pdFREERTOS_ERRNO_EACCES = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EACCES); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EACCES);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOMEM))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOMEM = `enum pdFREERTOS_ERRNO_ENOMEM = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOMEM); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOMEM);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EWOULDBLOCK))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EWOULDBLOCK = `enum pdFREERTOS_ERRNO_EWOULDBLOCK = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EWOULDBLOCK); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EWOULDBLOCK);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EAGAIN))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EAGAIN = `enum pdFREERTOS_ERRNO_EAGAIN = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EAGAIN); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EAGAIN);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EBADF))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EBADF = `enum pdFREERTOS_ERRNO_EBADF = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EBADF); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EBADF);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENXIO))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENXIO = `enum pdFREERTOS_ERRNO_ENXIO = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENXIO); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENXIO);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EIO))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EIO = `enum pdFREERTOS_ERRNO_EIO = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EIO); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EIO);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_EINTR))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_EINTR = `enum pdFREERTOS_ERRNO_EINTR = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_EINTR); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_EINTR);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_ENOENT))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_ENOENT = `enum pdFREERTOS_ERRNO_ENOENT = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOENT); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_ENOENT);
        }
    }




    static if(!is(typeof(pdFREERTOS_ERRNO_NONE))) {
        private enum enumMixinStr_pdFREERTOS_ERRNO_NONE = `enum pdFREERTOS_ERRNO_NONE = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_pdFREERTOS_ERRNO_NONE); }))) {
            mixin(enumMixinStr_pdFREERTOS_ERRNO_NONE);
        }
    }
    static if(!is(typeof(pdINTEGRITY_CHECK_VALUE))) {
        private enum enumMixinStr_pdINTEGRITY_CHECK_VALUE = `enum pdINTEGRITY_CHECK_VALUE = 0x5a5a5a5aUL;`;
        static if(is(typeof({ mixin(enumMixinStr_pdINTEGRITY_CHECK_VALUE); }))) {
            mixin(enumMixinStr_pdINTEGRITY_CHECK_VALUE);
        }
    }




    static if(!is(typeof(configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES))) {
        private enum enumMixinStr_configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = `enum configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES); }))) {
            mixin(enumMixinStr_configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES);
        }
    }




    static if(!is(typeof(errQUEUE_YIELD))) {
        private enum enumMixinStr_errQUEUE_YIELD = `enum errQUEUE_YIELD = ( - 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_errQUEUE_YIELD); }))) {
            mixin(enumMixinStr_errQUEUE_YIELD);
        }
    }




    static if(!is(typeof(errQUEUE_BLOCKED))) {
        private enum enumMixinStr_errQUEUE_BLOCKED = `enum errQUEUE_BLOCKED = ( - 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_errQUEUE_BLOCKED); }))) {
            mixin(enumMixinStr_errQUEUE_BLOCKED);
        }
    }




    static if(!is(typeof(errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY))) {
        private enum enumMixinStr_errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY = `enum errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY); }))) {
            mixin(enumMixinStr_errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY);
        }
    }




    static if(!is(typeof(errQUEUE_FULL))) {
        private enum enumMixinStr_errQUEUE_FULL = `enum errQUEUE_FULL = ( cast( BaseType_t ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_errQUEUE_FULL); }))) {
            mixin(enumMixinStr_errQUEUE_FULL);
        }
    }




    static if(!is(typeof(errQUEUE_EMPTY))) {
        private enum enumMixinStr_errQUEUE_EMPTY = `enum errQUEUE_EMPTY = ( cast( BaseType_t ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_errQUEUE_EMPTY); }))) {
            mixin(enumMixinStr_errQUEUE_EMPTY);
        }
    }




    static if(!is(typeof(pdFAIL))) {
        private enum enumMixinStr_pdFAIL = `enum pdFAIL = ( pdFALSE );`;
        static if(is(typeof({ mixin(enumMixinStr_pdFAIL); }))) {
            mixin(enumMixinStr_pdFAIL);
        }
    }




    static if(!is(typeof(pdPASS))) {
        private enum enumMixinStr_pdPASS = `enum pdPASS = ( pdTRUE );`;
        static if(is(typeof({ mixin(enumMixinStr_pdPASS); }))) {
            mixin(enumMixinStr_pdPASS);
        }
    }




    static if(!is(typeof(pdTRUE))) {
        private enum enumMixinStr_pdTRUE = `enum pdTRUE = ( cast( BaseType_t ) 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_pdTRUE); }))) {
            mixin(enumMixinStr_pdTRUE);
        }
    }




    static if(!is(typeof(pdFALSE))) {
        private enum enumMixinStr_pdFALSE = `enum pdFALSE = ( cast( BaseType_t ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_pdFALSE); }))) {
            mixin(enumMixinStr_pdFALSE);
        }
    }
    static if(!is(typeof(portARCH_NAME))) {
        private enum enumMixinStr_portARCH_NAME = `enum portARCH_NAME = null;`;
        static if(is(typeof({ mixin(enumMixinStr_portARCH_NAME); }))) {
            mixin(enumMixinStr_portARCH_NAME);
        }
    }




    static if(!is(typeof(portHAS_STACK_OVERFLOW_CHECKING))) {
        private enum enumMixinStr_portHAS_STACK_OVERFLOW_CHECKING = `enum portHAS_STACK_OVERFLOW_CHECKING = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_portHAS_STACK_OVERFLOW_CHECKING); }))) {
            mixin(enumMixinStr_portHAS_STACK_OVERFLOW_CHECKING);
        }
    }




    static if(!is(typeof(portNUM_CONFIGURABLE_REGIONS))) {
        private enum enumMixinStr_portNUM_CONFIGURABLE_REGIONS = `enum portNUM_CONFIGURABLE_REGIONS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_portNUM_CONFIGURABLE_REGIONS); }))) {
            mixin(enumMixinStr_portNUM_CONFIGURABLE_REGIONS);
        }
    }




    static if(!is(typeof(portBYTE_ALIGNMENT_MASK))) {
        private enum enumMixinStr_portBYTE_ALIGNMENT_MASK = `enum portBYTE_ALIGNMENT_MASK = ( 0x0007 );`;
        static if(is(typeof({ mixin(enumMixinStr_portBYTE_ALIGNMENT_MASK); }))) {
            mixin(enumMixinStr_portBYTE_ALIGNMENT_MASK);
        }
    }






    static if(!is(typeof(portUSING_MPU_WRAPPERS))) {
        private enum enumMixinStr_portUSING_MPU_WRAPPERS = `enum portUSING_MPU_WRAPPERS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_portUSING_MPU_WRAPPERS); }))) {
            mixin(enumMixinStr_portUSING_MPU_WRAPPERS);
        }
    }
    static if(!is(typeof(tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE))) {
        private enum enumMixinStr_tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE = `enum tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE = ( ( ( 0 == 0 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) ) || ( ( 0 == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr_tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE); }))) {
            mixin(enumMixinStr_tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE);
        }
    }




    static if(!is(typeof(configRUN_FREERTOS_SECURE_ONLY))) {
        private enum enumMixinStr_configRUN_FREERTOS_SECURE_ONLY = `enum configRUN_FREERTOS_SECURE_ONLY = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configRUN_FREERTOS_SECURE_ONLY); }))) {
            mixin(enumMixinStr_configRUN_FREERTOS_SECURE_ONLY);
        }
    }




    static if(!is(typeof(configENABLE_TRUSTZONE))) {
        private enum enumMixinStr_configENABLE_TRUSTZONE = `enum configENABLE_TRUSTZONE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configENABLE_TRUSTZONE); }))) {
            mixin(enumMixinStr_configENABLE_TRUSTZONE);
        }
    }




    static if(!is(typeof(configENABLE_FPU))) {
        private enum enumMixinStr_configENABLE_FPU = `enum configENABLE_FPU = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configENABLE_FPU); }))) {
            mixin(enumMixinStr_configENABLE_FPU);
        }
    }




    static if(!is(typeof(configENABLE_MPU))) {
        private enum enumMixinStr_configENABLE_MPU = `enum configENABLE_MPU = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configENABLE_MPU); }))) {
            mixin(enumMixinStr_configENABLE_MPU);
        }
    }




    static if(!is(typeof(configUSE_TASK_FPU_SUPPORT))) {
        private enum enumMixinStr_configUSE_TASK_FPU_SUPPORT = `enum configUSE_TASK_FPU_SUPPORT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TASK_FPU_SUPPORT); }))) {
            mixin(enumMixinStr_configUSE_TASK_FPU_SUPPORT);
        }
    }




    static if(!is(typeof(pxContainer))) {
        private enum enumMixinStr_pxContainer = `enum pxContainer = pvContainer;`;
        static if(is(typeof({ mixin(enumMixinStr_pxContainer); }))) {
            mixin(enumMixinStr_pxContainer);
        }
    }




    static if(!is(typeof(xList))) {
        private enum enumMixinStr_xList = `enum xList = List_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xList); }))) {
            mixin(enumMixinStr_xList);
        }
    }




    static if(!is(typeof(xListItem))) {
        private enum enumMixinStr_xListItem = `enum xListItem = ListItem_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xListItem); }))) {
            mixin(enumMixinStr_xListItem);
        }
    }




    static if(!is(typeof(pdTASK_CODE))) {
        private enum enumMixinStr_pdTASK_CODE = `enum pdTASK_CODE = TaskFunction_t;`;
        static if(is(typeof({ mixin(enumMixinStr_pdTASK_CODE); }))) {
            mixin(enumMixinStr_pdTASK_CODE);
        }
    }




    static if(!is(typeof(tmrTIMER_CALLBACK))) {
        private enum enumMixinStr_tmrTIMER_CALLBACK = `enum tmrTIMER_CALLBACK = TimerCallbackFunction_t;`;
        static if(is(typeof({ mixin(enumMixinStr_tmrTIMER_CALLBACK); }))) {
            mixin(enumMixinStr_tmrTIMER_CALLBACK);
        }
    }




    static if(!is(typeof(xTaskGetIdleRunTimeCounter))) {
        private enum enumMixinStr_xTaskGetIdleRunTimeCounter = `enum xTaskGetIdleRunTimeCounter = ulTaskGetIdleRunTimeCounter;`;
        static if(is(typeof({ mixin(enumMixinStr_xTaskGetIdleRunTimeCounter); }))) {
            mixin(enumMixinStr_xTaskGetIdleRunTimeCounter);
        }
    }




    static if(!is(typeof(vTaskGetTaskInfo))) {
        private enum enumMixinStr_vTaskGetTaskInfo = `enum vTaskGetTaskInfo = vTaskGetInfo;`;
        static if(is(typeof({ mixin(enumMixinStr_vTaskGetTaskInfo); }))) {
            mixin(enumMixinStr_vTaskGetTaskInfo);
        }
    }




    static if(!is(typeof(pcQueueGetQueueName))) {
        private enum enumMixinStr_pcQueueGetQueueName = `enum pcQueueGetQueueName = pcQueueGetName;`;
        static if(is(typeof({ mixin(enumMixinStr_pcQueueGetQueueName); }))) {
            mixin(enumMixinStr_pcQueueGetQueueName);
        }
    }




    static if(!is(typeof(pcTimerGetTimerName))) {
        private enum enumMixinStr_pcTimerGetTimerName = `enum pcTimerGetTimerName = pcTimerGetName;`;
        static if(is(typeof({ mixin(enumMixinStr_pcTimerGetTimerName); }))) {
            mixin(enumMixinStr_pcTimerGetTimerName);
        }
    }




    static if(!is(typeof(pcTaskGetTaskName))) {
        private enum enumMixinStr_pcTaskGetTaskName = `enum pcTaskGetTaskName = pcTaskGetName;`;
        static if(is(typeof({ mixin(enumMixinStr_pcTaskGetTaskName); }))) {
            mixin(enumMixinStr_pcTaskGetTaskName);
        }
    }






    static if(!is(typeof(portTICK_RATE_MS))) {
        private enum enumMixinStr_portTICK_RATE_MS = `enum portTICK_RATE_MS = portTICK_PERIOD_MS;`;
        static if(is(typeof({ mixin(enumMixinStr_portTICK_RATE_MS); }))) {
            mixin(enumMixinStr_portTICK_RATE_MS);
        }
    }




    static if(!is(typeof(pdTASK_HOOK_CODE))) {
        private enum enumMixinStr_pdTASK_HOOK_CODE = `enum pdTASK_HOOK_CODE = TaskHookFunction_t;`;
        static if(is(typeof({ mixin(enumMixinStr_pdTASK_HOOK_CODE); }))) {
            mixin(enumMixinStr_pdTASK_HOOK_CODE);
        }
    }




    static if(!is(typeof(xCoRoutineHandle))) {
        private enum enumMixinStr_xCoRoutineHandle = `enum xCoRoutineHandle = CoRoutineHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xCoRoutineHandle); }))) {
            mixin(enumMixinStr_xCoRoutineHandle);
        }
    }




    static if(!is(typeof(semBINARY_SEMAPHORE_QUEUE_LENGTH))) {
        private enum enumMixinStr_semBINARY_SEMAPHORE_QUEUE_LENGTH = `enum semBINARY_SEMAPHORE_QUEUE_LENGTH = ( cast( uint8_t ) 1U );`;
        static if(is(typeof({ mixin(enumMixinStr_semBINARY_SEMAPHORE_QUEUE_LENGTH); }))) {
            mixin(enumMixinStr_semBINARY_SEMAPHORE_QUEUE_LENGTH);
        }
    }




    static if(!is(typeof(semSEMAPHORE_QUEUE_ITEM_LENGTH))) {
        private enum enumMixinStr_semSEMAPHORE_QUEUE_ITEM_LENGTH = `enum semSEMAPHORE_QUEUE_ITEM_LENGTH = ( cast( uint8_t ) 0U );`;
        static if(is(typeof({ mixin(enumMixinStr_semSEMAPHORE_QUEUE_ITEM_LENGTH); }))) {
            mixin(enumMixinStr_semSEMAPHORE_QUEUE_ITEM_LENGTH);
        }
    }




    static if(!is(typeof(semGIVE_BLOCK_TIME))) {
        private enum enumMixinStr_semGIVE_BLOCK_TIME = `enum semGIVE_BLOCK_TIME = ( cast( TickType_t ) 0U );`;
        static if(is(typeof({ mixin(enumMixinStr_semGIVE_BLOCK_TIME); }))) {
            mixin(enumMixinStr_semGIVE_BLOCK_TIME);
        }
    }




    static if(!is(typeof(xTimerHandle))) {
        private enum enumMixinStr_xTimerHandle = `enum xTimerHandle = TimerHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xTimerHandle); }))) {
            mixin(enumMixinStr_xTimerHandle);
        }
    }






    static if(!is(typeof(xTaskStatusType))) {
        private enum enumMixinStr_xTaskStatusType = `enum xTaskStatusType = TaskStatus_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xTaskStatusType); }))) {
            mixin(enumMixinStr_xTaskStatusType);
        }
    }






    static if(!is(typeof(xTaskParameters))) {
        private enum enumMixinStr_xTaskParameters = `enum xTaskParameters = TaskParameters_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xTaskParameters); }))) {
            mixin(enumMixinStr_xTaskParameters);
        }
    }






    static if(!is(typeof(xMemoryRegion))) {
        private enum enumMixinStr_xMemoryRegion = `enum xMemoryRegion = MemoryRegion_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xMemoryRegion); }))) {
            mixin(enumMixinStr_xMemoryRegion);
        }
    }
    static if(!is(typeof(xTimeOutType))) {
        private enum enumMixinStr_xTimeOutType = `enum xTimeOutType = TimeOut_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xTimeOutType); }))) {
            mixin(enumMixinStr_xTimeOutType);
        }
    }
    static if(!is(typeof(xQueueSetMemberHandle))) {
        private enum enumMixinStr_xQueueSetMemberHandle = `enum xQueueSetMemberHandle = QueueSetMemberHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xQueueSetMemberHandle); }))) {
            mixin(enumMixinStr_xQueueSetMemberHandle);
        }
    }






    static if(!is(typeof(xQueueSetHandle))) {
        private enum enumMixinStr_xQueueSetHandle = `enum xQueueSetHandle = QueueSetHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xQueueSetHandle); }))) {
            mixin(enumMixinStr_xQueueSetHandle);
        }
    }




    static if(!is(typeof(xSemaphoreHandle))) {
        private enum enumMixinStr_xSemaphoreHandle = `enum xSemaphoreHandle = SemaphoreHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xSemaphoreHandle); }))) {
            mixin(enumMixinStr_xSemaphoreHandle);
        }
    }




    static if(!is(typeof(xQueueHandle))) {
        private enum enumMixinStr_xQueueHandle = `enum xQueueHandle = QueueHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xQueueHandle); }))) {
            mixin(enumMixinStr_xQueueHandle);
        }
    }






    static if(!is(typeof(xTaskHandle))) {
        private enum enumMixinStr_xTaskHandle = `enum xTaskHandle = TaskHandle_t;`;
        static if(is(typeof({ mixin(enumMixinStr_xTaskHandle); }))) {
            mixin(enumMixinStr_xTaskHandle);
        }
    }




    static if(!is(typeof(portTickType))) {
        private enum enumMixinStr_portTickType = `enum portTickType = TickType_t;`;
        static if(is(typeof({ mixin(enumMixinStr_portTickType); }))) {
            mixin(enumMixinStr_portTickType);
        }
    }




    static if(!is(typeof(eTaskStateGet))) {
        private enum enumMixinStr_eTaskStateGet = `enum eTaskStateGet = eTaskGetState;`;
        static if(is(typeof({ mixin(enumMixinStr_eTaskStateGet); }))) {
            mixin(enumMixinStr_eTaskStateGet);
        }
    }
    static if(!is(typeof(tskKERNEL_VERSION_NUMBER))) {
        private enum enumMixinStr_tskKERNEL_VERSION_NUMBER = `enum tskKERNEL_VERSION_NUMBER = "V10.3.1";`;
        static if(is(typeof({ mixin(enumMixinStr_tskKERNEL_VERSION_NUMBER); }))) {
            mixin(enumMixinStr_tskKERNEL_VERSION_NUMBER);
        }
    }




    static if(!is(typeof(tskKERNEL_VERSION_MAJOR))) {
        private enum enumMixinStr_tskKERNEL_VERSION_MAJOR = `enum tskKERNEL_VERSION_MAJOR = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_tskKERNEL_VERSION_MAJOR); }))) {
            mixin(enumMixinStr_tskKERNEL_VERSION_MAJOR);
        }
    }




    static if(!is(typeof(tskKERNEL_VERSION_MINOR))) {
        private enum enumMixinStr_tskKERNEL_VERSION_MINOR = `enum tskKERNEL_VERSION_MINOR = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_tskKERNEL_VERSION_MINOR); }))) {
            mixin(enumMixinStr_tskKERNEL_VERSION_MINOR);
        }
    }




    static if(!is(typeof(tskKERNEL_VERSION_BUILD))) {
        private enum enumMixinStr_tskKERNEL_VERSION_BUILD = `enum tskKERNEL_VERSION_BUILD = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_tskKERNEL_VERSION_BUILD); }))) {
            mixin(enumMixinStr_tskKERNEL_VERSION_BUILD);
        }
    }




    static if(!is(typeof(tskMPU_REGION_READ_ONLY))) {
        private enum enumMixinStr_tskMPU_REGION_READ_ONLY = `enum tskMPU_REGION_READ_ONLY = ( 1UL << 0UL );`;
        static if(is(typeof({ mixin(enumMixinStr_tskMPU_REGION_READ_ONLY); }))) {
            mixin(enumMixinStr_tskMPU_REGION_READ_ONLY);
        }
    }




    static if(!is(typeof(tskMPU_REGION_READ_WRITE))) {
        private enum enumMixinStr_tskMPU_REGION_READ_WRITE = `enum tskMPU_REGION_READ_WRITE = ( 1UL << 1UL );`;
        static if(is(typeof({ mixin(enumMixinStr_tskMPU_REGION_READ_WRITE); }))) {
            mixin(enumMixinStr_tskMPU_REGION_READ_WRITE);
        }
    }




    static if(!is(typeof(tskMPU_REGION_EXECUTE_NEVER))) {
        private enum enumMixinStr_tskMPU_REGION_EXECUTE_NEVER = `enum tskMPU_REGION_EXECUTE_NEVER = ( 1UL << 2UL );`;
        static if(is(typeof({ mixin(enumMixinStr_tskMPU_REGION_EXECUTE_NEVER); }))) {
            mixin(enumMixinStr_tskMPU_REGION_EXECUTE_NEVER);
        }
    }




    static if(!is(typeof(tskMPU_REGION_NORMAL_MEMORY))) {
        private enum enumMixinStr_tskMPU_REGION_NORMAL_MEMORY = `enum tskMPU_REGION_NORMAL_MEMORY = ( 1UL << 3UL );`;
        static if(is(typeof({ mixin(enumMixinStr_tskMPU_REGION_NORMAL_MEMORY); }))) {
            mixin(enumMixinStr_tskMPU_REGION_NORMAL_MEMORY);
        }
    }




    static if(!is(typeof(tskMPU_REGION_DEVICE_MEMORY))) {
        private enum enumMixinStr_tskMPU_REGION_DEVICE_MEMORY = `enum tskMPU_REGION_DEVICE_MEMORY = ( 1UL << 4UL );`;
        static if(is(typeof({ mixin(enumMixinStr_tskMPU_REGION_DEVICE_MEMORY); }))) {
            mixin(enumMixinStr_tskMPU_REGION_DEVICE_MEMORY);
        }
    }




    static if(!is(typeof(configENABLE_BACKWARD_COMPATIBILITY))) {
        private enum enumMixinStr_configENABLE_BACKWARD_COMPATIBILITY = `enum configENABLE_BACKWARD_COMPATIBILITY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configENABLE_BACKWARD_COMPATIBILITY); }))) {
            mixin(enumMixinStr_configENABLE_BACKWARD_COMPATIBILITY);
        }
    }
    static if(!is(typeof(configINITIAL_TICK_COUNT))) {
        private enum enumMixinStr_configINITIAL_TICK_COUNT = `enum configINITIAL_TICK_COUNT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configINITIAL_TICK_COUNT); }))) {
            mixin(enumMixinStr_configINITIAL_TICK_COUNT);
        }
    }




    static if(!is(typeof(configMESSAGE_BUFFER_LENGTH_TYPE))) {
        private enum enumMixinStr_configMESSAGE_BUFFER_LENGTH_TYPE = `enum configMESSAGE_BUFFER_LENGTH_TYPE = size_t;`;
        static if(is(typeof({ mixin(enumMixinStr_configMESSAGE_BUFFER_LENGTH_TYPE); }))) {
            mixin(enumMixinStr_configMESSAGE_BUFFER_LENGTH_TYPE);
        }
    }




    static if(!is(typeof(configSTACK_DEPTH_TYPE))) {
        private enum enumMixinStr_configSTACK_DEPTH_TYPE = `enum configSTACK_DEPTH_TYPE = uint16_t;`;
        static if(is(typeof({ mixin(enumMixinStr_configSTACK_DEPTH_TYPE); }))) {
            mixin(enumMixinStr_configSTACK_DEPTH_TYPE);
        }
    }




    static if(!is(typeof(configUSE_POSIX_ERRNO))) {
        private enum enumMixinStr_configUSE_POSIX_ERRNO = `enum configUSE_POSIX_ERRNO = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_POSIX_ERRNO); }))) {
            mixin(enumMixinStr_configUSE_POSIX_ERRNO);
        }
    }




    static if(!is(typeof(configUSE_TASK_NOTIFICATIONS))) {
        private enum enumMixinStr_configUSE_TASK_NOTIFICATIONS = `enum configUSE_TASK_NOTIFICATIONS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TASK_NOTIFICATIONS); }))) {
            mixin(enumMixinStr_configUSE_TASK_NOTIFICATIONS);
        }
    }




    static if(!is(typeof(configAPPLICATION_ALLOCATED_HEAP))) {
        private enum enumMixinStr_configAPPLICATION_ALLOCATED_HEAP = `enum configAPPLICATION_ALLOCATED_HEAP = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configAPPLICATION_ALLOCATED_HEAP); }))) {
            mixin(enumMixinStr_configAPPLICATION_ALLOCATED_HEAP);
        }
    }
    static if(!is(typeof(configUSE_TRACE_FACILITY))) {
        private enum enumMixinStr_configUSE_TRACE_FACILITY = `enum configUSE_TRACE_FACILITY = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TRACE_FACILITY); }))) {
            mixin(enumMixinStr_configUSE_TRACE_FACILITY);
        }
    }






    static if(!is(typeof(configUSE_STATS_FORMATTING_FUNCTIONS))) {
        private enum enumMixinStr_configUSE_STATS_FORMATTING_FUNCTIONS = `enum configUSE_STATS_FORMATTING_FUNCTIONS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_STATS_FORMATTING_FUNCTIONS); }))) {
            mixin(enumMixinStr_configUSE_STATS_FORMATTING_FUNCTIONS);
        }
    }




    static if(!is(typeof(configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS))) {
        private enum enumMixinStr_configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS = `enum configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS); }))) {
            mixin(enumMixinStr_configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS);
        }
    }




    static if(!is(typeof(configUSE_TIME_SLICING))) {
        private enum enumMixinStr_configUSE_TIME_SLICING = `enum configUSE_TIME_SLICING = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TIME_SLICING); }))) {
            mixin(enumMixinStr_configUSE_TIME_SLICING);
        }
    }
    static if(!is(typeof(tskIDLE_PRIORITY))) {
        private enum enumMixinStr_tskIDLE_PRIORITY = `enum tskIDLE_PRIORITY = ( cast( UBaseType_t ) 0U );`;
        static if(is(typeof({ mixin(enumMixinStr_tskIDLE_PRIORITY); }))) {
            mixin(enumMixinStr_tskIDLE_PRIORITY);
        }
    }
    static if(!is(typeof(taskSCHEDULER_SUSPENDED))) {
        private enum enumMixinStr_taskSCHEDULER_SUSPENDED = `enum taskSCHEDULER_SUSPENDED = ( cast( BaseType_t ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_taskSCHEDULER_SUSPENDED); }))) {
            mixin(enumMixinStr_taskSCHEDULER_SUSPENDED);
        }
    }




    static if(!is(typeof(taskSCHEDULER_NOT_STARTED))) {
        private enum enumMixinStr_taskSCHEDULER_NOT_STARTED = `enum taskSCHEDULER_NOT_STARTED = ( cast( BaseType_t ) 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_taskSCHEDULER_NOT_STARTED); }))) {
            mixin(enumMixinStr_taskSCHEDULER_NOT_STARTED);
        }
    }




    static if(!is(typeof(taskSCHEDULER_RUNNING))) {
        private enum enumMixinStr_taskSCHEDULER_RUNNING = `enum taskSCHEDULER_RUNNING = ( cast( BaseType_t ) 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_taskSCHEDULER_RUNNING); }))) {
            mixin(enumMixinStr_taskSCHEDULER_RUNNING);
        }
    }




    static if(!is(typeof(configUSE_QUEUE_SETS))) {
        private enum enumMixinStr_configUSE_QUEUE_SETS = `enum configUSE_QUEUE_SETS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_QUEUE_SETS); }))) {
            mixin(enumMixinStr_configUSE_QUEUE_SETS);
        }
    }
    static if(!is(typeof(configUSE_TICKLESS_IDLE))) {
        private enum enumMixinStr_configUSE_TICKLESS_IDLE = `enum configUSE_TICKLESS_IDLE = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TICKLESS_IDLE); }))) {
            mixin(enumMixinStr_configUSE_TICKLESS_IDLE);
        }
    }




    static if(!is(typeof(configEXPECTED_IDLE_TIME_BEFORE_SLEEP))) {
        private enum enumMixinStr_configEXPECTED_IDLE_TIME_BEFORE_SLEEP = `enum configEXPECTED_IDLE_TIME_BEFORE_SLEEP = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_configEXPECTED_IDLE_TIME_BEFORE_SLEEP); }))) {
            mixin(enumMixinStr_configEXPECTED_IDLE_TIME_BEFORE_SLEEP);
        }
    }




    static if(!is(typeof(portYIELD_WITHIN_API))) {
        private enum enumMixinStr_portYIELD_WITHIN_API = `enum portYIELD_WITHIN_API = portYIELD;`;
        static if(is(typeof({ mixin(enumMixinStr_portYIELD_WITHIN_API); }))) {
            mixin(enumMixinStr_portYIELD_WITHIN_API);
        }
    }




    static if(!is(typeof(portPRIVILEGE_BIT))) {
        private enum enumMixinStr_portPRIVILEGE_BIT = `enum portPRIVILEGE_BIT = ( cast( UBaseType_t ) 0x00 );`;
        static if(is(typeof({ mixin(enumMixinStr_portPRIVILEGE_BIT); }))) {
            mixin(enumMixinStr_portPRIVILEGE_BIT);
        }
    }




    static if(!is(typeof(configUSE_MALLOC_FAILED_HOOK))) {
        private enum enumMixinStr_configUSE_MALLOC_FAILED_HOOK = `enum configUSE_MALLOC_FAILED_HOOK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_MALLOC_FAILED_HOOK); }))) {
            mixin(enumMixinStr_configUSE_MALLOC_FAILED_HOOK);
        }
    }






    static if(!is(typeof(configGENERATE_RUN_TIME_STATS))) {
        private enum enumMixinStr_configGENERATE_RUN_TIME_STATS = `enum configGENERATE_RUN_TIME_STATS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configGENERATE_RUN_TIME_STATS); }))) {
            mixin(enumMixinStr_configGENERATE_RUN_TIME_STATS);
        }
    }
    static if(!is(typeof(configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H))) {
        private enum enumMixinStr_configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H = `enum configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H); }))) {
            mixin(enumMixinStr_configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H);
        }
    }




    static if(!is(typeof(configRECORD_STACK_HIGH_ADDRESS))) {
        private enum enumMixinStr_configRECORD_STACK_HIGH_ADDRESS = `enum configRECORD_STACK_HIGH_ADDRESS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configRECORD_STACK_HIGH_ADDRESS); }))) {
            mixin(enumMixinStr_configRECORD_STACK_HIGH_ADDRESS);
        }
    }




    static if(!is(typeof(configCHECK_FOR_STACK_OVERFLOW))) {
        private enum enumMixinStr_configCHECK_FOR_STACK_OVERFLOW = `enum configCHECK_FOR_STACK_OVERFLOW = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configCHECK_FOR_STACK_OVERFLOW); }))) {
            mixin(enumMixinStr_configCHECK_FOR_STACK_OVERFLOW);
        }
    }
    static if(!is(typeof(portPOINTER_SIZE_TYPE))) {
        private enum enumMixinStr_portPOINTER_SIZE_TYPE = `enum portPOINTER_SIZE_TYPE = uint32_t;`;
        static if(is(typeof({ mixin(enumMixinStr_portPOINTER_SIZE_TYPE); }))) {
            mixin(enumMixinStr_portPOINTER_SIZE_TYPE);
        }
    }
    static if(!is(typeof(configPRECONDITION_DEFINED))) {
        private enum enumMixinStr_configPRECONDITION_DEFINED = `enum configPRECONDITION_DEFINED = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configPRECONDITION_DEFINED); }))) {
            mixin(enumMixinStr_configPRECONDITION_DEFINED);
        }
    }






    static if(!is(typeof(configASSERT_DEFINED))) {
        private enum enumMixinStr_configASSERT_DEFINED = `enum configASSERT_DEFINED = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configASSERT_DEFINED); }))) {
            mixin(enumMixinStr_configASSERT_DEFINED);
        }
    }






    static if(!is(typeof(configIDLE_SHOULD_YIELD))) {
        private enum enumMixinStr_configIDLE_SHOULD_YIELD = `enum configIDLE_SHOULD_YIELD = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configIDLE_SHOULD_YIELD); }))) {
            mixin(enumMixinStr_configIDLE_SHOULD_YIELD);
        }
    }




    static if(!is(typeof(portCRITICAL_NESTING_IN_TCB))) {
        private enum enumMixinStr_portCRITICAL_NESTING_IN_TCB = `enum portCRITICAL_NESTING_IN_TCB = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_portCRITICAL_NESTING_IN_TCB); }))) {
            mixin(enumMixinStr_portCRITICAL_NESTING_IN_TCB);
        }
    }




    static if(!is(typeof(configUSE_ALTERNATIVE_API))) {
        private enum enumMixinStr_configUSE_ALTERNATIVE_API = `enum configUSE_ALTERNATIVE_API = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_ALTERNATIVE_API); }))) {
            mixin(enumMixinStr_configUSE_ALTERNATIVE_API);
        }
    }




    static if(!is(typeof(configUSE_TIMERS))) {
        private enum enumMixinStr_configUSE_TIMERS = `enum configUSE_TIMERS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TIMERS); }))) {
            mixin(enumMixinStr_configUSE_TIMERS);
        }
    }




    static if(!is(typeof(configNUM_THREAD_LOCAL_STORAGE_POINTERS))) {
        private enum enumMixinStr_configNUM_THREAD_LOCAL_STORAGE_POINTERS = `enum configNUM_THREAD_LOCAL_STORAGE_POINTERS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configNUM_THREAD_LOCAL_STORAGE_POINTERS); }))) {
            mixin(enumMixinStr_configNUM_THREAD_LOCAL_STORAGE_POINTERS);
        }
    }




    static if(!is(typeof(configUSE_APPLICATION_TASK_TAG))) {
        private enum enumMixinStr_configUSE_APPLICATION_TASK_TAG = `enum configUSE_APPLICATION_TASK_TAG = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_APPLICATION_TASK_TAG); }))) {
            mixin(enumMixinStr_configUSE_APPLICATION_TASK_TAG);
        }
    }




    static if(!is(typeof(configUSE_DAEMON_TASK_STARTUP_HOOK))) {
        private enum enumMixinStr_configUSE_DAEMON_TASK_STARTUP_HOOK = `enum configUSE_DAEMON_TASK_STARTUP_HOOK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_DAEMON_TASK_STARTUP_HOOK); }))) {
            mixin(enumMixinStr_configUSE_DAEMON_TASK_STARTUP_HOOK);
        }
    }




    static if(!is(typeof(INCLUDE_xTaskGetCurrentTaskHandle))) {
        private enum enumMixinStr_INCLUDE_xTaskGetCurrentTaskHandle = `enum INCLUDE_xTaskGetCurrentTaskHandle = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTaskGetCurrentTaskHandle); }))) {
            mixin(enumMixinStr_INCLUDE_xTaskGetCurrentTaskHandle);
        }
    }




    static if(!is(typeof(INCLUDE_xTimerPendFunctionCall))) {
        private enum enumMixinStr_INCLUDE_xTimerPendFunctionCall = `enum INCLUDE_xTimerPendFunctionCall = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTimerPendFunctionCall); }))) {
            mixin(enumMixinStr_INCLUDE_xTimerPendFunctionCall);
        }
    }




    static if(!is(typeof(INCLUDE_xTaskResumeFromISR))) {
        private enum enumMixinStr_INCLUDE_xTaskResumeFromISR = `enum INCLUDE_xTaskResumeFromISR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTaskResumeFromISR); }))) {
            mixin(enumMixinStr_INCLUDE_xTaskResumeFromISR);
        }
    }




    static if(!is(typeof(INCLUDE_eTaskGetState))) {
        private enum enumMixinStr_INCLUDE_eTaskGetState = `enum INCLUDE_eTaskGetState = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_eTaskGetState); }))) {
            mixin(enumMixinStr_INCLUDE_eTaskGetState);
        }
    }




    static if(!is(typeof(INCLUDE_uxTaskGetStackHighWaterMark2))) {
        private enum enumMixinStr_INCLUDE_uxTaskGetStackHighWaterMark2 = `enum INCLUDE_uxTaskGetStackHighWaterMark2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_uxTaskGetStackHighWaterMark2); }))) {
            mixin(enumMixinStr_INCLUDE_uxTaskGetStackHighWaterMark2);
        }
    }




    static if(!is(typeof(INCLUDE_uxTaskGetStackHighWaterMark))) {
        private enum enumMixinStr_INCLUDE_uxTaskGetStackHighWaterMark = `enum INCLUDE_uxTaskGetStackHighWaterMark = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_uxTaskGetStackHighWaterMark); }))) {
            mixin(enumMixinStr_INCLUDE_uxTaskGetStackHighWaterMark);
        }
    }




    static if(!is(typeof(INCLUDE_xTaskGetHandle))) {
        private enum enumMixinStr_INCLUDE_xTaskGetHandle = `enum INCLUDE_xTaskGetHandle = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTaskGetHandle); }))) {
            mixin(enumMixinStr_INCLUDE_xTaskGetHandle);
        }
    }




    static if(!is(typeof(INCLUDE_xSemaphoreGetMutexHolder))) {
        private enum enumMixinStr_INCLUDE_xSemaphoreGetMutexHolder = `enum INCLUDE_xSemaphoreGetMutexHolder = INCLUDE_xQueueGetMutexHolder;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xSemaphoreGetMutexHolder); }))) {
            mixin(enumMixinStr_INCLUDE_xSemaphoreGetMutexHolder);
        }
    }




    static if(!is(typeof(INCLUDE_xQueueGetMutexHolder))) {
        private enum enumMixinStr_INCLUDE_xQueueGetMutexHolder = `enum INCLUDE_xQueueGetMutexHolder = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xQueueGetMutexHolder); }))) {
            mixin(enumMixinStr_INCLUDE_xQueueGetMutexHolder);
        }
    }




    static if(!is(typeof(INCLUDE_xTaskAbortDelay))) {
        private enum enumMixinStr_INCLUDE_xTaskAbortDelay = `enum INCLUDE_xTaskAbortDelay = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTaskAbortDelay); }))) {
            mixin(enumMixinStr_INCLUDE_xTaskAbortDelay);
        }
    }




    static if(!is(typeof(INCLUDE_xTaskGetIdleTaskHandle))) {
        private enum enumMixinStr_INCLUDE_xTaskGetIdleTaskHandle = `enum INCLUDE_xTaskGetIdleTaskHandle = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTaskGetIdleTaskHandle); }))) {
            mixin(enumMixinStr_INCLUDE_xTaskGetIdleTaskHandle);
        }
    }




    static if(!is(typeof(configUSE_NEWLIB_REENTRANT))) {
        private enum enumMixinStr_configUSE_NEWLIB_REENTRANT = `enum configUSE_NEWLIB_REENTRANT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_NEWLIB_REENTRANT); }))) {
            mixin(enumMixinStr_configUSE_NEWLIB_REENTRANT);
        }
    }






    static if(!is(typeof(configENFORCE_SYSTEM_CALLS_FROM_KERNEL_ONLY))) {
        private enum enumMixinStr_configENFORCE_SYSTEM_CALLS_FROM_KERNEL_ONLY = `enum configENFORCE_SYSTEM_CALLS_FROM_KERNEL_ONLY = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configENFORCE_SYSTEM_CALLS_FROM_KERNEL_ONLY); }))) {
            mixin(enumMixinStr_configENFORCE_SYSTEM_CALLS_FROM_KERNEL_ONLY);
        }
    }






    static if(!is(typeof(portCHAR))) {
        private enum enumMixinStr_portCHAR = `enum portCHAR = char;`;
        static if(is(typeof({ mixin(enumMixinStr_portCHAR); }))) {
            mixin(enumMixinStr_portCHAR);
        }
    }




    static if(!is(typeof(portFLOAT))) {
        private enum enumMixinStr_portFLOAT = `enum portFLOAT = float;`;
        static if(is(typeof({ mixin(enumMixinStr_portFLOAT); }))) {
            mixin(enumMixinStr_portFLOAT);
        }
    }




    static if(!is(typeof(portDOUBLE))) {
        private enum enumMixinStr_portDOUBLE = `enum portDOUBLE = double;`;
        static if(is(typeof({ mixin(enumMixinStr_portDOUBLE); }))) {
            mixin(enumMixinStr_portDOUBLE);
        }
    }




    static if(!is(typeof(portLONG))) {
        private enum enumMixinStr_portLONG = `enum portLONG = long;`;
        static if(is(typeof({ mixin(enumMixinStr_portLONG); }))) {
            mixin(enumMixinStr_portLONG);
        }
    }




    static if(!is(typeof(portSHORT))) {
        private enum enumMixinStr_portSHORT = `enum portSHORT = short;`;
        static if(is(typeof({ mixin(enumMixinStr_portSHORT); }))) {
            mixin(enumMixinStr_portSHORT);
        }
    }




    static if(!is(typeof(portSTACK_TYPE))) {
        private enum enumMixinStr_portSTACK_TYPE = `enum portSTACK_TYPE = uint32_t;`;
        static if(is(typeof({ mixin(enumMixinStr_portSTACK_TYPE); }))) {
            mixin(enumMixinStr_portSTACK_TYPE);
        }
    }




    static if(!is(typeof(portBASE_TYPE))) {
        private enum enumMixinStr_portBASE_TYPE = `enum portBASE_TYPE = long;`;
        static if(is(typeof({ mixin(enumMixinStr_portBASE_TYPE); }))) {
            mixin(enumMixinStr_portBASE_TYPE);
        }
    }




    static if(!is(typeof(configMAX_SYSCALL_INTERRUPT_PRIORITY))) {
        private enum enumMixinStr_configMAX_SYSCALL_INTERRUPT_PRIORITY = `enum configMAX_SYSCALL_INTERRUPT_PRIORITY = ( configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY << ( 8 - configPRIO_BITS ) );`;
        static if(is(typeof({ mixin(enumMixinStr_configMAX_SYSCALL_INTERRUPT_PRIORITY); }))) {
            mixin(enumMixinStr_configMAX_SYSCALL_INTERRUPT_PRIORITY);
        }
    }




    static if(!is(typeof(configKERNEL_INTERRUPT_PRIORITY))) {
        private enum enumMixinStr_configKERNEL_INTERRUPT_PRIORITY = `enum configKERNEL_INTERRUPT_PRIORITY = ( configLIBRARY_LOWEST_INTERRUPT_PRIORITY << ( 8 - configPRIO_BITS ) );`;
        static if(is(typeof({ mixin(enumMixinStr_configKERNEL_INTERRUPT_PRIORITY); }))) {
            mixin(enumMixinStr_configKERNEL_INTERRUPT_PRIORITY);
        }
    }




    static if(!is(typeof(configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY))) {
        private enum enumMixinStr_configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY = `enum configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY); }))) {
            mixin(enumMixinStr_configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY);
        }
    }




    static if(!is(typeof(configLIBRARY_LOWEST_INTERRUPT_PRIORITY))) {
        private enum enumMixinStr_configLIBRARY_LOWEST_INTERRUPT_PRIORITY = `enum configLIBRARY_LOWEST_INTERRUPT_PRIORITY = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_configLIBRARY_LOWEST_INTERRUPT_PRIORITY); }))) {
            mixin(enumMixinStr_configLIBRARY_LOWEST_INTERRUPT_PRIORITY);
        }
    }




    static if(!is(typeof(configPRIO_BITS))) {
        private enum enumMixinStr_configPRIO_BITS = `enum configPRIO_BITS = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_configPRIO_BITS); }))) {
            mixin(enumMixinStr_configPRIO_BITS);
        }
    }




    static if(!is(typeof(INCLUDE_xTaskGetSchedulerState))) {
        private enum enumMixinStr_INCLUDE_xTaskGetSchedulerState = `enum INCLUDE_xTaskGetSchedulerState = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_xTaskGetSchedulerState); }))) {
            mixin(enumMixinStr_INCLUDE_xTaskGetSchedulerState);
        }
    }




    static if(!is(typeof(portMAX_DELAY))) {
        private enum enumMixinStr_portMAX_DELAY = `enum portMAX_DELAY = cast( TickType_t ) 0xffffffffUL;`;
        static if(is(typeof({ mixin(enumMixinStr_portMAX_DELAY); }))) {
            mixin(enumMixinStr_portMAX_DELAY);
        }
    }




    static if(!is(typeof(portTICK_TYPE_IS_ATOMIC))) {
        private enum enumMixinStr_portTICK_TYPE_IS_ATOMIC = `enum portTICK_TYPE_IS_ATOMIC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_portTICK_TYPE_IS_ATOMIC); }))) {
            mixin(enumMixinStr_portTICK_TYPE_IS_ATOMIC);
        }
    }




    static if(!is(typeof(portSTACK_GROWTH))) {
        private enum enumMixinStr_portSTACK_GROWTH = `enum portSTACK_GROWTH = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_portSTACK_GROWTH); }))) {
            mixin(enumMixinStr_portSTACK_GROWTH);
        }
    }




    static if(!is(typeof(portTICK_PERIOD_MS))) {
        private enum enumMixinStr_portTICK_PERIOD_MS = `enum portTICK_PERIOD_MS = ( cast( TickType_t ) 1000 / configTICK_RATE_HZ );`;
        static if(is(typeof({ mixin(enumMixinStr_portTICK_PERIOD_MS); }))) {
            mixin(enumMixinStr_portTICK_PERIOD_MS);
        }
    }




    static if(!is(typeof(portBYTE_ALIGNMENT))) {
        private enum enumMixinStr_portBYTE_ALIGNMENT = `enum portBYTE_ALIGNMENT = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_portBYTE_ALIGNMENT); }))) {
            mixin(enumMixinStr_portBYTE_ALIGNMENT);
        }
    }
    static if(!is(typeof(portNVIC_INT_CTRL_REG))) {
        private enum enumMixinStr_portNVIC_INT_CTRL_REG = `enum portNVIC_INT_CTRL_REG = ( * ( ( volatile uint32_t * ) 0xe000ed04 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_portNVIC_INT_CTRL_REG); }))) {
            mixin(enumMixinStr_portNVIC_INT_CTRL_REG);
        }
    }




    static if(!is(typeof(portNVIC_PENDSVSET_BIT))) {
        private enum enumMixinStr_portNVIC_PENDSVSET_BIT = `enum portNVIC_PENDSVSET_BIT = ( 1UL << 28UL );`;
        static if(is(typeof({ mixin(enumMixinStr_portNVIC_PENDSVSET_BIT); }))) {
            mixin(enumMixinStr_portNVIC_PENDSVSET_BIT);
        }
    }
    static if(!is(typeof(INCLUDE_vTaskDelay))) {
        private enum enumMixinStr_INCLUDE_vTaskDelay = `enum INCLUDE_vTaskDelay = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_vTaskDelay); }))) {
            mixin(enumMixinStr_INCLUDE_vTaskDelay);
        }
    }




    static if(!is(typeof(INCLUDE_vTaskDelayUntil))) {
        private enum enumMixinStr_INCLUDE_vTaskDelayUntil = `enum INCLUDE_vTaskDelayUntil = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_vTaskDelayUntil); }))) {
            mixin(enumMixinStr_INCLUDE_vTaskDelayUntil);
        }
    }
    static if(!is(typeof(INCLUDE_vTaskSuspend))) {
        private enum enumMixinStr_INCLUDE_vTaskSuspend = `enum INCLUDE_vTaskSuspend = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_vTaskSuspend); }))) {
            mixin(enumMixinStr_INCLUDE_vTaskSuspend);
        }
    }






    static if(!is(typeof(INCLUDE_vTaskDelete))) {
        private enum enumMixinStr_INCLUDE_vTaskDelete = `enum INCLUDE_vTaskDelete = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_vTaskDelete); }))) {
            mixin(enumMixinStr_INCLUDE_vTaskDelete);
        }
    }




    static if(!is(typeof(INCLUDE_uxTaskPriorityGet))) {
        private enum enumMixinStr_INCLUDE_uxTaskPriorityGet = `enum INCLUDE_uxTaskPriorityGet = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_uxTaskPriorityGet); }))) {
            mixin(enumMixinStr_INCLUDE_uxTaskPriorityGet);
        }
    }




    static if(!is(typeof(INCLUDE_vTaskPrioritySet))) {
        private enum enumMixinStr_INCLUDE_vTaskPrioritySet = `enum INCLUDE_vTaskPrioritySet = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_INCLUDE_vTaskPrioritySet); }))) {
            mixin(enumMixinStr_INCLUDE_vTaskPrioritySet);
        }
    }




    static if(!is(typeof(configMAX_CO_ROUTINE_PRIORITIES))) {
        private enum enumMixinStr_configMAX_CO_ROUTINE_PRIORITIES = `enum configMAX_CO_ROUTINE_PRIORITIES = ( 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_configMAX_CO_ROUTINE_PRIORITIES); }))) {
            mixin(enumMixinStr_configMAX_CO_ROUTINE_PRIORITIES);
        }
    }
    static if(!is(typeof(portINLINE))) {
        private enum enumMixinStr_portINLINE = `enum portINLINE = __inline;`;
        static if(is(typeof({ mixin(enumMixinStr_portINLINE); }))) {
            mixin(enumMixinStr_portINLINE);
        }
    }




    static if(!is(typeof(portFORCE_INLINE))) {
        private enum enumMixinStr_portFORCE_INLINE = `enum portFORCE_INLINE = inline __attribute__ ( ( always_inline ) );`;
        static if(is(typeof({ mixin(enumMixinStr_portFORCE_INLINE); }))) {
            mixin(enumMixinStr_portFORCE_INLINE);
        }
    }




    static if(!is(typeof(configUSE_CO_ROUTINES))) {
        private enum enumMixinStr_configUSE_CO_ROUTINES = `enum configUSE_CO_ROUTINES = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_CO_ROUTINES); }))) {
            mixin(enumMixinStr_configUSE_CO_ROUTINES);
        }
    }




    static if(!is(typeof(configUSE_PORT_OPTIMISED_TASK_SELECTION))) {
        private enum enumMixinStr_configUSE_PORT_OPTIMISED_TASK_SELECTION = `enum configUSE_PORT_OPTIMISED_TASK_SELECTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_PORT_OPTIMISED_TASK_SELECTION); }))) {
            mixin(enumMixinStr_configUSE_PORT_OPTIMISED_TASK_SELECTION);
        }
    }




    static if(!is(typeof(configQUEUE_REGISTRY_SIZE))) {
        private enum enumMixinStr_configQUEUE_REGISTRY_SIZE = `enum configQUEUE_REGISTRY_SIZE = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_configQUEUE_REGISTRY_SIZE); }))) {
            mixin(enumMixinStr_configQUEUE_REGISTRY_SIZE);
        }
    }




    static if(!is(typeof(configUSE_COUNTING_SEMAPHORES))) {
        private enum enumMixinStr_configUSE_COUNTING_SEMAPHORES = `enum configUSE_COUNTING_SEMAPHORES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_COUNTING_SEMAPHORES); }))) {
            mixin(enumMixinStr_configUSE_COUNTING_SEMAPHORES);
        }
    }




    static if(!is(typeof(configUSE_RECURSIVE_MUTEXES))) {
        private enum enumMixinStr_configUSE_RECURSIVE_MUTEXES = `enum configUSE_RECURSIVE_MUTEXES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_RECURSIVE_MUTEXES); }))) {
            mixin(enumMixinStr_configUSE_RECURSIVE_MUTEXES);
        }
    }




    static if(!is(typeof(configUSE_MUTEXES))) {
        private enum enumMixinStr_configUSE_MUTEXES = `enum configUSE_MUTEXES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_MUTEXES); }))) {
            mixin(enumMixinStr_configUSE_MUTEXES);
        }
    }




    static if(!is(typeof(configUSE_16_BIT_TICKS))) {
        private enum enumMixinStr_configUSE_16_BIT_TICKS = `enum configUSE_16_BIT_TICKS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_16_BIT_TICKS); }))) {
            mixin(enumMixinStr_configUSE_16_BIT_TICKS);
        }
    }




    static if(!is(typeof(configMAX_TASK_NAME_LEN))) {
        private enum enumMixinStr_configMAX_TASK_NAME_LEN = `enum configMAX_TASK_NAME_LEN = ( 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_configMAX_TASK_NAME_LEN); }))) {
            mixin(enumMixinStr_configMAX_TASK_NAME_LEN);
        }
    }




    static if(!is(typeof(configTOTAL_HEAP_SIZE))) {
        private enum enumMixinStr_configTOTAL_HEAP_SIZE = `enum configTOTAL_HEAP_SIZE = ( cast( size_t ) 3072 );`;
        static if(is(typeof({ mixin(enumMixinStr_configTOTAL_HEAP_SIZE); }))) {
            mixin(enumMixinStr_configTOTAL_HEAP_SIZE);
        }
    }




    static if(!is(typeof(configMINIMAL_STACK_SIZE))) {
        private enum enumMixinStr_configMINIMAL_STACK_SIZE = `enum configMINIMAL_STACK_SIZE = ( cast( uint16_t ) 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_configMINIMAL_STACK_SIZE); }))) {
            mixin(enumMixinStr_configMINIMAL_STACK_SIZE);
        }
    }




    static if(!is(typeof(configMAX_PRIORITIES))) {
        private enum enumMixinStr_configMAX_PRIORITIES = `enum configMAX_PRIORITIES = ( 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_configMAX_PRIORITIES); }))) {
            mixin(enumMixinStr_configMAX_PRIORITIES);
        }
    }




    static if(!is(typeof(configTICK_RATE_HZ))) {
        private enum enumMixinStr_configTICK_RATE_HZ = `enum configTICK_RATE_HZ = ( cast( TickType_t ) 1000 );`;
        static if(is(typeof({ mixin(enumMixinStr_configTICK_RATE_HZ); }))) {
            mixin(enumMixinStr_configTICK_RATE_HZ);
        }
    }






    static if(!is(typeof(configCPU_CLOCK_HZ))) {
        private enum enumMixinStr_configCPU_CLOCK_HZ = `enum configCPU_CLOCK_HZ = ( 72000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_configCPU_CLOCK_HZ); }))) {
            mixin(enumMixinStr_configCPU_CLOCK_HZ);
        }
    }




    static if(!is(typeof(configUSE_TICK_HOOK))) {
        private enum enumMixinStr_configUSE_TICK_HOOK = `enum configUSE_TICK_HOOK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_TICK_HOOK); }))) {
            mixin(enumMixinStr_configUSE_TICK_HOOK);
        }
    }




    static if(!is(typeof(configUSE_IDLE_HOOK))) {
        private enum enumMixinStr_configUSE_IDLE_HOOK = `enum configUSE_IDLE_HOOK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_IDLE_HOOK); }))) {
            mixin(enumMixinStr_configUSE_IDLE_HOOK);
        }
    }




    static if(!is(typeof(_FEATURES_H))) {
        private enum enumMixinStr__FEATURES_H = `enum _FEATURES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FEATURES_H); }))) {
            mixin(enumMixinStr__FEATURES_H);
        }
    }






    static if(!is(typeof(configSUPPORT_DYNAMIC_ALLOCATION))) {
        private enum enumMixinStr_configSUPPORT_DYNAMIC_ALLOCATION = `enum configSUPPORT_DYNAMIC_ALLOCATION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configSUPPORT_DYNAMIC_ALLOCATION); }))) {
            mixin(enumMixinStr_configSUPPORT_DYNAMIC_ALLOCATION);
        }
    }




    static if(!is(typeof(configSUPPORT_STATIC_ALLOCATION))) {
        private enum enumMixinStr_configSUPPORT_STATIC_ALLOCATION = `enum configSUPPORT_STATIC_ALLOCATION = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_configSUPPORT_STATIC_ALLOCATION); }))) {
            mixin(enumMixinStr_configSUPPORT_STATIC_ALLOCATION);
        }
    }






    static if(!is(typeof(configUSE_PREEMPTION))) {
        private enum enumMixinStr_configUSE_PREEMPTION = `enum configUSE_PREEMPTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_configUSE_PREEMPTION); }))) {
            mixin(enumMixinStr_configUSE_PREEMPTION);
        }
    }
    static if(!is(typeof(_DEFAULT_SOURCE))) {
        private enum enumMixinStr__DEFAULT_SOURCE = `enum _DEFAULT_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__DEFAULT_SOURCE); }))) {
            mixin(enumMixinStr__DEFAULT_SOURCE);
        }
    }




    static if(!is(typeof(__USE_ISOC11))) {
        private enum enumMixinStr___USE_ISOC11 = `enum __USE_ISOC11 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC11); }))) {
            mixin(enumMixinStr___USE_ISOC11);
        }
    }




    static if(!is(typeof(__USE_ISOC99))) {
        private enum enumMixinStr___USE_ISOC99 = `enum __USE_ISOC99 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC99); }))) {
            mixin(enumMixinStr___USE_ISOC99);
        }
    }




    static if(!is(typeof(__USE_ISOC95))) {
        private enum enumMixinStr___USE_ISOC95 = `enum __USE_ISOC95 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC95); }))) {
            mixin(enumMixinStr___USE_ISOC95);
        }
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        private enum enumMixinStr___USE_POSIX_IMPLICITLY = `enum __USE_POSIX_IMPLICITLY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX_IMPLICITLY); }))) {
            mixin(enumMixinStr___USE_POSIX_IMPLICITLY);
        }
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        private enum enumMixinStr__POSIX_SOURCE = `enum _POSIX_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_SOURCE);
        }
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        private enum enumMixinStr__POSIX_C_SOURCE = `enum _POSIX_C_SOURCE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_C_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_C_SOURCE);
        }
    }




    static if(!is(typeof(__USE_POSIX))) {
        private enum enumMixinStr___USE_POSIX = `enum __USE_POSIX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX); }))) {
            mixin(enumMixinStr___USE_POSIX);
        }
    }




    static if(!is(typeof(__USE_POSIX2))) {
        private enum enumMixinStr___USE_POSIX2 = `enum __USE_POSIX2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX2); }))) {
            mixin(enumMixinStr___USE_POSIX2);
        }
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        private enum enumMixinStr___USE_POSIX199309 = `enum __USE_POSIX199309 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199309); }))) {
            mixin(enumMixinStr___USE_POSIX199309);
        }
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        private enum enumMixinStr___USE_POSIX199506 = `enum __USE_POSIX199506 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199506); }))) {
            mixin(enumMixinStr___USE_POSIX199506);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K))) {
        private enum enumMixinStr___USE_XOPEN2K = `enum __USE_XOPEN2K = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K); }))) {
            mixin(enumMixinStr___USE_XOPEN2K);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        private enum enumMixinStr___USE_XOPEN2K8 = `enum __USE_XOPEN2K8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K8); }))) {
            mixin(enumMixinStr___USE_XOPEN2K8);
        }
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        private enum enumMixinStr__ATFILE_SOURCE = `enum _ATFILE_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ATFILE_SOURCE); }))) {
            mixin(enumMixinStr__ATFILE_SOURCE);
        }
    }




    static if(!is(typeof(__USE_MISC))) {
        private enum enumMixinStr___USE_MISC = `enum __USE_MISC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_MISC); }))) {
            mixin(enumMixinStr___USE_MISC);
        }
    }




    static if(!is(typeof(__USE_ATFILE))) {
        private enum enumMixinStr___USE_ATFILE = `enum __USE_ATFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ATFILE); }))) {
            mixin(enumMixinStr___USE_ATFILE);
        }
    }




    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        private enum enumMixinStr___USE_FORTIFY_LEVEL = `enum __USE_FORTIFY_LEVEL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_FORTIFY_LEVEL); }))) {
            mixin(enumMixinStr___USE_FORTIFY_LEVEL);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_GETS))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_GETS = `enum __GLIBC_USE_DEPRECATED_GETS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_SCANF))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_SCANF = `enum __GLIBC_USE_DEPRECATED_SCANF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF);
        }
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        private enum enumMixinStr___GNU_LIBRARY__ = `enum __GNU_LIBRARY__ = 6;`;
        static if(is(typeof({ mixin(enumMixinStr___GNU_LIBRARY__); }))) {
            mixin(enumMixinStr___GNU_LIBRARY__);
        }
    }




    static if(!is(typeof(__GLIBC__))) {
        private enum enumMixinStr___GLIBC__ = `enum __GLIBC__ = 2;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC__); }))) {
            mixin(enumMixinStr___GLIBC__);
        }
    }




    static if(!is(typeof(__GLIBC_MINOR__))) {
        private enum enumMixinStr___GLIBC_MINOR__ = `enum __GLIBC_MINOR__ = 29;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_MINOR__); }))) {
            mixin(enumMixinStr___GLIBC_MINOR__);
        }
    }






    static if(!is(typeof(_STDC_PREDEF_H))) {
        private enum enumMixinStr__STDC_PREDEF_H = `enum _STDC_PREDEF_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDC_PREDEF_H); }))) {
            mixin(enumMixinStr__STDC_PREDEF_H);
        }
    }




    static if(!is(typeof(_STDINT_H))) {
        private enum enumMixinStr__STDINT_H = `enum _STDINT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDINT_H); }))) {
            mixin(enumMixinStr__STDINT_H);
        }
    }
    static if(!is(typeof(INT8_MIN))) {
        private enum enumMixinStr_INT8_MIN = `enum INT8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MIN); }))) {
            mixin(enumMixinStr_INT8_MIN);
        }
    }




    static if(!is(typeof(INT16_MIN))) {
        private enum enumMixinStr_INT16_MIN = `enum INT16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MIN); }))) {
            mixin(enumMixinStr_INT16_MIN);
        }
    }




    static if(!is(typeof(INT32_MIN))) {
        private enum enumMixinStr_INT32_MIN = `enum INT32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MIN); }))) {
            mixin(enumMixinStr_INT32_MIN);
        }
    }




    static if(!is(typeof(INT64_MIN))) {
        private enum enumMixinStr_INT64_MIN = `enum INT64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MIN); }))) {
            mixin(enumMixinStr_INT64_MIN);
        }
    }




    static if(!is(typeof(INT8_MAX))) {
        private enum enumMixinStr_INT8_MAX = `enum INT8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MAX); }))) {
            mixin(enumMixinStr_INT8_MAX);
        }
    }




    static if(!is(typeof(INT16_MAX))) {
        private enum enumMixinStr_INT16_MAX = `enum INT16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MAX); }))) {
            mixin(enumMixinStr_INT16_MAX);
        }
    }




    static if(!is(typeof(INT32_MAX))) {
        private enum enumMixinStr_INT32_MAX = `enum INT32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MAX); }))) {
            mixin(enumMixinStr_INT32_MAX);
        }
    }




    static if(!is(typeof(INT64_MAX))) {
        private enum enumMixinStr_INT64_MAX = `enum INT64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MAX); }))) {
            mixin(enumMixinStr_INT64_MAX);
        }
    }




    static if(!is(typeof(UINT8_MAX))) {
        private enum enumMixinStr_UINT8_MAX = `enum UINT8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT8_MAX); }))) {
            mixin(enumMixinStr_UINT8_MAX);
        }
    }




    static if(!is(typeof(UINT16_MAX))) {
        private enum enumMixinStr_UINT16_MAX = `enum UINT16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT16_MAX); }))) {
            mixin(enumMixinStr_UINT16_MAX);
        }
    }




    static if(!is(typeof(UINT32_MAX))) {
        private enum enumMixinStr_UINT32_MAX = `enum UINT32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT32_MAX); }))) {
            mixin(enumMixinStr_UINT32_MAX);
        }
    }




    static if(!is(typeof(UINT64_MAX))) {
        private enum enumMixinStr_UINT64_MAX = `enum UINT64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT64_MAX); }))) {
            mixin(enumMixinStr_UINT64_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST8_MIN))) {
        private enum enumMixinStr_INT_LEAST8_MIN = `enum INT_LEAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST8_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST16_MIN))) {
        private enum enumMixinStr_INT_LEAST16_MIN = `enum INT_LEAST16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST16_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST32_MIN))) {
        private enum enumMixinStr_INT_LEAST32_MIN = `enum INT_LEAST32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST32_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST64_MIN))) {
        private enum enumMixinStr_INT_LEAST64_MIN = `enum INT_LEAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST64_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST8_MAX))) {
        private enum enumMixinStr_INT_LEAST8_MAX = `enum INT_LEAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST16_MAX))) {
        private enum enumMixinStr_INT_LEAST16_MAX = `enum INT_LEAST16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST32_MAX))) {
        private enum enumMixinStr_INT_LEAST32_MAX = `enum INT_LEAST32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MAX))) {
        private enum enumMixinStr_INT_LEAST64_MAX = `enum INT_LEAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST8_MAX))) {
        private enum enumMixinStr_UINT_LEAST8_MAX = `enum UINT_LEAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST16_MAX))) {
        private enum enumMixinStr_UINT_LEAST16_MAX = `enum UINT_LEAST16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST32_MAX))) {
        private enum enumMixinStr_UINT_LEAST32_MAX = `enum UINT_LEAST32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST64_MAX))) {
        private enum enumMixinStr_UINT_LEAST64_MAX = `enum UINT_LEAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(INT_FAST8_MIN))) {
        private enum enumMixinStr_INT_FAST8_MIN = `enum INT_FAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MIN); }))) {
            mixin(enumMixinStr_INT_FAST8_MIN);
        }
    }




    static if(!is(typeof(INT_FAST16_MIN))) {
        private enum enumMixinStr_INT_FAST16_MIN = `enum INT_FAST16_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MIN); }))) {
            mixin(enumMixinStr_INT_FAST16_MIN);
        }
    }




    static if(!is(typeof(INT_FAST32_MIN))) {
        private enum enumMixinStr_INT_FAST32_MIN = `enum INT_FAST32_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MIN); }))) {
            mixin(enumMixinStr_INT_FAST32_MIN);
        }
    }




    static if(!is(typeof(INT_FAST64_MIN))) {
        private enum enumMixinStr_INT_FAST64_MIN = `enum INT_FAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MIN); }))) {
            mixin(enumMixinStr_INT_FAST64_MIN);
        }
    }




    static if(!is(typeof(INT_FAST8_MAX))) {
        private enum enumMixinStr_INT_FAST8_MAX = `enum INT_FAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MAX); }))) {
            mixin(enumMixinStr_INT_FAST8_MAX);
        }
    }




    static if(!is(typeof(INT_FAST16_MAX))) {
        private enum enumMixinStr_INT_FAST16_MAX = `enum INT_FAST16_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MAX); }))) {
            mixin(enumMixinStr_INT_FAST16_MAX);
        }
    }




    static if(!is(typeof(INT_FAST32_MAX))) {
        private enum enumMixinStr_INT_FAST32_MAX = `enum INT_FAST32_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MAX); }))) {
            mixin(enumMixinStr_INT_FAST32_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MAX))) {
        private enum enumMixinStr_INT_FAST64_MAX = `enum INT_FAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MAX); }))) {
            mixin(enumMixinStr_INT_FAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST8_MAX))) {
        private enum enumMixinStr_UINT_FAST8_MAX = `enum UINT_FAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST8_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST16_MAX))) {
        private enum enumMixinStr_UINT_FAST16_MAX = `enum UINT_FAST16_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST32_MAX))) {
        private enum enumMixinStr_UINT_FAST32_MAX = `enum UINT_FAST32_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST64_MAX))) {
        private enum enumMixinStr_UINT_FAST64_MAX = `enum UINT_FAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST64_MAX);
        }
    }




    static if(!is(typeof(INTPTR_MIN))) {
        private enum enumMixinStr_INTPTR_MIN = `enum INTPTR_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MIN); }))) {
            mixin(enumMixinStr_INTPTR_MIN);
        }
    }




    static if(!is(typeof(INTPTR_MAX))) {
        private enum enumMixinStr_INTPTR_MAX = `enum INTPTR_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MAX); }))) {
            mixin(enumMixinStr_INTPTR_MAX);
        }
    }




    static if(!is(typeof(UINTPTR_MAX))) {
        private enum enumMixinStr_UINTPTR_MAX = `enum UINTPTR_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTPTR_MAX); }))) {
            mixin(enumMixinStr_UINTPTR_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MIN))) {
        private enum enumMixinStr_INTMAX_MIN = `enum INTMAX_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MIN); }))) {
            mixin(enumMixinStr_INTMAX_MIN);
        }
    }




    static if(!is(typeof(INTMAX_MAX))) {
        private enum enumMixinStr_INTMAX_MAX = `enum INTMAX_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MAX); }))) {
            mixin(enumMixinStr_INTMAX_MAX);
        }
    }




    static if(!is(typeof(UINTMAX_MAX))) {
        private enum enumMixinStr_UINTMAX_MAX = `enum UINTMAX_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTMAX_MAX); }))) {
            mixin(enumMixinStr_UINTMAX_MAX);
        }
    }




    static if(!is(typeof(PTRDIFF_MIN))) {
        private enum enumMixinStr_PTRDIFF_MIN = `enum PTRDIFF_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MIN); }))) {
            mixin(enumMixinStr_PTRDIFF_MIN);
        }
    }




    static if(!is(typeof(PTRDIFF_MAX))) {
        private enum enumMixinStr_PTRDIFF_MAX = `enum PTRDIFF_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MAX); }))) {
            mixin(enumMixinStr_PTRDIFF_MAX);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MIN))) {
        private enum enumMixinStr_SIG_ATOMIC_MIN = `enum SIG_ATOMIC_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MIN); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MIN);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MAX))) {
        private enum enumMixinStr_SIG_ATOMIC_MAX = `enum SIG_ATOMIC_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MAX); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MAX);
        }
    }




    static if(!is(typeof(SIZE_MAX))) {
        private enum enumMixinStr_SIZE_MAX = `enum SIZE_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_SIZE_MAX); }))) {
            mixin(enumMixinStr_SIZE_MAX);
        }
    }




    static if(!is(typeof(WCHAR_MIN))) {
        private enum enumMixinStr_WCHAR_MIN = `enum WCHAR_MIN = __WCHAR_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MIN); }))) {
            mixin(enumMixinStr_WCHAR_MIN);
        }
    }




    static if(!is(typeof(WCHAR_MAX))) {
        private enum enumMixinStr_WCHAR_MAX = `enum WCHAR_MAX = __WCHAR_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MAX); }))) {
            mixin(enumMixinStr_WCHAR_MAX);
        }
    }




    static if(!is(typeof(WINT_MIN))) {
        private enum enumMixinStr_WINT_MIN = `enum WINT_MIN = ( 0u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MIN); }))) {
            mixin(enumMixinStr_WINT_MIN);
        }
    }




    static if(!is(typeof(WINT_MAX))) {
        private enum enumMixinStr_WINT_MAX = `enum WINT_MAX = ( 4294967295u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MAX); }))) {
            mixin(enumMixinStr_WINT_MAX);
        }
    }
    static if(!is(typeof(__GLIBC_USE_LIB_EXT2))) {
        private enum enumMixinStr___GLIBC_USE_LIB_EXT2 = `enum __GLIBC_USE_LIB_EXT2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_LIB_EXT2); }))) {
            mixin(enumMixinStr___GLIBC_USE_LIB_EXT2);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT = `enum __GLIBC_USE_IEC_60559_BFP_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT = `enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT);
        }
    }




    static if(!is(typeof(_BITS_STDINT_INTN_H))) {
        private enum enumMixinStr__BITS_STDINT_INTN_H = `enum _BITS_STDINT_INTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_INTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_INTN_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_UINTN_H))) {
        private enum enumMixinStr__BITS_STDINT_UINTN_H = `enum _BITS_STDINT_UINTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_UINTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_UINTN_H);
        }
    }




    static if(!is(typeof(_BITS_TIME64_H))) {
        private enum enumMixinStr__BITS_TIME64_H = `enum _BITS_TIME64_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TIME64_H); }))) {
            mixin(enumMixinStr__BITS_TIME64_H);
        }
    }




    static if(!is(typeof(__TIME64_T_TYPE))) {
        private enum enumMixinStr___TIME64_T_TYPE = `enum __TIME64_T_TYPE = __TIME_T_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME64_T_TYPE); }))) {
            mixin(enumMixinStr___TIME64_T_TYPE);
        }
    }




    static if(!is(typeof(__TIMESIZE))) {
        private enum enumMixinStr___TIMESIZE = `enum __TIMESIZE = __WORDSIZE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMESIZE); }))) {
            mixin(enumMixinStr___TIMESIZE);
        }
    }




    static if(!is(typeof(_BITS_TYPES_H))) {
        private enum enumMixinStr__BITS_TYPES_H = `enum _BITS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES_H); }))) {
            mixin(enumMixinStr__BITS_TYPES_H);
        }
    }




    static if(!is(typeof(__S16_TYPE))) {
        private enum enumMixinStr___S16_TYPE = `enum __S16_TYPE = short int;`;
        static if(is(typeof({ mixin(enumMixinStr___S16_TYPE); }))) {
            mixin(enumMixinStr___S16_TYPE);
        }
    }




    static if(!is(typeof(__U16_TYPE))) {
        private enum enumMixinStr___U16_TYPE = `enum __U16_TYPE = unsigned short int;`;
        static if(is(typeof({ mixin(enumMixinStr___U16_TYPE); }))) {
            mixin(enumMixinStr___U16_TYPE);
        }
    }




    static if(!is(typeof(__S32_TYPE))) {
        private enum enumMixinStr___S32_TYPE = `enum __S32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___S32_TYPE); }))) {
            mixin(enumMixinStr___S32_TYPE);
        }
    }




    static if(!is(typeof(__U32_TYPE))) {
        private enum enumMixinStr___U32_TYPE = `enum __U32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___U32_TYPE); }))) {
            mixin(enumMixinStr___U32_TYPE);
        }
    }




    static if(!is(typeof(__SLONGWORD_TYPE))) {
        private enum enumMixinStr___SLONGWORD_TYPE = `enum __SLONGWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONGWORD_TYPE); }))) {
            mixin(enumMixinStr___SLONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__ULONGWORD_TYPE))) {
        private enum enumMixinStr___ULONGWORD_TYPE = `enum __ULONGWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONGWORD_TYPE); }))) {
            mixin(enumMixinStr___ULONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__SQUAD_TYPE))) {
        private enum enumMixinStr___SQUAD_TYPE = `enum __SQUAD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SQUAD_TYPE); }))) {
            mixin(enumMixinStr___SQUAD_TYPE);
        }
    }




    static if(!is(typeof(__UQUAD_TYPE))) {
        private enum enumMixinStr___UQUAD_TYPE = `enum __UQUAD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UQUAD_TYPE); }))) {
            mixin(enumMixinStr___UQUAD_TYPE);
        }
    }




    static if(!is(typeof(__SWORD_TYPE))) {
        private enum enumMixinStr___SWORD_TYPE = `enum __SWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SWORD_TYPE); }))) {
            mixin(enumMixinStr___SWORD_TYPE);
        }
    }




    static if(!is(typeof(__UWORD_TYPE))) {
        private enum enumMixinStr___UWORD_TYPE = `enum __UWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UWORD_TYPE); }))) {
            mixin(enumMixinStr___UWORD_TYPE);
        }
    }




    static if(!is(typeof(__SLONG32_TYPE))) {
        private enum enumMixinStr___SLONG32_TYPE = `enum __SLONG32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONG32_TYPE); }))) {
            mixin(enumMixinStr___SLONG32_TYPE);
        }
    }




    static if(!is(typeof(__ULONG32_TYPE))) {
        private enum enumMixinStr___ULONG32_TYPE = `enum __ULONG32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONG32_TYPE); }))) {
            mixin(enumMixinStr___ULONG32_TYPE);
        }
    }




    static if(!is(typeof(__S64_TYPE))) {
        private enum enumMixinStr___S64_TYPE = `enum __S64_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___S64_TYPE); }))) {
            mixin(enumMixinStr___S64_TYPE);
        }
    }




    static if(!is(typeof(__U64_TYPE))) {
        private enum enumMixinStr___U64_TYPE = `enum __U64_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___U64_TYPE); }))) {
            mixin(enumMixinStr___U64_TYPE);
        }
    }




    static if(!is(typeof(__STD_TYPE))) {
        private enum enumMixinStr___STD_TYPE = `enum __STD_TYPE = typedef;`;
        static if(is(typeof({ mixin(enumMixinStr___STD_TYPE); }))) {
            mixin(enumMixinStr___STD_TYPE);
        }
    }




    static if(!is(typeof(__time64_t))) {
        private enum enumMixinStr___time64_t = `enum __time64_t = __time_t;`;
        static if(is(typeof({ mixin(enumMixinStr___time64_t); }))) {
            mixin(enumMixinStr___time64_t);
        }
    }




    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        private enum enumMixinStr__BITS_TYPESIZES_H = `enum _BITS_TYPESIZES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPESIZES_H); }))) {
            mixin(enumMixinStr__BITS_TYPESIZES_H);
        }
    }




    static if(!is(typeof(__SYSCALL_SLONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_SLONG_TYPE = `enum __SYSCALL_SLONG_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_SLONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_SLONG_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_ULONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_ULONG_TYPE = `enum __SYSCALL_ULONG_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_ULONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_ULONG_TYPE);
        }
    }




    static if(!is(typeof(__DEV_T_TYPE))) {
        private enum enumMixinStr___DEV_T_TYPE = `enum __DEV_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___DEV_T_TYPE); }))) {
            mixin(enumMixinStr___DEV_T_TYPE);
        }
    }




    static if(!is(typeof(__UID_T_TYPE))) {
        private enum enumMixinStr___UID_T_TYPE = `enum __UID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___UID_T_TYPE); }))) {
            mixin(enumMixinStr___UID_T_TYPE);
        }
    }




    static if(!is(typeof(__GID_T_TYPE))) {
        private enum enumMixinStr___GID_T_TYPE = `enum __GID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___GID_T_TYPE); }))) {
            mixin(enumMixinStr___GID_T_TYPE);
        }
    }




    static if(!is(typeof(__INO_T_TYPE))) {
        private enum enumMixinStr___INO_T_TYPE = `enum __INO_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_TYPE); }))) {
            mixin(enumMixinStr___INO_T_TYPE);
        }
    }




    static if(!is(typeof(__INO64_T_TYPE))) {
        private enum enumMixinStr___INO64_T_TYPE = `enum __INO64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___INO64_T_TYPE); }))) {
            mixin(enumMixinStr___INO64_T_TYPE);
        }
    }




    static if(!is(typeof(__MODE_T_TYPE))) {
        private enum enumMixinStr___MODE_T_TYPE = `enum __MODE_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___MODE_T_TYPE); }))) {
            mixin(enumMixinStr___MODE_T_TYPE);
        }
    }




    static if(!is(typeof(__NLINK_T_TYPE))) {
        private enum enumMixinStr___NLINK_T_TYPE = `enum __NLINK_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___NLINK_T_TYPE); }))) {
            mixin(enumMixinStr___NLINK_T_TYPE);
        }
    }




    static if(!is(typeof(__FSWORD_T_TYPE))) {
        private enum enumMixinStr___FSWORD_T_TYPE = `enum __FSWORD_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSWORD_T_TYPE); }))) {
            mixin(enumMixinStr___FSWORD_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_TYPE))) {
        private enum enumMixinStr___OFF_T_TYPE = `enum __OFF_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_TYPE); }))) {
            mixin(enumMixinStr___OFF_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF64_T_TYPE))) {
        private enum enumMixinStr___OFF64_T_TYPE = `enum __OFF64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF64_T_TYPE); }))) {
            mixin(enumMixinStr___OFF64_T_TYPE);
        }
    }




    static if(!is(typeof(__PID_T_TYPE))) {
        private enum enumMixinStr___PID_T_TYPE = `enum __PID_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___PID_T_TYPE); }))) {
            mixin(enumMixinStr___PID_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM_T_TYPE))) {
        private enum enumMixinStr___RLIM_T_TYPE = `enum __RLIM_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM64_T_TYPE))) {
        private enum enumMixinStr___RLIM64_T_TYPE = `enum __RLIM64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM64_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM64_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT_T_TYPE))) {
        private enum enumMixinStr___BLKCNT_T_TYPE = `enum __BLKCNT_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT64_T_TYPE))) {
        private enum enumMixinStr___BLKCNT64_T_TYPE = `enum __BLKCNT64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT_T_TYPE = `enum __FSBLKCNT_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT64_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT64_T_TYPE = `enum __FSBLKCNT64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT_T_TYPE = `enum __FSFILCNT_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT64_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT64_T_TYPE = `enum __FSFILCNT64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__ID_T_TYPE))) {
        private enum enumMixinStr___ID_T_TYPE = `enum __ID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ID_T_TYPE); }))) {
            mixin(enumMixinStr___ID_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCK_T_TYPE))) {
        private enum enumMixinStr___CLOCK_T_TYPE = `enum __CLOCK_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCK_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCK_T_TYPE);
        }
    }




    static if(!is(typeof(__TIME_T_TYPE))) {
        private enum enumMixinStr___TIME_T_TYPE = `enum __TIME_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME_T_TYPE); }))) {
            mixin(enumMixinStr___TIME_T_TYPE);
        }
    }




    static if(!is(typeof(__USECONDS_T_TYPE))) {
        private enum enumMixinStr___USECONDS_T_TYPE = `enum __USECONDS_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___USECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___USECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS_T_TYPE = `enum __SUSECONDS_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__DADDR_T_TYPE))) {
        private enum enumMixinStr___DADDR_T_TYPE = `enum __DADDR_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___DADDR_T_TYPE); }))) {
            mixin(enumMixinStr___DADDR_T_TYPE);
        }
    }




    static if(!is(typeof(__KEY_T_TYPE))) {
        private enum enumMixinStr___KEY_T_TYPE = `enum __KEY_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___KEY_T_TYPE); }))) {
            mixin(enumMixinStr___KEY_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCKID_T_TYPE))) {
        private enum enumMixinStr___CLOCKID_T_TYPE = `enum __CLOCKID_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCKID_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCKID_T_TYPE);
        }
    }




    static if(!is(typeof(__TIMER_T_TYPE))) {
        private enum enumMixinStr___TIMER_T_TYPE = `enum __TIMER_T_TYPE = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMER_T_TYPE); }))) {
            mixin(enumMixinStr___TIMER_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKSIZE_T_TYPE))) {
        private enum enumMixinStr___BLKSIZE_T_TYPE = `enum __BLKSIZE_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___BLKSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__FSID_T_TYPE))) {
        private enum enumMixinStr___FSID_T_TYPE = `enum __FSID_T_TYPE = { int __val [ 2 ] ; };`;
        static if(is(typeof({ mixin(enumMixinStr___FSID_T_TYPE); }))) {
            mixin(enumMixinStr___FSID_T_TYPE);
        }
    }




    static if(!is(typeof(__SSIZE_T_TYPE))) {
        private enum enumMixinStr___SSIZE_T_TYPE = `enum __SSIZE_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___SSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__CPU_MASK_TYPE))) {
        private enum enumMixinStr___CPU_MASK_TYPE = `enum __CPU_MASK_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___CPU_MASK_TYPE); }))) {
            mixin(enumMixinStr___CPU_MASK_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        private enum enumMixinStr___OFF_T_MATCHES_OFF64_T = `enum __OFF_T_MATCHES_OFF64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T); }))) {
            mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T);
        }
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        private enum enumMixinStr___INO_T_MATCHES_INO64_T = `enum __INO_T_MATCHES_INO64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_MATCHES_INO64_T); }))) {
            mixin(enumMixinStr___INO_T_MATCHES_INO64_T);
        }
    }




    static if(!is(typeof(__RLIM_T_MATCHES_RLIM64_T))) {
        private enum enumMixinStr___RLIM_T_MATCHES_RLIM64_T = `enum __RLIM_T_MATCHES_RLIM64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T); }))) {
            mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T);
        }
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        private enum enumMixinStr___FD_SETSIZE = `enum __FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr___FD_SETSIZE); }))) {
            mixin(enumMixinStr___FD_SETSIZE);
        }
    }




    static if(!is(typeof(_BITS_WCHAR_H))) {
        private enum enumMixinStr__BITS_WCHAR_H = `enum _BITS_WCHAR_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_WCHAR_H); }))) {
            mixin(enumMixinStr__BITS_WCHAR_H);
        }
    }




    static if(!is(typeof(__WCHAR_MAX))) {
        private enum enumMixinStr___WCHAR_MAX = `enum __WCHAR_MAX = 0x7fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MAX); }))) {
            mixin(enumMixinStr___WCHAR_MAX);
        }
    }




    static if(!is(typeof(__WCHAR_MIN))) {
        private enum enumMixinStr___WCHAR_MIN = `enum __WCHAR_MIN = ( - 0x7fffffff - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MIN); }))) {
            mixin(enumMixinStr___WCHAR_MIN);
        }
    }




    static if(!is(typeof(__WORDSIZE))) {
        private enum enumMixinStr___WORDSIZE = `enum __WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE); }))) {
            mixin(enumMixinStr___WORDSIZE);
        }
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        private enum enumMixinStr___WORDSIZE_TIME64_COMPAT32 = `enum __WORDSIZE_TIME64_COMPAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32); }))) {
            mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32);
        }
    }




    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        private enum enumMixinStr___SYSCALL_WORDSIZE = `enum __SYSCALL_WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_WORDSIZE); }))) {
            mixin(enumMixinStr___SYSCALL_WORDSIZE);
        }
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        private enum enumMixinStr__SYS_CDEFS_H = `enum _SYS_CDEFS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_CDEFS_H); }))) {
            mixin(enumMixinStr__SYS_CDEFS_H);
        }
    }
    static if(!is(typeof(__THROW))) {
        private enum enumMixinStr___THROW = `enum __THROW = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROW); }))) {
            mixin(enumMixinStr___THROW);
        }
    }




    static if(!is(typeof(__THROWNL))) {
        private enum enumMixinStr___THROWNL = `enum __THROWNL = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROWNL); }))) {
            mixin(enumMixinStr___THROWNL);
        }
    }
    static if(!is(typeof(__ptr_t))) {
        private enum enumMixinStr___ptr_t = `enum __ptr_t = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___ptr_t); }))) {
            mixin(enumMixinStr___ptr_t);
        }
    }
    static if(!is(typeof(__flexarr))) {
        private enum enumMixinStr___flexarr = `enum __flexarr = [ ];`;
        static if(is(typeof({ mixin(enumMixinStr___flexarr); }))) {
            mixin(enumMixinStr___flexarr);
        }
    }




    static if(!is(typeof(__glibc_c99_flexarr_available))) {
        private enum enumMixinStr___glibc_c99_flexarr_available = `enum __glibc_c99_flexarr_available = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_c99_flexarr_available); }))) {
            mixin(enumMixinStr___glibc_c99_flexarr_available);
        }
    }
    static if(!is(typeof(__attribute_malloc__))) {
        private enum enumMixinStr___attribute_malloc__ = `enum __attribute_malloc__ = __attribute__ ( ( __malloc__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_malloc__); }))) {
            mixin(enumMixinStr___attribute_malloc__);
        }
    }






    static if(!is(typeof(__attribute_pure__))) {
        private enum enumMixinStr___attribute_pure__ = `enum __attribute_pure__ = __attribute__ ( ( __pure__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_pure__); }))) {
            mixin(enumMixinStr___attribute_pure__);
        }
    }




    static if(!is(typeof(__attribute_const__))) {
        private enum enumMixinStr___attribute_const__ = `enum __attribute_const__ = __attribute__ ( cast( __const__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_const__); }))) {
            mixin(enumMixinStr___attribute_const__);
        }
    }




    static if(!is(typeof(__attribute_used__))) {
        private enum enumMixinStr___attribute_used__ = `enum __attribute_used__ = __attribute__ ( ( __used__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_used__); }))) {
            mixin(enumMixinStr___attribute_used__);
        }
    }




    static if(!is(typeof(__attribute_noinline__))) {
        private enum enumMixinStr___attribute_noinline__ = `enum __attribute_noinline__ = __attribute__ ( ( __noinline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_noinline__); }))) {
            mixin(enumMixinStr___attribute_noinline__);
        }
    }




    static if(!is(typeof(__attribute_deprecated__))) {
        private enum enumMixinStr___attribute_deprecated__ = `enum __attribute_deprecated__ = __attribute__ ( ( __deprecated__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_deprecated__); }))) {
            mixin(enumMixinStr___attribute_deprecated__);
        }
    }
    static if(!is(typeof(__attribute_warn_unused_result__))) {
        private enum enumMixinStr___attribute_warn_unused_result__ = `enum __attribute_warn_unused_result__ = __attribute__ ( ( __warn_unused_result__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_warn_unused_result__); }))) {
            mixin(enumMixinStr___attribute_warn_unused_result__);
        }
    }






    static if(!is(typeof(__always_inline))) {
        private enum enumMixinStr___always_inline = `enum __always_inline = __inline __attribute__ ( ( __always_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___always_inline); }))) {
            mixin(enumMixinStr___always_inline);
        }
    }






    static if(!is(typeof(__extern_inline))) {
        private enum enumMixinStr___extern_inline = `enum __extern_inline = extern __inline __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_inline); }))) {
            mixin(enumMixinStr___extern_inline);
        }
    }




    static if(!is(typeof(__extern_always_inline))) {
        private enum enumMixinStr___extern_always_inline = `enum __extern_always_inline = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_always_inline); }))) {
            mixin(enumMixinStr___extern_always_inline);
        }
    }




    static if(!is(typeof(__fortify_function))) {
        private enum enumMixinStr___fortify_function = `enum __fortify_function = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) ) ;`;
        static if(is(typeof({ mixin(enumMixinStr___fortify_function); }))) {
            mixin(enumMixinStr___fortify_function);
        }
    }




    static if(!is(typeof(__restrict_arr))) {
        private enum enumMixinStr___restrict_arr = `enum __restrict_arr = __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr___restrict_arr); }))) {
            mixin(enumMixinStr___restrict_arr);
        }
    }
    static if(!is(typeof(__HAVE_GENERIC_SELECTION))) {
        private enum enumMixinStr___HAVE_GENERIC_SELECTION = `enum __HAVE_GENERIC_SELECTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_GENERIC_SELECTION); }))) {
            mixin(enumMixinStr___HAVE_GENERIC_SELECTION);
        }
    }
    static if(!is(typeof(NULL))) {
        private enum enumMixinStr_NULL = `enum NULL = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_NULL); }))) {
            mixin(enumMixinStr_NULL);
        }
    }





}



import external.libc.config;



@nogc:



auto _xSemaphoreCreateMutex()
{
    return xQueueCreateMutex(( cast( uint8_t ) 1U ));
}

auto _xSemaphoreCreateRecursiveMutex()
{
    return xQueueCreateMutex(( cast( uint8_t ) 4U ));
}

auto _vSemaphoreDelete(SemaphoreHandle_t xSemaphore)
{
    return vQueueDelete ( cast( QueueHandle_t ) ( xSemaphore ) );
}

alias xSemaphoreTake = xQueueSemaphoreTake;

auto _xSemaphoreGive(SemaphoreHandle_t xSemaphore)
{
    return xQueueGenericSend ( cast( QueueHandle_t ) ( xSemaphore ) , null , ( cast( TickType_t ) 0U ) , ( cast( BaseType_t ) 0 ) );
}

alias xSemaphoreTakeRecursive = xQueueTakeMutexRecursive;

alias xSemaphoreGiveRecursive = xQueueGiveMutexRecursive;

alias xSemaphoreCreateCounting = xQueueCreateCountingSemaphore;

extern(C) void vTaskSetThreadLocalStoragePointer( TaskHandle_t xTaskToSet,
                                        BaseType_t xIndex,
                                        void* pvValue ) nothrow @nogc;
extern(C) void* pvTaskGetThreadLocalStoragePointer( TaskHandle_t xTaskToQuery,
                                           BaseType_t xIndex ) nothrow @nogc;
