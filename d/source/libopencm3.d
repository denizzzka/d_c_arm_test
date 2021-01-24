


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
    void rcc_clock_setup_hse_3v3(const(rcc_clock_scale)*) @nogc nothrow;
    void rcc_clock_setup_pll(const(rcc_clock_scale)*) @nogc nothrow;
    uint rcc_system_clock_source() @nogc nothrow;
    void rcc_set_main_pll_hse(uint, uint, uint, uint, uint) @nogc nothrow;
    void rcc_set_main_pll_hsi(uint, uint, uint, uint, uint) @nogc nothrow;
    void rcc_set_rtcpre(uint) @nogc nothrow;
    void rcc_set_hpre(uint) @nogc nothrow;
    void rcc_set_ppre1(uint) @nogc nothrow;
    void rcc_set_ppre2(uint) @nogc nothrow;
    void rcc_set_pll_source(uint) @nogc nothrow;
    void rcc_set_sysclk_source(uint) @nogc nothrow;
    void rcc_pllsai_postscalers(ubyte, ubyte) @nogc nothrow;
    void rcc_pllsai_config(ushort, ushort, ushort, ushort) @nogc nothrow;
    void rcc_plli2s_config(ushort, ubyte) @nogc nothrow;
    void rcc_css_disable() @nogc nothrow;
    void rcc_css_enable() @nogc nothrow;
    void rcc_osc_off(rcc_osc) @nogc nothrow;
    void rcc_osc_on(rcc_osc) @nogc nothrow;
    void rcc_wait_for_sysclk_status(rcc_osc) @nogc nothrow;
    int rcc_css_int_flag() @nogc nothrow;
    void rcc_css_int_clear() @nogc nothrow;
    int rcc_osc_ready_int_flag(rcc_osc) @nogc nothrow;
    void rcc_osc_ready_int_disable(rcc_osc) @nogc nothrow;
    void rcc_osc_ready_int_enable(rcc_osc) @nogc nothrow;
    void rcc_osc_ready_int_clear(rcc_osc) @nogc nothrow;
    void gpio_set(uint, ushort) @nogc nothrow;
    void gpio_clear(uint, ushort) @nogc nothrow;
    ushort gpio_get(uint, ushort) @nogc nothrow;
    void gpio_toggle(uint, ushort) @nogc nothrow;
    ushort gpio_port_read(uint) @nogc nothrow;
    void gpio_port_write(uint, ushort) @nogc nothrow;
    void gpio_port_config_lock(uint, ushort) @nogc nothrow;
    enum rcc_periph_rst
    {
        RST_GPIOA = 512,
        RST_GPIOB = 513,
        RST_GPIOC = 514,
        RST_GPIOD = 515,
        RST_GPIOE = 516,
        RST_GPIOF = 517,
        RST_GPIOG = 518,
        RST_GPIOH = 519,
        RST_GPIOI = 520,
        RST_GPIOJ = 521,
        RST_GPIOK = 522,
        RST_CRC = 524,
        RST_DMA1 = 533,
        RST_DMA2 = 534,
        RST_DMA2D = 535,
        RST_ETHMAC = 537,
        RST_OTGHS = 541,
        RST_DCMI = 640,
        RST_CRYP = 644,
        RST_HASH = 645,
        RST_RNG = 646,
        RST_OTGFS = 647,
        RST_QSPI = 769,
        RST_FSMC = 768,
        RST_FMC = 768,
        RST_TIM2 = 1024,
        RST_TIM3 = 1025,
        RST_TIM4 = 1026,
        RST_TIM5 = 1027,
        RST_TIM6 = 1028,
        RST_TIM7 = 1029,
        RST_TIM12 = 1030,
        RST_TIM13 = 1031,
        RST_TIM14 = 1032,
        RST_WWDG = 1035,
        RST_SPI2 = 1038,
        RST_SPI3 = 1039,
        RST_USART2 = 1041,
        RST_USART3 = 1042,
        RST_UART4 = 1043,
        RST_UART5 = 1044,
        RST_I2C1 = 1045,
        RST_I2C2 = 1046,
        RST_I2C3 = 1047,
        RST_CAN1 = 1049,
        RST_CAN2 = 1050,
        RST_PWR = 1052,
        RST_DAC = 1053,
        RST_UART7 = 1054,
        RST_UART8 = 1055,
        RST_TIM1 = 1152,
        RST_TIM8 = 1153,
        RST_USART1 = 1156,
        RST_USART6 = 1157,
        RST_ADC = 1160,
        RST_SDIO = 1163,
        RST_SPI1 = 1164,
        RST_SPI4 = 1165,
        RST_SYSCFG = 1166,
        RST_TIM9 = 1168,
        RST_TIM10 = 1169,
        RST_TIM11 = 1170,
        RST_SPI5 = 1172,
        RST_SPI6 = 1173,
        RST_SAI1RST = 1174,
        RST_LTDC = 1178,
        RST_DSI = 1179,
    }
    enum RST_GPIOA = rcc_periph_rst.RST_GPIOA;
    enum RST_GPIOB = rcc_periph_rst.RST_GPIOB;
    enum RST_GPIOC = rcc_periph_rst.RST_GPIOC;
    enum RST_GPIOD = rcc_periph_rst.RST_GPIOD;
    enum RST_GPIOE = rcc_periph_rst.RST_GPIOE;
    enum RST_GPIOF = rcc_periph_rst.RST_GPIOF;
    enum RST_GPIOG = rcc_periph_rst.RST_GPIOG;
    enum RST_GPIOH = rcc_periph_rst.RST_GPIOH;
    enum RST_GPIOI = rcc_periph_rst.RST_GPIOI;
    enum RST_GPIOJ = rcc_periph_rst.RST_GPIOJ;
    enum RST_GPIOK = rcc_periph_rst.RST_GPIOK;
    enum RST_CRC = rcc_periph_rst.RST_CRC;
    enum RST_DMA1 = rcc_periph_rst.RST_DMA1;
    enum RST_DMA2 = rcc_periph_rst.RST_DMA2;
    enum RST_DMA2D = rcc_periph_rst.RST_DMA2D;
    enum RST_ETHMAC = rcc_periph_rst.RST_ETHMAC;
    enum RST_OTGHS = rcc_periph_rst.RST_OTGHS;
    enum RST_DCMI = rcc_periph_rst.RST_DCMI;
    enum RST_CRYP = rcc_periph_rst.RST_CRYP;
    enum RST_HASH = rcc_periph_rst.RST_HASH;
    enum RST_RNG = rcc_periph_rst.RST_RNG;
    enum RST_OTGFS = rcc_periph_rst.RST_OTGFS;
    enum RST_QSPI = rcc_periph_rst.RST_QSPI;
    enum RST_FSMC = rcc_periph_rst.RST_FSMC;
    enum RST_FMC = rcc_periph_rst.RST_FMC;
    enum RST_TIM2 = rcc_periph_rst.RST_TIM2;
    enum RST_TIM3 = rcc_periph_rst.RST_TIM3;
    enum RST_TIM4 = rcc_periph_rst.RST_TIM4;
    enum RST_TIM5 = rcc_periph_rst.RST_TIM5;
    enum RST_TIM6 = rcc_periph_rst.RST_TIM6;
    enum RST_TIM7 = rcc_periph_rst.RST_TIM7;
    enum RST_TIM12 = rcc_periph_rst.RST_TIM12;
    enum RST_TIM13 = rcc_periph_rst.RST_TIM13;
    enum RST_TIM14 = rcc_periph_rst.RST_TIM14;
    enum RST_WWDG = rcc_periph_rst.RST_WWDG;
    enum RST_SPI2 = rcc_periph_rst.RST_SPI2;
    enum RST_SPI3 = rcc_periph_rst.RST_SPI3;
    enum RST_USART2 = rcc_periph_rst.RST_USART2;
    enum RST_USART3 = rcc_periph_rst.RST_USART3;
    enum RST_UART4 = rcc_periph_rst.RST_UART4;
    enum RST_UART5 = rcc_periph_rst.RST_UART5;
    enum RST_I2C1 = rcc_periph_rst.RST_I2C1;
    enum RST_I2C2 = rcc_periph_rst.RST_I2C2;
    enum RST_I2C3 = rcc_periph_rst.RST_I2C3;
    enum RST_CAN1 = rcc_periph_rst.RST_CAN1;
    enum RST_CAN2 = rcc_periph_rst.RST_CAN2;
    enum RST_PWR = rcc_periph_rst.RST_PWR;
    enum RST_DAC = rcc_periph_rst.RST_DAC;
    enum RST_UART7 = rcc_periph_rst.RST_UART7;
    enum RST_UART8 = rcc_periph_rst.RST_UART8;
    enum RST_TIM1 = rcc_periph_rst.RST_TIM1;
    enum RST_TIM8 = rcc_periph_rst.RST_TIM8;
    enum RST_USART1 = rcc_periph_rst.RST_USART1;
    enum RST_USART6 = rcc_periph_rst.RST_USART6;
    enum RST_ADC = rcc_periph_rst.RST_ADC;
    enum RST_SDIO = rcc_periph_rst.RST_SDIO;
    enum RST_SPI1 = rcc_periph_rst.RST_SPI1;
    enum RST_SPI4 = rcc_periph_rst.RST_SPI4;
    enum RST_SYSCFG = rcc_periph_rst.RST_SYSCFG;
    enum RST_TIM9 = rcc_periph_rst.RST_TIM9;
    enum RST_TIM10 = rcc_periph_rst.RST_TIM10;
    enum RST_TIM11 = rcc_periph_rst.RST_TIM11;
    enum RST_SPI5 = rcc_periph_rst.RST_SPI5;
    enum RST_SPI6 = rcc_periph_rst.RST_SPI6;
    enum RST_SAI1RST = rcc_periph_rst.RST_SAI1RST;
    enum RST_LTDC = rcc_periph_rst.RST_LTDC;
    enum RST_DSI = rcc_periph_rst.RST_DSI;
    void gpio_mode_setup(uint, ubyte, ubyte, ushort) @nogc nothrow;
    void gpio_set_output_options(uint, ubyte, ubyte, ushort) @nogc nothrow;
    void gpio_set_af(uint, ubyte, ushort) @nogc nothrow;
    enum rcc_periph_clken
    {
        RCC_GPIOA = 1536,
        RCC_GPIOB = 1537,
        RCC_GPIOC = 1538,
        RCC_GPIOD = 1539,
        RCC_GPIOE = 1540,
        RCC_GPIOF = 1541,
        RCC_GPIOG = 1542,
        RCC_GPIOH = 1543,
        RCC_GPIOI = 1544,
        RCC_GPIOJ = 1545,
        RCC_GPIOK = 1546,
        RCC_CRC = 1548,
        RCC_BKPSRAM = 1554,
        RCC_CCMDATARAM = 1556,
        RCC_DMA1 = 1557,
        RCC_DMA2 = 1558,
        RCC_DMA2D = 1559,
        RCC_ETHMAC = 1561,
        RCC_ETHMACTX = 1562,
        RCC_ETHMACRX = 1563,
        RCC_ETHMACPTP = 1564,
        RCC_OTGHS = 1565,
        RCC_OTGHSULPI = 1566,
        RCC_DCMI = 1664,
        RCC_CRYP = 1668,
        RCC_HASH = 1669,
        RCC_RNG = 1670,
        RCC_OTGFS = 1671,
        RCC_FSMC = 1792,
        RCC_FMC = 1792,
        RCC_QUADSPI = 1793,
        RCC_TIM2 = 2048,
        RCC_TIM3 = 2049,
        RCC_TIM4 = 2050,
        RCC_TIM5 = 2051,
        RCC_TIM6 = 2052,
        RCC_TIM7 = 2053,
        RCC_TIM12 = 2054,
        RCC_TIM13 = 2055,
        RCC_TIM14 = 2056,
        RCC_WWDG = 2059,
        RCC_SPI2 = 2062,
        RCC_SPI3 = 2063,
        RCC_USART2 = 2065,
        RCC_USART3 = 2066,
        RCC_UART4 = 2067,
        RCC_UART5 = 2068,
        RCC_I2C1 = 2069,
        RCC_I2C2 = 2070,
        RCC_I2C3 = 2071,
        RCC_CAN1 = 2073,
        RCC_CAN2 = 2074,
        RCC_PWR = 2076,
        RCC_DAC = 2077,
        RCC_UART7 = 2078,
        RCC_UART8 = 2079,
        RCC_TIM1 = 2176,
        RCC_TIM8 = 2177,
        RCC_USART1 = 2180,
        RCC_USART6 = 2181,
        RCC_ADC1 = 2184,
        RCC_ADC2 = 2185,
        RCC_ADC3 = 2186,
        RCC_SDIO = 2187,
        RCC_SPI1 = 2188,
        RCC_SPI4 = 2189,
        RCC_SYSCFG = 2190,
        RCC_TIM9 = 2192,
        RCC_TIM10 = 2193,
        RCC_TIM11 = 2194,
        RCC_SPI5 = 2196,
        RCC_SPI6 = 2197,
        RCC_SAI1EN = 2198,
        RCC_LTDC = 2202,
        RCC_DSI = 2203,
        RCC_RTC = 3599,
        SCC_GPIOA = 2560,
        SCC_GPIOB = 2561,
        SCC_GPIOC = 2562,
        SCC_GPIOD = 2563,
        SCC_GPIOE = 2564,
        SCC_GPIOF = 2565,
        SCC_GPIOG = 2566,
        SCC_GPIOH = 2567,
        SCC_GPIOI = 2568,
        SCC_GPIOJ = 2569,
        SCC_GPIOK = 2570,
        SCC_CRC = 2572,
        SCC_FLTIF = 2575,
        SCC_SRAM1 = 2576,
        SCC_SRAM2 = 2577,
        SCC_BKPSRAM = 2578,
        SCC_SRAM3 = 2579,
        SCC_DMA1 = 2581,
        SCC_DMA2 = 2582,
        SCC_DMA2D = 2583,
        SCC_ETHMAC = 2585,
        SCC_ETHMACTX = 2586,
        SCC_ETHMACRX = 2587,
        SCC_ETHMACPTP = 2588,
        SCC_OTGHS = 2589,
        SCC_OTGHSULPI = 2590,
        SCC_DCMI = 2688,
        SCC_CRYP = 2692,
        SCC_HASH = 2693,
        SCC_RNG = 2694,
        SCC_OTGFS = 2695,
        SCC_QSPIC = 2817,
        SCC_FMC = 2816,
        SCC_FSMC = 2816,
        SCC_TIM2 = 3072,
        SCC_TIM3 = 3073,
        SCC_TIM4 = 3074,
        SCC_TIM5 = 3075,
        SCC_TIM6 = 3076,
        SCC_TIM7 = 3077,
        SCC_TIM12 = 3078,
        SCC_TIM13 = 3079,
        SCC_TIM14 = 3080,
        SCC_WWDG = 3083,
        SCC_SPI2 = 3086,
        SCC_SPI3 = 3087,
        SCC_USART2 = 3089,
        SCC_USART3 = 3090,
        SCC_UART4 = 3091,
        SCC_UART5 = 3092,
        SCC_I2C1 = 3093,
        SCC_I2C2 = 3094,
        SCC_I2C3 = 3095,
        SCC_CAN1 = 3097,
        SCC_CAN2 = 3098,
        SCC_PWR = 3100,
        SCC_DAC = 3101,
        SCC_UART7 = 3102,
        SCC_UART8 = 3103,
        SCC_TIM1 = 3200,
        SCC_TIM8 = 3201,
        SCC_USART1 = 3204,
        SCC_USART6 = 3205,
        SCC_ADC1 = 3208,
        SCC_ADC2 = 3209,
        SCC_ADC3 = 3210,
        SCC_SDIO = 3211,
        SCC_SPI1 = 3212,
        SCC_SPI4 = 3213,
        SCC_SYSCFG = 3214,
        SCC_TIM9 = 3216,
        SCC_TIM10 = 3217,
        SCC_TIM11 = 3218,
        SCC_SPI5 = 3220,
        SCC_SPI6 = 3221,
        SCC_SAI1 = 3222,
        SCC_LTDC = 3226,
        SCC_DSI = 3227,
    }
    enum RCC_GPIOA = rcc_periph_clken.RCC_GPIOA;
    enum RCC_GPIOB = rcc_periph_clken.RCC_GPIOB;
    enum RCC_GPIOC = rcc_periph_clken.RCC_GPIOC;
    enum RCC_GPIOD = rcc_periph_clken.RCC_GPIOD;
    enum RCC_GPIOE = rcc_periph_clken.RCC_GPIOE;
    enum RCC_GPIOF = rcc_periph_clken.RCC_GPIOF;
    enum RCC_GPIOG = rcc_periph_clken.RCC_GPIOG;
    enum RCC_GPIOH = rcc_periph_clken.RCC_GPIOH;
    enum RCC_GPIOI = rcc_periph_clken.RCC_GPIOI;
    enum RCC_GPIOJ = rcc_periph_clken.RCC_GPIOJ;
    enum RCC_GPIOK = rcc_periph_clken.RCC_GPIOK;
    enum RCC_CRC = rcc_periph_clken.RCC_CRC;
    enum RCC_BKPSRAM = rcc_periph_clken.RCC_BKPSRAM;
    enum RCC_CCMDATARAM = rcc_periph_clken.RCC_CCMDATARAM;
    enum RCC_DMA1 = rcc_periph_clken.RCC_DMA1;
    enum RCC_DMA2 = rcc_periph_clken.RCC_DMA2;
    enum RCC_DMA2D = rcc_periph_clken.RCC_DMA2D;
    enum RCC_ETHMAC = rcc_periph_clken.RCC_ETHMAC;
    enum RCC_ETHMACTX = rcc_periph_clken.RCC_ETHMACTX;
    enum RCC_ETHMACRX = rcc_periph_clken.RCC_ETHMACRX;
    enum RCC_ETHMACPTP = rcc_periph_clken.RCC_ETHMACPTP;
    enum RCC_OTGHS = rcc_periph_clken.RCC_OTGHS;
    enum RCC_OTGHSULPI = rcc_periph_clken.RCC_OTGHSULPI;
    enum RCC_DCMI = rcc_periph_clken.RCC_DCMI;
    enum RCC_CRYP = rcc_periph_clken.RCC_CRYP;
    enum RCC_HASH = rcc_periph_clken.RCC_HASH;
    enum RCC_RNG = rcc_periph_clken.RCC_RNG;
    enum RCC_OTGFS = rcc_periph_clken.RCC_OTGFS;
    enum RCC_FSMC = rcc_periph_clken.RCC_FSMC;
    enum RCC_FMC = rcc_periph_clken.RCC_FMC;
    enum RCC_QUADSPI = rcc_periph_clken.RCC_QUADSPI;
    enum RCC_TIM2 = rcc_periph_clken.RCC_TIM2;
    enum RCC_TIM3 = rcc_periph_clken.RCC_TIM3;
    enum RCC_TIM4 = rcc_periph_clken.RCC_TIM4;
    enum RCC_TIM5 = rcc_periph_clken.RCC_TIM5;
    enum RCC_TIM6 = rcc_periph_clken.RCC_TIM6;
    enum RCC_TIM7 = rcc_periph_clken.RCC_TIM7;
    enum RCC_TIM12 = rcc_periph_clken.RCC_TIM12;
    enum RCC_TIM13 = rcc_periph_clken.RCC_TIM13;
    enum RCC_TIM14 = rcc_periph_clken.RCC_TIM14;
    enum RCC_WWDG = rcc_periph_clken.RCC_WWDG;
    enum RCC_SPI2 = rcc_periph_clken.RCC_SPI2;
    enum RCC_SPI3 = rcc_periph_clken.RCC_SPI3;
    enum RCC_USART2 = rcc_periph_clken.RCC_USART2;
    enum RCC_USART3 = rcc_periph_clken.RCC_USART3;
    enum RCC_UART4 = rcc_periph_clken.RCC_UART4;
    enum RCC_UART5 = rcc_periph_clken.RCC_UART5;
    enum RCC_I2C1 = rcc_periph_clken.RCC_I2C1;
    enum RCC_I2C2 = rcc_periph_clken.RCC_I2C2;
    enum RCC_I2C3 = rcc_periph_clken.RCC_I2C3;
    enum RCC_CAN1 = rcc_periph_clken.RCC_CAN1;
    enum RCC_CAN2 = rcc_periph_clken.RCC_CAN2;
    enum RCC_PWR = rcc_periph_clken.RCC_PWR;
    enum RCC_DAC = rcc_periph_clken.RCC_DAC;
    enum RCC_UART7 = rcc_periph_clken.RCC_UART7;
    enum RCC_UART8 = rcc_periph_clken.RCC_UART8;
    enum RCC_TIM1 = rcc_periph_clken.RCC_TIM1;
    enum RCC_TIM8 = rcc_periph_clken.RCC_TIM8;
    enum RCC_USART1 = rcc_periph_clken.RCC_USART1;
    enum RCC_USART6 = rcc_periph_clken.RCC_USART6;
    enum RCC_ADC1 = rcc_periph_clken.RCC_ADC1;
    enum RCC_ADC2 = rcc_periph_clken.RCC_ADC2;
    enum RCC_ADC3 = rcc_periph_clken.RCC_ADC3;
    enum RCC_SDIO = rcc_periph_clken.RCC_SDIO;
    enum RCC_SPI1 = rcc_periph_clken.RCC_SPI1;
    enum RCC_SPI4 = rcc_periph_clken.RCC_SPI4;
    enum RCC_SYSCFG = rcc_periph_clken.RCC_SYSCFG;
    enum RCC_TIM9 = rcc_periph_clken.RCC_TIM9;
    enum RCC_TIM10 = rcc_periph_clken.RCC_TIM10;
    enum RCC_TIM11 = rcc_periph_clken.RCC_TIM11;
    enum RCC_SPI5 = rcc_periph_clken.RCC_SPI5;
    enum RCC_SPI6 = rcc_periph_clken.RCC_SPI6;
    enum RCC_SAI1EN = rcc_periph_clken.RCC_SAI1EN;
    enum RCC_LTDC = rcc_periph_clken.RCC_LTDC;
    enum RCC_DSI = rcc_periph_clken.RCC_DSI;
    enum RCC_RTC = rcc_periph_clken.RCC_RTC;
    enum SCC_GPIOA = rcc_periph_clken.SCC_GPIOA;
    enum SCC_GPIOB = rcc_periph_clken.SCC_GPIOB;
    enum SCC_GPIOC = rcc_periph_clken.SCC_GPIOC;
    enum SCC_GPIOD = rcc_periph_clken.SCC_GPIOD;
    enum SCC_GPIOE = rcc_periph_clken.SCC_GPIOE;
    enum SCC_GPIOF = rcc_periph_clken.SCC_GPIOF;
    enum SCC_GPIOG = rcc_periph_clken.SCC_GPIOG;
    enum SCC_GPIOH = rcc_periph_clken.SCC_GPIOH;
    enum SCC_GPIOI = rcc_periph_clken.SCC_GPIOI;
    enum SCC_GPIOJ = rcc_periph_clken.SCC_GPIOJ;
    enum SCC_GPIOK = rcc_periph_clken.SCC_GPIOK;
    enum SCC_CRC = rcc_periph_clken.SCC_CRC;
    enum SCC_FLTIF = rcc_periph_clken.SCC_FLTIF;
    enum SCC_SRAM1 = rcc_periph_clken.SCC_SRAM1;
    enum SCC_SRAM2 = rcc_periph_clken.SCC_SRAM2;
    enum SCC_BKPSRAM = rcc_periph_clken.SCC_BKPSRAM;
    enum SCC_SRAM3 = rcc_periph_clken.SCC_SRAM3;
    enum SCC_DMA1 = rcc_periph_clken.SCC_DMA1;
    enum SCC_DMA2 = rcc_periph_clken.SCC_DMA2;
    enum SCC_DMA2D = rcc_periph_clken.SCC_DMA2D;
    enum SCC_ETHMAC = rcc_periph_clken.SCC_ETHMAC;
    enum SCC_ETHMACTX = rcc_periph_clken.SCC_ETHMACTX;
    enum SCC_ETHMACRX = rcc_periph_clken.SCC_ETHMACRX;
    enum SCC_ETHMACPTP = rcc_periph_clken.SCC_ETHMACPTP;
    enum SCC_OTGHS = rcc_periph_clken.SCC_OTGHS;
    enum SCC_OTGHSULPI = rcc_periph_clken.SCC_OTGHSULPI;
    enum SCC_DCMI = rcc_periph_clken.SCC_DCMI;
    enum SCC_CRYP = rcc_periph_clken.SCC_CRYP;
    enum SCC_HASH = rcc_periph_clken.SCC_HASH;
    enum SCC_RNG = rcc_periph_clken.SCC_RNG;
    enum SCC_OTGFS = rcc_periph_clken.SCC_OTGFS;
    enum SCC_QSPIC = rcc_periph_clken.SCC_QSPIC;
    enum SCC_FMC = rcc_periph_clken.SCC_FMC;
    enum SCC_FSMC = rcc_periph_clken.SCC_FSMC;
    enum SCC_TIM2 = rcc_periph_clken.SCC_TIM2;
    enum SCC_TIM3 = rcc_periph_clken.SCC_TIM3;
    enum SCC_TIM4 = rcc_periph_clken.SCC_TIM4;
    enum SCC_TIM5 = rcc_periph_clken.SCC_TIM5;
    enum SCC_TIM6 = rcc_periph_clken.SCC_TIM6;
    enum SCC_TIM7 = rcc_periph_clken.SCC_TIM7;
    enum SCC_TIM12 = rcc_periph_clken.SCC_TIM12;
    enum SCC_TIM13 = rcc_periph_clken.SCC_TIM13;
    enum SCC_TIM14 = rcc_periph_clken.SCC_TIM14;
    enum SCC_WWDG = rcc_periph_clken.SCC_WWDG;
    enum SCC_SPI2 = rcc_periph_clken.SCC_SPI2;
    enum SCC_SPI3 = rcc_periph_clken.SCC_SPI3;
    enum SCC_USART2 = rcc_periph_clken.SCC_USART2;
    enum SCC_USART3 = rcc_periph_clken.SCC_USART3;
    enum SCC_UART4 = rcc_periph_clken.SCC_UART4;
    enum SCC_UART5 = rcc_periph_clken.SCC_UART5;
    enum SCC_I2C1 = rcc_periph_clken.SCC_I2C1;
    enum SCC_I2C2 = rcc_periph_clken.SCC_I2C2;
    enum SCC_I2C3 = rcc_periph_clken.SCC_I2C3;
    enum SCC_CAN1 = rcc_periph_clken.SCC_CAN1;
    enum SCC_CAN2 = rcc_periph_clken.SCC_CAN2;
    enum SCC_PWR = rcc_periph_clken.SCC_PWR;
    enum SCC_DAC = rcc_periph_clken.SCC_DAC;
    enum SCC_UART7 = rcc_periph_clken.SCC_UART7;
    enum SCC_UART8 = rcc_periph_clken.SCC_UART8;
    enum SCC_TIM1 = rcc_periph_clken.SCC_TIM1;
    enum SCC_TIM8 = rcc_periph_clken.SCC_TIM8;
    enum SCC_USART1 = rcc_periph_clken.SCC_USART1;
    enum SCC_USART6 = rcc_periph_clken.SCC_USART6;
    enum SCC_ADC1 = rcc_periph_clken.SCC_ADC1;
    enum SCC_ADC2 = rcc_periph_clken.SCC_ADC2;
    enum SCC_ADC3 = rcc_periph_clken.SCC_ADC3;
    enum SCC_SDIO = rcc_periph_clken.SCC_SDIO;
    enum SCC_SPI1 = rcc_periph_clken.SCC_SPI1;
    enum SCC_SPI4 = rcc_periph_clken.SCC_SPI4;
    enum SCC_SYSCFG = rcc_periph_clken.SCC_SYSCFG;
    enum SCC_TIM9 = rcc_periph_clken.SCC_TIM9;
    enum SCC_TIM10 = rcc_periph_clken.SCC_TIM10;
    enum SCC_TIM11 = rcc_periph_clken.SCC_TIM11;
    enum SCC_SPI5 = rcc_periph_clken.SCC_SPI5;
    enum SCC_SPI6 = rcc_periph_clken.SCC_SPI6;
    enum SCC_SAI1 = rcc_periph_clken.SCC_SAI1;
    enum SCC_LTDC = rcc_periph_clken.SCC_LTDC;
    enum SCC_DSI = rcc_periph_clken.SCC_DSI;
    enum rcc_osc
    {
        RCC_PLL = 0,
        RCC_PLLSAI = 1,
        RCC_PLLI2S = 2,
        RCC_HSE = 3,
        RCC_HSI = 4,
        RCC_LSE = 5,
        RCC_LSI = 6,
    }
    enum RCC_PLL = rcc_osc.RCC_PLL;
    enum RCC_PLLSAI = rcc_osc.RCC_PLLSAI;
    enum RCC_PLLI2S = rcc_osc.RCC_PLLI2S;
    enum RCC_HSE = rcc_osc.RCC_HSE;
    enum RCC_HSI = rcc_osc.RCC_HSI;
    enum RCC_LSE = rcc_osc.RCC_LSE;
    enum RCC_LSI = rcc_osc.RCC_LSI;
    extern __gshared const(rcc_clock_scale)[3] rcc_hse_25mhz_3v3;
    extern __gshared const(rcc_clock_scale)[3] rcc_hse_16mhz_3v3;
    extern __gshared const(rcc_clock_scale)[3] rcc_hse_12mhz_3v3;
    extern __gshared const(rcc_clock_scale)[3] rcc_hse_8mhz_3v3;
    extern __gshared const(rcc_clock_scale)[3] rcc_hsi_configs;
    struct rcc_clock_scale
    {
        ubyte pllm;
        ushort plln;
        ubyte pllp;
        ubyte pllq;
        ubyte pllr;
        ubyte pll_source;
        uint flash_config;
        ubyte hpre;
        ubyte ppre1;
        ubyte ppre2;
        pwr_vos_scale voltage_scale;
        uint ahb_frequency;
        uint apb1_frequency;
        uint apb2_frequency;
    }
    void pwr_disable_backup_domain_write_protect() @nogc nothrow;
    void pwr_enable_backup_domain_write_protect() @nogc nothrow;
    void pwr_enable_power_voltage_detect(uint) @nogc nothrow;
    void pwr_disable_power_voltage_detect() @nogc nothrow;
    void pwr_clear_standby_flag() @nogc nothrow;
    void pwr_clear_wakeup_flag() @nogc nothrow;
    void pwr_set_standby_mode() @nogc nothrow;
    void pwr_set_stop_mode() @nogc nothrow;
    void pwr_voltage_regulator_on_in_stop() @nogc nothrow;
    void pwr_voltage_regulator_low_power_in_stop() @nogc nothrow;
    void pwr_enable_wakeup_pin() @nogc nothrow;
    void pwr_disable_wakeup_pin() @nogc nothrow;
    bool pwr_voltage_high() @nogc nothrow;
    bool pwr_get_standby_flag() @nogc nothrow;
    bool pwr_get_wakeup_flag() @nogc nothrow;
    enum rcc_clock_3v3
    {
        RCC_CLOCK_3V3_84MHZ = 0,
        RCC_CLOCK_3V3_168MHZ = 1,
        RCC_CLOCK_3V3_180MHZ = 2,
        RCC_CLOCK_3V3_END = 3,
    }
    enum RCC_CLOCK_3V3_84MHZ = rcc_clock_3v3.RCC_CLOCK_3V3_84MHZ;
    enum RCC_CLOCK_3V3_168MHZ = rcc_clock_3v3.RCC_CLOCK_3V3_168MHZ;
    enum RCC_CLOCK_3V3_180MHZ = rcc_clock_3v3.RCC_CLOCK_3V3_180MHZ;
    enum RCC_CLOCK_3V3_END = rcc_clock_3v3.RCC_CLOCK_3V3_END;
    void rcc_peripheral_enable_clock(uint*, uint) @nogc nothrow;
    void rcc_peripheral_disable_clock(uint*, uint) @nogc nothrow;
    void rcc_peripheral_reset(uint*, uint) @nogc nothrow;
    void rcc_peripheral_clear_reset(uint*, uint) @nogc nothrow;
    void rcc_periph_clock_enable(rcc_periph_clken) @nogc nothrow;
    void rcc_periph_clock_disable(rcc_periph_clken) @nogc nothrow;
    void rcc_periph_reset_pulse(rcc_periph_rst) @nogc nothrow;
    void rcc_periph_reset_hold(rcc_periph_rst) @nogc nothrow;
    void rcc_periph_reset_release(rcc_periph_rst) @nogc nothrow;
    void rcc_set_mco(uint) @nogc nothrow;
    void rcc_osc_bypass_enable(rcc_osc) @nogc nothrow;
    void rcc_osc_bypass_disable(rcc_osc) @nogc nothrow;
    bool rcc_is_osc_ready(rcc_osc) @nogc nothrow;
    void rcc_wait_for_osc_ready(rcc_osc) @nogc nothrow;
    extern __gshared uint rcc_apb2_frequency;
    extern __gshared uint rcc_apb1_frequency;
    extern __gshared uint rcc_ahb_frequency;
    void pwr_set_vos_scale(pwr_vos_scale) @nogc nothrow;
    enum pwr_vos_scale
    {
        PWR_SCALE1 = 3,
        PWR_SCALE2 = 2,
        PWR_SCALE3 = 1,
    }
    enum PWR_SCALE1 = pwr_vos_scale.PWR_SCALE1;
    enum PWR_SCALE2 = pwr_vos_scale.PWR_SCALE2;
    enum PWR_SCALE3 = pwr_vos_scale.PWR_SCALE3;
    void spi_set_frf_motorola(uint) @nogc nothrow;
    void spi_set_frf_ti(uint) @nogc nothrow;
    void spi_set_dff_16bit(uint) @nogc nothrow;
    void spi_set_dff_8bit(uint) @nogc nothrow;
    int spi_init_master(uint, uint, uint, uint, uint, uint) @nogc nothrow;
    void spi_set_standard_mode(uint, ubyte) @nogc nothrow;
    void spi_disable_rx_dma(uint) @nogc nothrow;
    void spi_enable_rx_dma(uint) @nogc nothrow;
    void spi_disable_tx_dma(uint) @nogc nothrow;
    void spi_enable_tx_dma(uint) @nogc nothrow;
    void spi_disable_ss_output(uint) @nogc nothrow;
    void spi_enable_ss_output(uint) @nogc nothrow;
    void spi_disable_error_interrupt(uint) @nogc nothrow;
    void spi_enable_error_interrupt(uint) @nogc nothrow;
    void spi_disable_rx_buffer_not_empty_interrupt(uint) @nogc nothrow;
    void spi_enable_rx_buffer_not_empty_interrupt(uint) @nogc nothrow;
    void spi_disable_tx_buffer_empty_interrupt(uint) @nogc nothrow;
    void spi_enable_tx_buffer_empty_interrupt(uint) @nogc nothrow;
    void spi_set_clock_phase_0(uint) @nogc nothrow;
    void spi_set_clock_phase_1(uint) @nogc nothrow;
    void spi_set_clock_polarity_0(uint) @nogc nothrow;
    void spi_set_clock_polarity_1(uint) @nogc nothrow;
    void spi_set_slave_mode(uint) @nogc nothrow;
    void spi_set_master_mode(uint) @nogc nothrow;
    void spi_set_baudrate_prescaler(uint, ubyte) @nogc nothrow;
    void spi_send_msb_first(uint) @nogc nothrow;
    void spi_send_lsb_first(uint) @nogc nothrow;
    void spi_set_nss_low(uint) @nogc nothrow;
    void spi_set_nss_high(uint) @nogc nothrow;
    void spi_enable_software_slave_management(uint) @nogc nothrow;
    void spi_disable_software_slave_management(uint) @nogc nothrow;
    void spi_set_receive_only_mode(uint) @nogc nothrow;
    void spi_set_full_duplex_mode(uint) @nogc nothrow;
    void spi_set_next_tx_from_crc(uint) @nogc nothrow;
    void spi_set_next_tx_from_buffer(uint) @nogc nothrow;
    void spi_disable_crc(uint) @nogc nothrow;
    void spi_enable_crc(uint) @nogc nothrow;
    void spi_set_bidirectional_transmit_only_mode(uint) @nogc nothrow;
    void spi_set_bidirectional_receive_only_mode(uint) @nogc nothrow;
    void spi_set_unidirectional_mode(uint) @nogc nothrow;
    void spi_set_bidirectional_mode(uint) @nogc nothrow;
    ushort spi_xfer(uint, ushort) @nogc nothrow;
    ushort spi_read(uint) @nogc nothrow;
    void spi_send(uint, ushort) @nogc nothrow;
    void spi_write(uint, ushort) @nogc nothrow;
    ushort spi_clean_disable(uint) @nogc nothrow;
    void spi_disable(uint) @nogc nothrow;
    void spi_enable(uint) @nogc nothrow;
    void spi_reset(uint) @nogc nothrow;



    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_256))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_256 = `enum SPI_CR1_BR_FPCLK_DIV_256 = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_256); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_256);
        }
    }




    static if(!is(typeof(SPI_CR1_MSTR))) {
        private enum enumMixinStr_SPI_CR1_MSTR = `enum SPI_CR1_MSTR = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_MSTR); }))) {
            mixin(enumMixinStr_SPI_CR1_MSTR);
        }
    }




    static if(!is(typeof(SPI_CR1_CPOL_CLK_TO_0_WHEN_IDLE))) {
        private enum enumMixinStr_SPI_CR1_CPOL_CLK_TO_0_WHEN_IDLE = `enum SPI_CR1_CPOL_CLK_TO_0_WHEN_IDLE = ( 0 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CPOL_CLK_TO_0_WHEN_IDLE); }))) {
            mixin(enumMixinStr_SPI_CR1_CPOL_CLK_TO_0_WHEN_IDLE);
        }
    }




    static if(!is(typeof(SPI_CR1_CPOL_CLK_TO_1_WHEN_IDLE))) {
        private enum enumMixinStr_SPI_CR1_CPOL_CLK_TO_1_WHEN_IDLE = `enum SPI_CR1_CPOL_CLK_TO_1_WHEN_IDLE = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CPOL_CLK_TO_1_WHEN_IDLE); }))) {
            mixin(enumMixinStr_SPI_CR1_CPOL_CLK_TO_1_WHEN_IDLE);
        }
    }




    static if(!is(typeof(SPI_CR1_CPOL))) {
        private enum enumMixinStr_SPI_CR1_CPOL = `enum SPI_CR1_CPOL = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CPOL); }))) {
            mixin(enumMixinStr_SPI_CR1_CPOL);
        }
    }




    static if(!is(typeof(SPI_CR1_CPHA_CLK_TRANSITION_1))) {
        private enum enumMixinStr_SPI_CR1_CPHA_CLK_TRANSITION_1 = `enum SPI_CR1_CPHA_CLK_TRANSITION_1 = ( 0 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CPHA_CLK_TRANSITION_1); }))) {
            mixin(enumMixinStr_SPI_CR1_CPHA_CLK_TRANSITION_1);
        }
    }




    static if(!is(typeof(SPI_CR1_CPHA_CLK_TRANSITION_2))) {
        private enum enumMixinStr_SPI_CR1_CPHA_CLK_TRANSITION_2 = `enum SPI_CR1_CPHA_CLK_TRANSITION_2 = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CPHA_CLK_TRANSITION_2); }))) {
            mixin(enumMixinStr_SPI_CR1_CPHA_CLK_TRANSITION_2);
        }
    }




    static if(!is(typeof(SPI_CR1_CPHA))) {
        private enum enumMixinStr_SPI_CR1_CPHA = `enum SPI_CR1_CPHA = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CPHA); }))) {
            mixin(enumMixinStr_SPI_CR1_CPHA);
        }
    }




    static if(!is(typeof(SPI_CR2_TXEIE))) {
        private enum enumMixinStr_SPI_CR2_TXEIE = `enum SPI_CR2_TXEIE = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_TXEIE); }))) {
            mixin(enumMixinStr_SPI_CR2_TXEIE);
        }
    }




    static if(!is(typeof(SPI_CR2_RXNEIE))) {
        private enum enumMixinStr_SPI_CR2_RXNEIE = `enum SPI_CR2_RXNEIE = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_RXNEIE); }))) {
            mixin(enumMixinStr_SPI_CR2_RXNEIE);
        }
    }




    static if(!is(typeof(SPI_CR2_ERRIE))) {
        private enum enumMixinStr_SPI_CR2_ERRIE = `enum SPI_CR2_ERRIE = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_ERRIE); }))) {
            mixin(enumMixinStr_SPI_CR2_ERRIE);
        }
    }




    static if(!is(typeof(SPI_CR2_SSOE))) {
        private enum enumMixinStr_SPI_CR2_SSOE = `enum SPI_CR2_SSOE = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_SSOE); }))) {
            mixin(enumMixinStr_SPI_CR2_SSOE);
        }
    }




    static if(!is(typeof(SPI_CR2_TXDMAEN))) {
        private enum enumMixinStr_SPI_CR2_TXDMAEN = `enum SPI_CR2_TXDMAEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_TXDMAEN); }))) {
            mixin(enumMixinStr_SPI_CR2_TXDMAEN);
        }
    }




    static if(!is(typeof(SPI_CR2_RXDMAEN))) {
        private enum enumMixinStr_SPI_CR2_RXDMAEN = `enum SPI_CR2_RXDMAEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_RXDMAEN); }))) {
            mixin(enumMixinStr_SPI_CR2_RXDMAEN);
        }
    }




    static if(!is(typeof(SPI_SR_BSY))) {
        private enum enumMixinStr_SPI_SR_BSY = `enum SPI_SR_BSY = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_BSY); }))) {
            mixin(enumMixinStr_SPI_SR_BSY);
        }
    }




    static if(!is(typeof(SPI_SR_OVR))) {
        private enum enumMixinStr_SPI_SR_OVR = `enum SPI_SR_OVR = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_OVR); }))) {
            mixin(enumMixinStr_SPI_SR_OVR);
        }
    }




    static if(!is(typeof(SPI_SR_MODF))) {
        private enum enumMixinStr_SPI_SR_MODF = `enum SPI_SR_MODF = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_MODF); }))) {
            mixin(enumMixinStr_SPI_SR_MODF);
        }
    }




    static if(!is(typeof(SPI_SR_CRCERR))) {
        private enum enumMixinStr_SPI_SR_CRCERR = `enum SPI_SR_CRCERR = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_CRCERR); }))) {
            mixin(enumMixinStr_SPI_SR_CRCERR);
        }
    }




    static if(!is(typeof(SPI_SR_UDR))) {
        private enum enumMixinStr_SPI_SR_UDR = `enum SPI_SR_UDR = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_UDR); }))) {
            mixin(enumMixinStr_SPI_SR_UDR);
        }
    }




    static if(!is(typeof(SPI_SR_CHSIDE))) {
        private enum enumMixinStr_SPI_SR_CHSIDE = `enum SPI_SR_CHSIDE = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_CHSIDE); }))) {
            mixin(enumMixinStr_SPI_SR_CHSIDE);
        }
    }




    static if(!is(typeof(SPI_SR_TXE))) {
        private enum enumMixinStr_SPI_SR_TXE = `enum SPI_SR_TXE = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_TXE); }))) {
            mixin(enumMixinStr_SPI_SR_TXE);
        }
    }




    static if(!is(typeof(SPI_SR_RXNE))) {
        private enum enumMixinStr_SPI_SR_RXNE = `enum SPI_SR_RXNE = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_RXNE); }))) {
            mixin(enumMixinStr_SPI_SR_RXNE);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SMOD))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SMOD = `enum SPI_I2SCFGR_I2SMOD = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SMOD); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SMOD);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SE))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SE = `enum SPI_I2SCFGR_I2SE = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SE); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SE);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SCFG_LSB))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SCFG_LSB = `enum SPI_I2SCFGR_I2SCFG_LSB = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_LSB); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_LSB);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SCFG_SLAVE_TRANSMIT))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SCFG_SLAVE_TRANSMIT = `enum SPI_I2SCFGR_I2SCFG_SLAVE_TRANSMIT = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_SLAVE_TRANSMIT); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_SLAVE_TRANSMIT);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SCFG_SLAVE_RECEIVE))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SCFG_SLAVE_RECEIVE = `enum SPI_I2SCFGR_I2SCFG_SLAVE_RECEIVE = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_SLAVE_RECEIVE); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_SLAVE_RECEIVE);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SCFG_MASTER_TRANSMIT))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SCFG_MASTER_TRANSMIT = `enum SPI_I2SCFGR_I2SCFG_MASTER_TRANSMIT = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_MASTER_TRANSMIT); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_MASTER_TRANSMIT);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SCFG_MASTER_RECEIVE))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SCFG_MASTER_RECEIVE = `enum SPI_I2SCFGR_I2SCFG_MASTER_RECEIVE = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_MASTER_RECEIVE); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SCFG_MASTER_RECEIVE);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_PCMSYNC))) {
        private enum enumMixinStr_SPI_I2SCFGR_PCMSYNC = `enum SPI_I2SCFGR_PCMSYNC = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_PCMSYNC); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_PCMSYNC);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SSTD_LSB))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SSTD_LSB = `enum SPI_I2SCFGR_I2SSTD_LSB = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_LSB); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_LSB);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SSTD_I2S_PHILIPS))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SSTD_I2S_PHILIPS = `enum SPI_I2SCFGR_I2SSTD_I2S_PHILIPS = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_I2S_PHILIPS); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_I2S_PHILIPS);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SSTD_MSB_JUSTIFIED))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SSTD_MSB_JUSTIFIED = `enum SPI_I2SCFGR_I2SSTD_MSB_JUSTIFIED = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_MSB_JUSTIFIED); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_MSB_JUSTIFIED);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SSTD_LSB_JUSTIFIED))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SSTD_LSB_JUSTIFIED = `enum SPI_I2SCFGR_I2SSTD_LSB_JUSTIFIED = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_LSB_JUSTIFIED); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_LSB_JUSTIFIED);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_I2SSTD_PCM))) {
        private enum enumMixinStr_SPI_I2SCFGR_I2SSTD_PCM = `enum SPI_I2SCFGR_I2SSTD_PCM = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_PCM); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_I2SSTD_PCM);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_CKPOL))) {
        private enum enumMixinStr_SPI_I2SCFGR_CKPOL = `enum SPI_I2SCFGR_CKPOL = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_CKPOL); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_CKPOL);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_DATLEN_LSB))) {
        private enum enumMixinStr_SPI_I2SCFGR_DATLEN_LSB = `enum SPI_I2SCFGR_DATLEN_LSB = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_LSB); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_LSB);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_DATLEN_16BIT))) {
        private enum enumMixinStr_SPI_I2SCFGR_DATLEN_16BIT = `enum SPI_I2SCFGR_DATLEN_16BIT = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_16BIT); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_16BIT);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_DATLEN_24BIT))) {
        private enum enumMixinStr_SPI_I2SCFGR_DATLEN_24BIT = `enum SPI_I2SCFGR_DATLEN_24BIT = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_24BIT); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_24BIT);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_DATLEN_32BIT))) {
        private enum enumMixinStr_SPI_I2SCFGR_DATLEN_32BIT = `enum SPI_I2SCFGR_DATLEN_32BIT = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_32BIT); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_DATLEN_32BIT);
        }
    }




    static if(!is(typeof(SPI_I2SCFGR_CHLEN))) {
        private enum enumMixinStr_SPI_I2SCFGR_CHLEN = `enum SPI_I2SCFGR_CHLEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SCFGR_CHLEN); }))) {
            mixin(enumMixinStr_SPI_I2SCFGR_CHLEN);
        }
    }




    static if(!is(typeof(SPI_I2SPR_MCKOE))) {
        private enum enumMixinStr_SPI_I2SPR_MCKOE = `enum SPI_I2SPR_MCKOE = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SPR_MCKOE); }))) {
            mixin(enumMixinStr_SPI_I2SPR_MCKOE);
        }
    }




    static if(!is(typeof(SPI_I2SPR_ODD))) {
        private enum enumMixinStr_SPI_I2SPR_ODD = `enum SPI_I2SPR_ODD = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_I2SPR_ODD); }))) {
            mixin(enumMixinStr_SPI_I2SPR_ODD);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_128))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_128 = `enum SPI_CR1_BR_FPCLK_DIV_128 = 0x6;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_128); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_128);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_64))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_64 = `enum SPI_CR1_BR_FPCLK_DIV_64 = 0x5;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_64); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_64);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_32))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_32 = `enum SPI_CR1_BR_FPCLK_DIV_32 = 0x4;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_32); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_32);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_16))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_16 = `enum SPI_CR1_BR_FPCLK_DIV_16 = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_16); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_16);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_8))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_8 = `enum SPI_CR1_BR_FPCLK_DIV_8 = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_8); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_8);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_4))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_4 = `enum SPI_CR1_BR_FPCLK_DIV_4 = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_4); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_4);
        }
    }




    static if(!is(typeof(SPI_CR1_BR_FPCLK_DIV_2))) {
        private enum enumMixinStr_SPI_CR1_BR_FPCLK_DIV_2 = `enum SPI_CR1_BR_FPCLK_DIV_2 = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_2); }))) {
            mixin(enumMixinStr_SPI_CR1_BR_FPCLK_DIV_2);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_256))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_256 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_256 = ( 0x07 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_256); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_256);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_128))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_128 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_128 = ( 0x06 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_128); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_128);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_64))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_64 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_64 = ( 0x05 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_64); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_64);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_32))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_32 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_32 = ( 0x04 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_32); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_32);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_16))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_16 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_16 = ( 0x03 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_16); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_16);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_8))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_8 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_8 = ( 0x02 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_8); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_8);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_4))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_4 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_4 = ( 0x01 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_4); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_4);
        }
    }




    static if(!is(typeof(SPI_CR1_BAUDRATE_FPCLK_DIV_2))) {
        private enum enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_2 = `enum SPI_CR1_BAUDRATE_FPCLK_DIV_2 = ( 0x00 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_2); }))) {
            mixin(enumMixinStr_SPI_CR1_BAUDRATE_FPCLK_DIV_2);
        }
    }




    static if(!is(typeof(SPI_CR1_SPE))) {
        private enum enumMixinStr_SPI_CR1_SPE = `enum SPI_CR1_SPE = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_SPE); }))) {
            mixin(enumMixinStr_SPI_CR1_SPE);
        }
    }




    static if(!is(typeof(SPI_CR1_LSBFIRST))) {
        private enum enumMixinStr_SPI_CR1_LSBFIRST = `enum SPI_CR1_LSBFIRST = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_LSBFIRST); }))) {
            mixin(enumMixinStr_SPI_CR1_LSBFIRST);
        }
    }




    static if(!is(typeof(SPI_CR1_MSBFIRST))) {
        private enum enumMixinStr_SPI_CR1_MSBFIRST = `enum SPI_CR1_MSBFIRST = ( 0 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_MSBFIRST); }))) {
            mixin(enumMixinStr_SPI_CR1_MSBFIRST);
        }
    }




    static if(!is(typeof(SPI_CR1_SSI))) {
        private enum enumMixinStr_SPI_CR1_SSI = `enum SPI_CR1_SSI = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_SSI); }))) {
            mixin(enumMixinStr_SPI_CR1_SSI);
        }
    }




    static if(!is(typeof(SPI_CR1_SSM))) {
        private enum enumMixinStr_SPI_CR1_SSM = `enum SPI_CR1_SSM = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_SSM); }))) {
            mixin(enumMixinStr_SPI_CR1_SSM);
        }
    }




    static if(!is(typeof(SPI_CR1_RXONLY))) {
        private enum enumMixinStr_SPI_CR1_RXONLY = `enum SPI_CR1_RXONLY = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_RXONLY); }))) {
            mixin(enumMixinStr_SPI_CR1_RXONLY);
        }
    }




    static if(!is(typeof(SPI_CR1_CRCNEXT))) {
        private enum enumMixinStr_SPI_CR1_CRCNEXT = `enum SPI_CR1_CRCNEXT = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CRCNEXT); }))) {
            mixin(enumMixinStr_SPI_CR1_CRCNEXT);
        }
    }




    static if(!is(typeof(SPI_CR1_CRCEN))) {
        private enum enumMixinStr_SPI_CR1_CRCEN = `enum SPI_CR1_CRCEN = ( 1 << 13 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_CRCEN); }))) {
            mixin(enumMixinStr_SPI_CR1_CRCEN);
        }
    }




    static if(!is(typeof(SPI_CR1_BIDIOE))) {
        private enum enumMixinStr_SPI_CR1_BIDIOE = `enum SPI_CR1_BIDIOE = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BIDIOE); }))) {
            mixin(enumMixinStr_SPI_CR1_BIDIOE);
        }
    }




    static if(!is(typeof(SPI_CR1_BIDIMODE))) {
        private enum enumMixinStr_SPI_CR1_BIDIMODE = `enum SPI_CR1_BIDIMODE = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BIDIMODE); }))) {
            mixin(enumMixinStr_SPI_CR1_BIDIMODE);
        }
    }




    static if(!is(typeof(SPI_CR1_BIDIMODE_1LINE_BIDIR))) {
        private enum enumMixinStr_SPI_CR1_BIDIMODE_1LINE_BIDIR = `enum SPI_CR1_BIDIMODE_1LINE_BIDIR = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BIDIMODE_1LINE_BIDIR); }))) {
            mixin(enumMixinStr_SPI_CR1_BIDIMODE_1LINE_BIDIR);
        }
    }




    static if(!is(typeof(SPI_CR1_BIDIMODE_2LINE_UNIDIR))) {
        private enum enumMixinStr_SPI_CR1_BIDIMODE_2LINE_UNIDIR = `enum SPI_CR1_BIDIMODE_2LINE_UNIDIR = ( 0 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_BIDIMODE_2LINE_UNIDIR); }))) {
            mixin(enumMixinStr_SPI_CR1_BIDIMODE_2LINE_UNIDIR);
        }
    }




    static if(!is(typeof(SPI3_I2SPR))) {
        private enum enumMixinStr_SPI3_I2SPR = `enum SPI3_I2SPR = SPI_I2SPR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_I2SPR); }))) {
            mixin(enumMixinStr_SPI3_I2SPR);
        }
    }




    static if(!is(typeof(SPI2_I2SPR))) {
        private enum enumMixinStr_SPI2_I2SPR = `enum SPI2_I2SPR = SPI_I2SPR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_I2SPR); }))) {
            mixin(enumMixinStr_SPI2_I2SPR);
        }
    }




    static if(!is(typeof(SPI1_I2SPR))) {
        private enum enumMixinStr_SPI1_I2SPR = `enum SPI1_I2SPR = SPI_I2SPR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_I2SPR); }))) {
            mixin(enumMixinStr_SPI1_I2SPR);
        }
    }






    static if(!is(typeof(SPI3_I2SCFGR))) {
        private enum enumMixinStr_SPI3_I2SCFGR = `enum SPI3_I2SCFGR = SPI_I2SCFGR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_I2SCFGR); }))) {
            mixin(enumMixinStr_SPI3_I2SCFGR);
        }
    }




    static if(!is(typeof(SPI2_I2SCFGR))) {
        private enum enumMixinStr_SPI2_I2SCFGR = `enum SPI2_I2SCFGR = SPI_I2SCFGR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_I2SCFGR); }))) {
            mixin(enumMixinStr_SPI2_I2SCFGR);
        }
    }




    static if(!is(typeof(SPI1_I2SCFGR))) {
        private enum enumMixinStr_SPI1_I2SCFGR = `enum SPI1_I2SCFGR = SPI_I2SCFGR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_I2SCFGR); }))) {
            mixin(enumMixinStr_SPI1_I2SCFGR);
        }
    }






    static if(!is(typeof(SPI3_TXCRCR))) {
        private enum enumMixinStr_SPI3_TXCRCR = `enum SPI3_TXCRCR = SPI_TXCRCR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_TXCRCR); }))) {
            mixin(enumMixinStr_SPI3_TXCRCR);
        }
    }




    static if(!is(typeof(SPI2_TXCRCR))) {
        private enum enumMixinStr_SPI2_TXCRCR = `enum SPI2_TXCRCR = SPI_TXCRCR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_TXCRCR); }))) {
            mixin(enumMixinStr_SPI2_TXCRCR);
        }
    }




    static if(!is(typeof(SPI1_TXCRCR))) {
        private enum enumMixinStr_SPI1_TXCRCR = `enum SPI1_TXCRCR = SPI_TXCRCR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_TXCRCR); }))) {
            mixin(enumMixinStr_SPI1_TXCRCR);
        }
    }






    static if(!is(typeof(SPI3_RXCRCR))) {
        private enum enumMixinStr_SPI3_RXCRCR = `enum SPI3_RXCRCR = SPI_RXCRCR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_RXCRCR); }))) {
            mixin(enumMixinStr_SPI3_RXCRCR);
        }
    }




    static if(!is(typeof(SPI2_RXCRCR))) {
        private enum enumMixinStr_SPI2_RXCRCR = `enum SPI2_RXCRCR = SPI_RXCRCR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_RXCRCR); }))) {
            mixin(enumMixinStr_SPI2_RXCRCR);
        }
    }




    static if(!is(typeof(SPI1_RXCRCR))) {
        private enum enumMixinStr_SPI1_RXCRCR = `enum SPI1_RXCRCR = SPI_RXCRCR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_RXCRCR); }))) {
            mixin(enumMixinStr_SPI1_RXCRCR);
        }
    }






    static if(!is(typeof(SPI3_CRCPR))) {
        private enum enumMixinStr_SPI3_CRCPR = `enum SPI3_CRCPR = SPI_CRCPR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_CRCPR); }))) {
            mixin(enumMixinStr_SPI3_CRCPR);
        }
    }




    static if(!is(typeof(SPI2_CRCPR))) {
        private enum enumMixinStr_SPI2_CRCPR = `enum SPI2_CRCPR = SPI_CRCPR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_CRCPR); }))) {
            mixin(enumMixinStr_SPI2_CRCPR);
        }
    }




    static if(!is(typeof(SPI1_CRCPR))) {
        private enum enumMixinStr_SPI1_CRCPR = `enum SPI1_CRCPR = SPI_CRCPR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_CRCPR); }))) {
            mixin(enumMixinStr_SPI1_CRCPR);
        }
    }






    static if(!is(typeof(SPI3_DR))) {
        private enum enumMixinStr_SPI3_DR = `enum SPI3_DR = SPI_DR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_DR); }))) {
            mixin(enumMixinStr_SPI3_DR);
        }
    }




    static if(!is(typeof(SPI_CR1_DFF_8BIT))) {
        private enum enumMixinStr_SPI_CR1_DFF_8BIT = `enum SPI_CR1_DFF_8BIT = ( 0 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_DFF_8BIT); }))) {
            mixin(enumMixinStr_SPI_CR1_DFF_8BIT);
        }
    }




    static if(!is(typeof(SPI_CR1_DFF_16BIT))) {
        private enum enumMixinStr_SPI_CR1_DFF_16BIT = `enum SPI_CR1_DFF_16BIT = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_DFF_16BIT); }))) {
            mixin(enumMixinStr_SPI_CR1_DFF_16BIT);
        }
    }




    static if(!is(typeof(SPI_CR1_DFF))) {
        private enum enumMixinStr_SPI_CR1_DFF = `enum SPI_CR1_DFF = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR1_DFF); }))) {
            mixin(enumMixinStr_SPI_CR1_DFF);
        }
    }




    static if(!is(typeof(SPI2_DR))) {
        private enum enumMixinStr_SPI2_DR = `enum SPI2_DR = SPI_DR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_DR); }))) {
            mixin(enumMixinStr_SPI2_DR);
        }
    }




    static if(!is(typeof(SPI1_DR))) {
        private enum enumMixinStr_SPI1_DR = `enum SPI1_DR = SPI_DR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_DR); }))) {
            mixin(enumMixinStr_SPI1_DR);
        }
    }






    static if(!is(typeof(SPI3_SR))) {
        private enum enumMixinStr_SPI3_SR = `enum SPI3_SR = SPI_SR ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_SR); }))) {
            mixin(enumMixinStr_SPI3_SR);
        }
    }




    static if(!is(typeof(SPI2_SR))) {
        private enum enumMixinStr_SPI2_SR = `enum SPI2_SR = SPI_SR ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_SR); }))) {
            mixin(enumMixinStr_SPI2_SR);
        }
    }




    static if(!is(typeof(SPI1_SR))) {
        private enum enumMixinStr_SPI1_SR = `enum SPI1_SR = SPI_SR ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_SR); }))) {
            mixin(enumMixinStr_SPI1_SR);
        }
    }






    static if(!is(typeof(SPI_CR2_FRF))) {
        private enum enumMixinStr_SPI_CR2_FRF = `enum SPI_CR2_FRF = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_FRF); }))) {
            mixin(enumMixinStr_SPI_CR2_FRF);
        }
    }




    static if(!is(typeof(SPI_CR2_FRF_MOTOROLA_MODE))) {
        private enum enumMixinStr_SPI_CR2_FRF_MOTOROLA_MODE = `enum SPI_CR2_FRF_MOTOROLA_MODE = ( 0 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_FRF_MOTOROLA_MODE); }))) {
            mixin(enumMixinStr_SPI_CR2_FRF_MOTOROLA_MODE);
        }
    }




    static if(!is(typeof(SPI_CR2_FRF_TI_MODE))) {
        private enum enumMixinStr_SPI_CR2_FRF_TI_MODE = `enum SPI_CR2_FRF_TI_MODE = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_CR2_FRF_TI_MODE); }))) {
            mixin(enumMixinStr_SPI_CR2_FRF_TI_MODE);
        }
    }




    static if(!is(typeof(SPI_SR_TIFRFE))) {
        private enum enumMixinStr_SPI_SR_TIFRFE = `enum SPI_SR_TIFRFE = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_TIFRFE); }))) {
            mixin(enumMixinStr_SPI_SR_TIFRFE);
        }
    }




    static if(!is(typeof(SPI_SR_FRE))) {
        private enum enumMixinStr_SPI_SR_FRE = `enum SPI_SR_FRE = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI_SR_FRE); }))) {
            mixin(enumMixinStr_SPI_SR_FRE);
        }
    }




    static if(!is(typeof(SPI3_CR2))) {
        private enum enumMixinStr_SPI3_CR2 = `enum SPI3_CR2 = SPI_CR2 ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_CR2); }))) {
            mixin(enumMixinStr_SPI3_CR2);
        }
    }




    static if(!is(typeof(SPI2_CR2))) {
        private enum enumMixinStr_SPI2_CR2 = `enum SPI2_CR2 = SPI_CR2 ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_CR2); }))) {
            mixin(enumMixinStr_SPI2_CR2);
        }
    }




    static if(!is(typeof(SPI1_CR2))) {
        private enum enumMixinStr_SPI1_CR2 = `enum SPI1_CR2 = SPI_CR2 ( SPI1_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_CR2); }))) {
            mixin(enumMixinStr_SPI1_CR2);
        }
    }
    static if(!is(typeof(SPI3_CR1))) {
        private enum enumMixinStr_SPI3_CR1 = `enum SPI3_CR1 = SPI_CR1 ( SPI3_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_CR1); }))) {
            mixin(enumMixinStr_SPI3_CR1);
        }
    }






    static if(!is(typeof(SPI2_CR1))) {
        private enum enumMixinStr_SPI2_CR1 = `enum SPI2_CR1 = SPI_CR1 ( SPI2_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_CR1); }))) {
            mixin(enumMixinStr_SPI2_CR1);
        }
    }




    static if(!is(typeof(PERIPH_BASE))) {
        private enum enumMixinStr_PERIPH_BASE = `enum PERIPH_BASE = ( 0x40000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_PERIPH_BASE); }))) {
            mixin(enumMixinStr_PERIPH_BASE);
        }
    }




    static if(!is(typeof(PERIPH_BASE_APB1))) {
        private enum enumMixinStr_PERIPH_BASE_APB1 = `enum PERIPH_BASE_APB1 = ( ( 0x40000000U ) + 0x00000 );`;
        static if(is(typeof({ mixin(enumMixinStr_PERIPH_BASE_APB1); }))) {
            mixin(enumMixinStr_PERIPH_BASE_APB1);
        }
    }




    static if(!is(typeof(PERIPH_BASE_APB2))) {
        private enum enumMixinStr_PERIPH_BASE_APB2 = `enum PERIPH_BASE_APB2 = ( ( 0x40000000U ) + 0x10000 );`;
        static if(is(typeof({ mixin(enumMixinStr_PERIPH_BASE_APB2); }))) {
            mixin(enumMixinStr_PERIPH_BASE_APB2);
        }
    }




    static if(!is(typeof(PERIPH_BASE_AHB1))) {
        private enum enumMixinStr_PERIPH_BASE_AHB1 = `enum PERIPH_BASE_AHB1 = ( ( 0x40000000U ) + 0x20000 );`;
        static if(is(typeof({ mixin(enumMixinStr_PERIPH_BASE_AHB1); }))) {
            mixin(enumMixinStr_PERIPH_BASE_AHB1);
        }
    }




    static if(!is(typeof(PERIPH_BASE_AHB2))) {
        private enum enumMixinStr_PERIPH_BASE_AHB2 = `enum PERIPH_BASE_AHB2 = 0x50000000U;`;
        static if(is(typeof({ mixin(enumMixinStr_PERIPH_BASE_AHB2); }))) {
            mixin(enumMixinStr_PERIPH_BASE_AHB2);
        }
    }




    static if(!is(typeof(PERIPH_BASE_AHB3))) {
        private enum enumMixinStr_PERIPH_BASE_AHB3 = `enum PERIPH_BASE_AHB3 = 0x60000000U;`;
        static if(is(typeof({ mixin(enumMixinStr_PERIPH_BASE_AHB3); }))) {
            mixin(enumMixinStr_PERIPH_BASE_AHB3);
        }
    }




    static if(!is(typeof(TIM2_BASE))) {
        private enum enumMixinStr_TIM2_BASE = `enum TIM2_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x0000 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM2_BASE); }))) {
            mixin(enumMixinStr_TIM2_BASE);
        }
    }




    static if(!is(typeof(TIM3_BASE))) {
        private enum enumMixinStr_TIM3_BASE = `enum TIM3_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x0400 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM3_BASE); }))) {
            mixin(enumMixinStr_TIM3_BASE);
        }
    }




    static if(!is(typeof(TIM4_BASE))) {
        private enum enumMixinStr_TIM4_BASE = `enum TIM4_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x0800 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM4_BASE); }))) {
            mixin(enumMixinStr_TIM4_BASE);
        }
    }




    static if(!is(typeof(TIM5_BASE))) {
        private enum enumMixinStr_TIM5_BASE = `enum TIM5_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x0c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM5_BASE); }))) {
            mixin(enumMixinStr_TIM5_BASE);
        }
    }




    static if(!is(typeof(TIM6_BASE))) {
        private enum enumMixinStr_TIM6_BASE = `enum TIM6_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x1000 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM6_BASE); }))) {
            mixin(enumMixinStr_TIM6_BASE);
        }
    }




    static if(!is(typeof(TIM7_BASE))) {
        private enum enumMixinStr_TIM7_BASE = `enum TIM7_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x1400 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM7_BASE); }))) {
            mixin(enumMixinStr_TIM7_BASE);
        }
    }




    static if(!is(typeof(TIM12_BASE))) {
        private enum enumMixinStr_TIM12_BASE = `enum TIM12_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x1800 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM12_BASE); }))) {
            mixin(enumMixinStr_TIM12_BASE);
        }
    }




    static if(!is(typeof(TIM13_BASE))) {
        private enum enumMixinStr_TIM13_BASE = `enum TIM13_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x1c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM13_BASE); }))) {
            mixin(enumMixinStr_TIM13_BASE);
        }
    }




    static if(!is(typeof(TIM14_BASE))) {
        private enum enumMixinStr_TIM14_BASE = `enum TIM14_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x2000 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM14_BASE); }))) {
            mixin(enumMixinStr_TIM14_BASE);
        }
    }




    static if(!is(typeof(LPTIM1_BASE))) {
        private enum enumMixinStr_LPTIM1_BASE = `enum LPTIM1_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x2400 );`;
        static if(is(typeof({ mixin(enumMixinStr_LPTIM1_BASE); }))) {
            mixin(enumMixinStr_LPTIM1_BASE);
        }
    }




    static if(!is(typeof(RTC_BASE))) {
        private enum enumMixinStr_RTC_BASE = `enum RTC_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x2800 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTC_BASE); }))) {
            mixin(enumMixinStr_RTC_BASE);
        }
    }




    static if(!is(typeof(WWDG_BASE))) {
        private enum enumMixinStr_WWDG_BASE = `enum WWDG_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x2c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_WWDG_BASE); }))) {
            mixin(enumMixinStr_WWDG_BASE);
        }
    }




    static if(!is(typeof(IWDG_BASE))) {
        private enum enumMixinStr_IWDG_BASE = `enum IWDG_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x3000 );`;
        static if(is(typeof({ mixin(enumMixinStr_IWDG_BASE); }))) {
            mixin(enumMixinStr_IWDG_BASE);
        }
    }




    static if(!is(typeof(I2S2_EXT_BASE))) {
        private enum enumMixinStr_I2S2_EXT_BASE = `enum I2S2_EXT_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x3400 );`;
        static if(is(typeof({ mixin(enumMixinStr_I2S2_EXT_BASE); }))) {
            mixin(enumMixinStr_I2S2_EXT_BASE);
        }
    }




    static if(!is(typeof(SPI2_BASE))) {
        private enum enumMixinStr_SPI2_BASE = `enum SPI2_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2_BASE); }))) {
            mixin(enumMixinStr_SPI2_BASE);
        }
    }




    static if(!is(typeof(SPI3_BASE))) {
        private enum enumMixinStr_SPI3_BASE = `enum SPI3_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x3c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3_BASE); }))) {
            mixin(enumMixinStr_SPI3_BASE);
        }
    }




    static if(!is(typeof(I2S3_EXT_BASE))) {
        private enum enumMixinStr_I2S3_EXT_BASE = `enum I2S3_EXT_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x4000 );`;
        static if(is(typeof({ mixin(enumMixinStr_I2S3_EXT_BASE); }))) {
            mixin(enumMixinStr_I2S3_EXT_BASE);
        }
    }




    static if(!is(typeof(USART2_BASE))) {
        private enum enumMixinStr_USART2_BASE = `enum USART2_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x4400 );`;
        static if(is(typeof({ mixin(enumMixinStr_USART2_BASE); }))) {
            mixin(enumMixinStr_USART2_BASE);
        }
    }




    static if(!is(typeof(USART3_BASE))) {
        private enum enumMixinStr_USART3_BASE = `enum USART3_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x4800 );`;
        static if(is(typeof({ mixin(enumMixinStr_USART3_BASE); }))) {
            mixin(enumMixinStr_USART3_BASE);
        }
    }




    static if(!is(typeof(UART4_BASE))) {
        private enum enumMixinStr_UART4_BASE = `enum UART4_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x4c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_UART4_BASE); }))) {
            mixin(enumMixinStr_UART4_BASE);
        }
    }




    static if(!is(typeof(UART5_BASE))) {
        private enum enumMixinStr_UART5_BASE = `enum UART5_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x5000 );`;
        static if(is(typeof({ mixin(enumMixinStr_UART5_BASE); }))) {
            mixin(enumMixinStr_UART5_BASE);
        }
    }




    static if(!is(typeof(I2C1_BASE))) {
        private enum enumMixinStr_I2C1_BASE = `enum I2C1_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x5400 );`;
        static if(is(typeof({ mixin(enumMixinStr_I2C1_BASE); }))) {
            mixin(enumMixinStr_I2C1_BASE);
        }
    }




    static if(!is(typeof(I2C2_BASE))) {
        private enum enumMixinStr_I2C2_BASE = `enum I2C2_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x5800 );`;
        static if(is(typeof({ mixin(enumMixinStr_I2C2_BASE); }))) {
            mixin(enumMixinStr_I2C2_BASE);
        }
    }




    static if(!is(typeof(I2C3_BASE))) {
        private enum enumMixinStr_I2C3_BASE = `enum I2C3_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x5C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_I2C3_BASE); }))) {
            mixin(enumMixinStr_I2C3_BASE);
        }
    }




    static if(!is(typeof(FMPI2C1_BASE))) {
        private enum enumMixinStr_FMPI2C1_BASE = `enum FMPI2C1_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x6000 );`;
        static if(is(typeof({ mixin(enumMixinStr_FMPI2C1_BASE); }))) {
            mixin(enumMixinStr_FMPI2C1_BASE);
        }
    }




    static if(!is(typeof(BX_CAN1_BASE))) {
        private enum enumMixinStr_BX_CAN1_BASE = `enum BX_CAN1_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x6400 );`;
        static if(is(typeof({ mixin(enumMixinStr_BX_CAN1_BASE); }))) {
            mixin(enumMixinStr_BX_CAN1_BASE);
        }
    }




    static if(!is(typeof(BX_CAN2_BASE))) {
        private enum enumMixinStr_BX_CAN2_BASE = `enum BX_CAN2_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x6800 );`;
        static if(is(typeof({ mixin(enumMixinStr_BX_CAN2_BASE); }))) {
            mixin(enumMixinStr_BX_CAN2_BASE);
        }
    }




    static if(!is(typeof(POWER_CONTROL_BASE))) {
        private enum enumMixinStr_POWER_CONTROL_BASE = `enum POWER_CONTROL_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x7000 );`;
        static if(is(typeof({ mixin(enumMixinStr_POWER_CONTROL_BASE); }))) {
            mixin(enumMixinStr_POWER_CONTROL_BASE);
        }
    }




    static if(!is(typeof(DAC_BASE))) {
        private enum enumMixinStr_DAC_BASE = `enum DAC_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x7400 );`;
        static if(is(typeof({ mixin(enumMixinStr_DAC_BASE); }))) {
            mixin(enumMixinStr_DAC_BASE);
        }
    }




    static if(!is(typeof(UART7_BASE))) {
        private enum enumMixinStr_UART7_BASE = `enum UART7_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x7800 );`;
        static if(is(typeof({ mixin(enumMixinStr_UART7_BASE); }))) {
            mixin(enumMixinStr_UART7_BASE);
        }
    }




    static if(!is(typeof(UART8_BASE))) {
        private enum enumMixinStr_UART8_BASE = `enum UART8_BASE = ( ( ( 0x40000000U ) + 0x00000 ) + 0x7c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_UART8_BASE); }))) {
            mixin(enumMixinStr_UART8_BASE);
        }
    }




    static if(!is(typeof(TIM1_BASE))) {
        private enum enumMixinStr_TIM1_BASE = `enum TIM1_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x0000 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM1_BASE); }))) {
            mixin(enumMixinStr_TIM1_BASE);
        }
    }




    static if(!is(typeof(TIM8_BASE))) {
        private enum enumMixinStr_TIM8_BASE = `enum TIM8_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x0400 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM8_BASE); }))) {
            mixin(enumMixinStr_TIM8_BASE);
        }
    }




    static if(!is(typeof(USART1_BASE))) {
        private enum enumMixinStr_USART1_BASE = `enum USART1_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x1000 );`;
        static if(is(typeof({ mixin(enumMixinStr_USART1_BASE); }))) {
            mixin(enumMixinStr_USART1_BASE);
        }
    }




    static if(!is(typeof(USART6_BASE))) {
        private enum enumMixinStr_USART6_BASE = `enum USART6_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x1400 );`;
        static if(is(typeof({ mixin(enumMixinStr_USART6_BASE); }))) {
            mixin(enumMixinStr_USART6_BASE);
        }
    }




    static if(!is(typeof(ADC1_BASE))) {
        private enum enumMixinStr_ADC1_BASE = `enum ADC1_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x2000 );`;
        static if(is(typeof({ mixin(enumMixinStr_ADC1_BASE); }))) {
            mixin(enumMixinStr_ADC1_BASE);
        }
    }




    static if(!is(typeof(ADC2_BASE))) {
        private enum enumMixinStr_ADC2_BASE = `enum ADC2_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x2100 );`;
        static if(is(typeof({ mixin(enumMixinStr_ADC2_BASE); }))) {
            mixin(enumMixinStr_ADC2_BASE);
        }
    }




    static if(!is(typeof(ADC3_BASE))) {
        private enum enumMixinStr_ADC3_BASE = `enum ADC3_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x2200 );`;
        static if(is(typeof({ mixin(enumMixinStr_ADC3_BASE); }))) {
            mixin(enumMixinStr_ADC3_BASE);
        }
    }




    static if(!is(typeof(ADC_COMMON_BASE))) {
        private enum enumMixinStr_ADC_COMMON_BASE = `enum ADC_COMMON_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x2300 );`;
        static if(is(typeof({ mixin(enumMixinStr_ADC_COMMON_BASE); }))) {
            mixin(enumMixinStr_ADC_COMMON_BASE);
        }
    }




    static if(!is(typeof(SDIO_BASE))) {
        private enum enumMixinStr_SDIO_BASE = `enum SDIO_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x2C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_SDIO_BASE); }))) {
            mixin(enumMixinStr_SDIO_BASE);
        }
    }




    static if(!is(typeof(SPI1_BASE))) {
        private enum enumMixinStr_SPI1_BASE = `enum SPI1_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x3000 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_BASE); }))) {
            mixin(enumMixinStr_SPI1_BASE);
        }
    }




    static if(!is(typeof(SPI4_BASE))) {
        private enum enumMixinStr_SPI4_BASE = `enum SPI4_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x3400 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI4_BASE); }))) {
            mixin(enumMixinStr_SPI4_BASE);
        }
    }




    static if(!is(typeof(SYSCFG_BASE))) {
        private enum enumMixinStr_SYSCFG_BASE = `enum SYSCFG_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x3800 );`;
        static if(is(typeof({ mixin(enumMixinStr_SYSCFG_BASE); }))) {
            mixin(enumMixinStr_SYSCFG_BASE);
        }
    }




    static if(!is(typeof(EXTI_BASE))) {
        private enum enumMixinStr_EXTI_BASE = `enum EXTI_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x3C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_EXTI_BASE); }))) {
            mixin(enumMixinStr_EXTI_BASE);
        }
    }




    static if(!is(typeof(TIM9_BASE))) {
        private enum enumMixinStr_TIM9_BASE = `enum TIM9_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x4000 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM9_BASE); }))) {
            mixin(enumMixinStr_TIM9_BASE);
        }
    }




    static if(!is(typeof(TIM10_BASE))) {
        private enum enumMixinStr_TIM10_BASE = `enum TIM10_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x4400 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM10_BASE); }))) {
            mixin(enumMixinStr_TIM10_BASE);
        }
    }




    static if(!is(typeof(TIM11_BASE))) {
        private enum enumMixinStr_TIM11_BASE = `enum TIM11_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x4800 );`;
        static if(is(typeof({ mixin(enumMixinStr_TIM11_BASE); }))) {
            mixin(enumMixinStr_TIM11_BASE);
        }
    }




    static if(!is(typeof(SPI5_BASE))) {
        private enum enumMixinStr_SPI5_BASE = `enum SPI5_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x5000 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI5_BASE); }))) {
            mixin(enumMixinStr_SPI5_BASE);
        }
    }




    static if(!is(typeof(SPI6_BASE))) {
        private enum enumMixinStr_SPI6_BASE = `enum SPI6_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x5400 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI6_BASE); }))) {
            mixin(enumMixinStr_SPI6_BASE);
        }
    }




    static if(!is(typeof(SAI1_BASE))) {
        private enum enumMixinStr_SAI1_BASE = `enum SAI1_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x5800 );`;
        static if(is(typeof({ mixin(enumMixinStr_SAI1_BASE); }))) {
            mixin(enumMixinStr_SAI1_BASE);
        }
    }




    static if(!is(typeof(LTDC_BASE))) {
        private enum enumMixinStr_LTDC_BASE = `enum LTDC_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x6800 );`;
        static if(is(typeof({ mixin(enumMixinStr_LTDC_BASE); }))) {
            mixin(enumMixinStr_LTDC_BASE);
        }
    }




    static if(!is(typeof(DSI_BASE))) {
        private enum enumMixinStr_DSI_BASE = `enum DSI_BASE = ( ( ( 0x40000000U ) + 0x10000 ) + 0x6C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_DSI_BASE); }))) {
            mixin(enumMixinStr_DSI_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_A_BASE))) {
        private enum enumMixinStr_GPIO_PORT_A_BASE = `enum GPIO_PORT_A_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_A_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_A_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_B_BASE))) {
        private enum enumMixinStr_GPIO_PORT_B_BASE = `enum GPIO_PORT_B_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_B_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_B_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_C_BASE))) {
        private enum enumMixinStr_GPIO_PORT_C_BASE = `enum GPIO_PORT_C_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0800 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_C_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_C_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_D_BASE))) {
        private enum enumMixinStr_GPIO_PORT_D_BASE = `enum GPIO_PORT_D_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_D_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_D_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_E_BASE))) {
        private enum enumMixinStr_GPIO_PORT_E_BASE = `enum GPIO_PORT_E_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_E_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_E_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_F_BASE))) {
        private enum enumMixinStr_GPIO_PORT_F_BASE = `enum GPIO_PORT_F_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1400 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_F_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_F_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_G_BASE))) {
        private enum enumMixinStr_GPIO_PORT_G_BASE = `enum GPIO_PORT_G_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1800 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_G_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_G_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_H_BASE))) {
        private enum enumMixinStr_GPIO_PORT_H_BASE = `enum GPIO_PORT_H_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_H_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_H_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_I_BASE))) {
        private enum enumMixinStr_GPIO_PORT_I_BASE = `enum GPIO_PORT_I_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x2000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_I_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_I_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_J_BASE))) {
        private enum enumMixinStr_GPIO_PORT_J_BASE = `enum GPIO_PORT_J_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x2400 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_J_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_J_BASE);
        }
    }




    static if(!is(typeof(GPIO_PORT_K_BASE))) {
        private enum enumMixinStr_GPIO_PORT_K_BASE = `enum GPIO_PORT_K_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x2800 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PORT_K_BASE); }))) {
            mixin(enumMixinStr_GPIO_PORT_K_BASE);
        }
    }




    static if(!is(typeof(CRC_BASE))) {
        private enum enumMixinStr_CRC_BASE = `enum CRC_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x3000 );`;
        static if(is(typeof({ mixin(enumMixinStr_CRC_BASE); }))) {
            mixin(enumMixinStr_CRC_BASE);
        }
    }




    static if(!is(typeof(RCC_BASE))) {
        private enum enumMixinStr_RCC_BASE = `enum RCC_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BASE); }))) {
            mixin(enumMixinStr_RCC_BASE);
        }
    }




    static if(!is(typeof(FLASH_MEM_INTERFACE_BASE))) {
        private enum enumMixinStr_FLASH_MEM_INTERFACE_BASE = `enum FLASH_MEM_INTERFACE_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x3C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_FLASH_MEM_INTERFACE_BASE); }))) {
            mixin(enumMixinStr_FLASH_MEM_INTERFACE_BASE);
        }
    }




    static if(!is(typeof(BKPSRAM_BASE))) {
        private enum enumMixinStr_BKPSRAM_BASE = `enum BKPSRAM_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x4000 );`;
        static if(is(typeof({ mixin(enumMixinStr_BKPSRAM_BASE); }))) {
            mixin(enumMixinStr_BKPSRAM_BASE);
        }
    }




    static if(!is(typeof(DMA1_BASE))) {
        private enum enumMixinStr_DMA1_BASE = `enum DMA1_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x6000 );`;
        static if(is(typeof({ mixin(enumMixinStr_DMA1_BASE); }))) {
            mixin(enumMixinStr_DMA1_BASE);
        }
    }




    static if(!is(typeof(DMA2_BASE))) {
        private enum enumMixinStr_DMA2_BASE = `enum DMA2_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x6400 );`;
        static if(is(typeof({ mixin(enumMixinStr_DMA2_BASE); }))) {
            mixin(enumMixinStr_DMA2_BASE);
        }
    }




    static if(!is(typeof(ETHERNET_BASE))) {
        private enum enumMixinStr_ETHERNET_BASE = `enum ETHERNET_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x8000 );`;
        static if(is(typeof({ mixin(enumMixinStr_ETHERNET_BASE); }))) {
            mixin(enumMixinStr_ETHERNET_BASE);
        }
    }




    static if(!is(typeof(DMA2D_BASE))) {
        private enum enumMixinStr_DMA2D_BASE = `enum DMA2D_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0xB000U );`;
        static if(is(typeof({ mixin(enumMixinStr_DMA2D_BASE); }))) {
            mixin(enumMixinStr_DMA2D_BASE);
        }
    }




    static if(!is(typeof(USB_OTG_HS_BASE))) {
        private enum enumMixinStr_USB_OTG_HS_BASE = `enum USB_OTG_HS_BASE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x20000 );`;
        static if(is(typeof({ mixin(enumMixinStr_USB_OTG_HS_BASE); }))) {
            mixin(enumMixinStr_USB_OTG_HS_BASE);
        }
    }




    static if(!is(typeof(USB_OTG_FS_BASE))) {
        private enum enumMixinStr_USB_OTG_FS_BASE = `enum USB_OTG_FS_BASE = ( 0x50000000U + 0x00000 );`;
        static if(is(typeof({ mixin(enumMixinStr_USB_OTG_FS_BASE); }))) {
            mixin(enumMixinStr_USB_OTG_FS_BASE);
        }
    }




    static if(!is(typeof(DCMI_BASE))) {
        private enum enumMixinStr_DCMI_BASE = `enum DCMI_BASE = ( 0x50000000U + 0x50000 );`;
        static if(is(typeof({ mixin(enumMixinStr_DCMI_BASE); }))) {
            mixin(enumMixinStr_DCMI_BASE);
        }
    }




    static if(!is(typeof(CRYP_BASE))) {
        private enum enumMixinStr_CRYP_BASE = `enum CRYP_BASE = ( 0x50000000U + 0x60000 );`;
        static if(is(typeof({ mixin(enumMixinStr_CRYP_BASE); }))) {
            mixin(enumMixinStr_CRYP_BASE);
        }
    }




    static if(!is(typeof(HASH_BASE))) {
        private enum enumMixinStr_HASH_BASE = `enum HASH_BASE = ( 0x50000000U + 0x60400 );`;
        static if(is(typeof({ mixin(enumMixinStr_HASH_BASE); }))) {
            mixin(enumMixinStr_HASH_BASE);
        }
    }




    static if(!is(typeof(RNG_BASE))) {
        private enum enumMixinStr_RNG_BASE = `enum RNG_BASE = ( 0x50000000U + 0x60800 );`;
        static if(is(typeof({ mixin(enumMixinStr_RNG_BASE); }))) {
            mixin(enumMixinStr_RNG_BASE);
        }
    }




    static if(!is(typeof(FMC_BANK1))) {
        private enum enumMixinStr_FMC_BANK1 = `enum FMC_BANK1 = ( 0x60000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FMC_BANK1); }))) {
            mixin(enumMixinStr_FMC_BANK1);
        }
    }




    static if(!is(typeof(FMC_BANK2))) {
        private enum enumMixinStr_FMC_BANK2 = `enum FMC_BANK2 = ( 0x60000000U + 0x10000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FMC_BANK2); }))) {
            mixin(enumMixinStr_FMC_BANK2);
        }
    }




    static if(!is(typeof(FMC_BANK3))) {
        private enum enumMixinStr_FMC_BANK3 = `enum FMC_BANK3 = ( 0x60000000U + 0x20000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FMC_BANK3); }))) {
            mixin(enumMixinStr_FMC_BANK3);
        }
    }




    static if(!is(typeof(QUADSPI_BANK))) {
        private enum enumMixinStr_QUADSPI_BANK = `enum QUADSPI_BANK = ( 0x60000000U + 0x30000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_QUADSPI_BANK); }))) {
            mixin(enumMixinStr_QUADSPI_BANK);
        }
    }




    static if(!is(typeof(FSMC_BASE))) {
        private enum enumMixinStr_FSMC_BASE = `enum FSMC_BASE = ( 0x60000000U + 0x40000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FSMC_BASE); }))) {
            mixin(enumMixinStr_FSMC_BASE);
        }
    }




    static if(!is(typeof(FMC_BASE))) {
        private enum enumMixinStr_FMC_BASE = `enum FMC_BASE = ( 0x60000000U + 0x40000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FMC_BASE); }))) {
            mixin(enumMixinStr_FMC_BASE);
        }
    }




    static if(!is(typeof(QUADSPI_BASE))) {
        private enum enumMixinStr_QUADSPI_BASE = `enum QUADSPI_BASE = ( 0x60000000U + 0x40001000U );`;
        static if(is(typeof({ mixin(enumMixinStr_QUADSPI_BASE); }))) {
            mixin(enumMixinStr_QUADSPI_BASE);
        }
    }




    static if(!is(typeof(FMC_BANK5))) {
        private enum enumMixinStr_FMC_BANK5 = `enum FMC_BANK5 = ( 0x60000000U + 0x60000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FMC_BANK5); }))) {
            mixin(enumMixinStr_FMC_BANK5);
        }
    }




    static if(!is(typeof(FMC_BANK6))) {
        private enum enumMixinStr_FMC_BANK6 = `enum FMC_BANK6 = ( 0x60000000U + 0x70000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_FMC_BANK6); }))) {
            mixin(enumMixinStr_FMC_BANK6);
        }
    }




    static if(!is(typeof(DBGMCU_BASE))) {
        private enum enumMixinStr_DBGMCU_BASE = `enum DBGMCU_BASE = ( PPBI_BASE + 0x00042000 );`;
        static if(is(typeof({ mixin(enumMixinStr_DBGMCU_BASE); }))) {
            mixin(enumMixinStr_DBGMCU_BASE);
        }
    }




    static if(!is(typeof(DESIG_FLASH_SIZE_BASE))) {
        private enum enumMixinStr_DESIG_FLASH_SIZE_BASE = `enum DESIG_FLASH_SIZE_BASE = ( 0x1FFF7A22U );`;
        static if(is(typeof({ mixin(enumMixinStr_DESIG_FLASH_SIZE_BASE); }))) {
            mixin(enumMixinStr_DESIG_FLASH_SIZE_BASE);
        }
    }




    static if(!is(typeof(DESIG_UNIQUE_ID_BASE))) {
        private enum enumMixinStr_DESIG_UNIQUE_ID_BASE = `enum DESIG_UNIQUE_ID_BASE = ( 0x1FFF7A10U );`;
        static if(is(typeof({ mixin(enumMixinStr_DESIG_UNIQUE_ID_BASE); }))) {
            mixin(enumMixinStr_DESIG_UNIQUE_ID_BASE);
        }
    }




    static if(!is(typeof(DESIG_UNIQUE_ID0))) {
        private enum enumMixinStr_DESIG_UNIQUE_ID0 = `enum DESIG_UNIQUE_ID0 = MMIO32 ( ( 0x1FFF7A10U ) );`;
        static if(is(typeof({ mixin(enumMixinStr_DESIG_UNIQUE_ID0); }))) {
            mixin(enumMixinStr_DESIG_UNIQUE_ID0);
        }
    }




    static if(!is(typeof(DESIG_UNIQUE_ID1))) {
        private enum enumMixinStr_DESIG_UNIQUE_ID1 = `enum DESIG_UNIQUE_ID1 = MMIO32 ( ( 0x1FFF7A10U ) + 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_DESIG_UNIQUE_ID1); }))) {
            mixin(enumMixinStr_DESIG_UNIQUE_ID1);
        }
    }




    static if(!is(typeof(DESIG_UNIQUE_ID2))) {
        private enum enumMixinStr_DESIG_UNIQUE_ID2 = `enum DESIG_UNIQUE_ID2 = MMIO32 ( ( 0x1FFF7A10U ) + 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_DESIG_UNIQUE_ID2); }))) {
            mixin(enumMixinStr_DESIG_UNIQUE_ID2);
        }
    }




    static if(!is(typeof(ST_VREFINT_CAL))) {
        private enum enumMixinStr_ST_VREFINT_CAL = `enum ST_VREFINT_CAL = MMIO16 ( 0x1FFF7A2A );`;
        static if(is(typeof({ mixin(enumMixinStr_ST_VREFINT_CAL); }))) {
            mixin(enumMixinStr_ST_VREFINT_CAL);
        }
    }




    static if(!is(typeof(ST_TSENSE_CAL1_30C))) {
        private enum enumMixinStr_ST_TSENSE_CAL1_30C = `enum ST_TSENSE_CAL1_30C = MMIO16 ( 0x1FFF7A2C );`;
        static if(is(typeof({ mixin(enumMixinStr_ST_TSENSE_CAL1_30C); }))) {
            mixin(enumMixinStr_ST_TSENSE_CAL1_30C);
        }
    }




    static if(!is(typeof(ST_TSENSE_CAL2_110C))) {
        private enum enumMixinStr_ST_TSENSE_CAL2_110C = `enum ST_TSENSE_CAL2_110C = MMIO16 ( 0x1FFF7A2E );`;
        static if(is(typeof({ mixin(enumMixinStr_ST_TSENSE_CAL2_110C); }))) {
            mixin(enumMixinStr_ST_TSENSE_CAL2_110C);
        }
    }






    static if(!is(typeof(SPI1_CR1))) {
        private enum enumMixinStr_SPI1_CR1 = `enum SPI1_CR1 = SPI_CR1 ( ( ( ( 0x40000000U ) + 0x10000 ) + 0x3000 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1_CR1); }))) {
            mixin(enumMixinStr_SPI1_CR1);
        }
    }




    static if(!is(typeof(PWR_CR_VOS_SHIFT))) {
        private enum enumMixinStr_PWR_CR_VOS_SHIFT = `enum PWR_CR_VOS_SHIFT = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_VOS_SHIFT); }))) {
            mixin(enumMixinStr_PWR_CR_VOS_SHIFT);
        }
    }




    static if(!is(typeof(PWR_CR_VOS_MASK))) {
        private enum enumMixinStr_PWR_CR_VOS_MASK = `enum PWR_CR_VOS_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_VOS_MASK); }))) {
            mixin(enumMixinStr_PWR_CR_VOS_MASK);
        }
    }




    static if(!is(typeof(PWR_CR_FPDS))) {
        private enum enumMixinStr_PWR_CR_FPDS = `enum PWR_CR_FPDS = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_FPDS); }))) {
            mixin(enumMixinStr_PWR_CR_FPDS);
        }
    }




    static if(!is(typeof(PWR_CSR_VOSRDY))) {
        private enum enumMixinStr_PWR_CSR_VOSRDY = `enum PWR_CSR_VOSRDY = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_VOSRDY); }))) {
            mixin(enumMixinStr_PWR_CSR_VOSRDY);
        }
    }




    static if(!is(typeof(PWR_CSR_BRE))) {
        private enum enumMixinStr_PWR_CSR_BRE = `enum PWR_CSR_BRE = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_BRE); }))) {
            mixin(enumMixinStr_PWR_CSR_BRE);
        }
    }




    static if(!is(typeof(PWR_CSR_BRR))) {
        private enum enumMixinStr_PWR_CSR_BRR = `enum PWR_CSR_BRR = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_BRR); }))) {
            mixin(enumMixinStr_PWR_CSR_BRR);
        }
    }






    static if(!is(typeof(SPI6))) {
        private enum enumMixinStr_SPI6 = `enum SPI6 = ( ( ( 0x40000000U ) + 0x10000 ) + 0x5400 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI6); }))) {
            mixin(enumMixinStr_SPI6);
        }
    }




    static if(!is(typeof(SPI5))) {
        private enum enumMixinStr_SPI5 = `enum SPI5 = ( ( ( 0x40000000U ) + 0x10000 ) + 0x5000 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI5); }))) {
            mixin(enumMixinStr_SPI5);
        }
    }




    static if(!is(typeof(SPI4))) {
        private enum enumMixinStr_SPI4 = `enum SPI4 = ( ( ( 0x40000000U ) + 0x10000 ) + 0x3400 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI4); }))) {
            mixin(enumMixinStr_SPI4);
        }
    }






    static if(!is(typeof(SPI3))) {
        private enum enumMixinStr_SPI3 = `enum SPI3 = ( ( ( 0x40000000U ) + 0x00000 ) + 0x3c00 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI3); }))) {
            mixin(enumMixinStr_SPI3);
        }
    }




    static if(!is(typeof(RCC_CR))) {
        private enum enumMixinStr_RCC_CR = `enum RCC_CR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x00 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR); }))) {
            mixin(enumMixinStr_RCC_CR);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR))) {
        private enum enumMixinStr_RCC_PLLCFGR = `enum RCC_PLLCFGR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x04 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR);
        }
    }




    static if(!is(typeof(RCC_CFGR))) {
        private enum enumMixinStr_RCC_CFGR = `enum RCC_CFGR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x08 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR); }))) {
            mixin(enumMixinStr_RCC_CFGR);
        }
    }




    static if(!is(typeof(RCC_CIR))) {
        private enum enumMixinStr_RCC_CIR = `enum RCC_CIR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x0c );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR); }))) {
            mixin(enumMixinStr_RCC_CIR);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR))) {
        private enum enumMixinStr_RCC_AHB1RSTR = `enum RCC_AHB1RSTR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR);
        }
    }




    static if(!is(typeof(RCC_AHB2RSTR))) {
        private enum enumMixinStr_RCC_AHB2RSTR = `enum RCC_AHB2RSTR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2RSTR); }))) {
            mixin(enumMixinStr_RCC_AHB2RSTR);
        }
    }




    static if(!is(typeof(RCC_AHB3RSTR))) {
        private enum enumMixinStr_RCC_AHB3RSTR = `enum RCC_AHB3RSTR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3RSTR); }))) {
            mixin(enumMixinStr_RCC_AHB3RSTR);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR))) {
        private enum enumMixinStr_RCC_APB1RSTR = `enum RCC_APB1RSTR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR))) {
        private enum enumMixinStr_RCC_APB2RSTR = `enum RCC_APB2RSTR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x24 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR))) {
        private enum enumMixinStr_RCC_AHB1ENR = `enum RCC_AHB1ENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR);
        }
    }




    static if(!is(typeof(RCC_AHB2ENR))) {
        private enum enumMixinStr_RCC_AHB2ENR = `enum RCC_AHB2ENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x34 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2ENR); }))) {
            mixin(enumMixinStr_RCC_AHB2ENR);
        }
    }




    static if(!is(typeof(RCC_AHB3ENR))) {
        private enum enumMixinStr_RCC_AHB3ENR = `enum RCC_AHB3ENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x38 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3ENR); }))) {
            mixin(enumMixinStr_RCC_AHB3ENR);
        }
    }




    static if(!is(typeof(RCC_APB1ENR))) {
        private enum enumMixinStr_RCC_APB1ENR = `enum RCC_APB1ENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x40 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR); }))) {
            mixin(enumMixinStr_RCC_APB1ENR);
        }
    }




    static if(!is(typeof(RCC_APB2ENR))) {
        private enum enumMixinStr_RCC_APB2ENR = `enum RCC_APB2ENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x44 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR); }))) {
            mixin(enumMixinStr_RCC_APB2ENR);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR))) {
        private enum enumMixinStr_RCC_AHB1LPENR = `enum RCC_AHB1LPENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x50 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR);
        }
    }




    static if(!is(typeof(RCC_AHB2LPENR))) {
        private enum enumMixinStr_RCC_AHB2LPENR = `enum RCC_AHB2LPENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x54 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2LPENR); }))) {
            mixin(enumMixinStr_RCC_AHB2LPENR);
        }
    }




    static if(!is(typeof(RCC_AHB3LPENR))) {
        private enum enumMixinStr_RCC_AHB3LPENR = `enum RCC_AHB3LPENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x58 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3LPENR); }))) {
            mixin(enumMixinStr_RCC_AHB3LPENR);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR))) {
        private enum enumMixinStr_RCC_APB1LPENR = `enum RCC_APB1LPENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x60 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR))) {
        private enum enumMixinStr_RCC_APB2LPENR = `enum RCC_APB2LPENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x64 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR);
        }
    }




    static if(!is(typeof(RCC_BDCR))) {
        private enum enumMixinStr_RCC_BDCR = `enum RCC_BDCR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x70 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR); }))) {
            mixin(enumMixinStr_RCC_BDCR);
        }
    }




    static if(!is(typeof(RCC_CSR))) {
        private enum enumMixinStr_RCC_CSR = `enum RCC_CSR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x74 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR); }))) {
            mixin(enumMixinStr_RCC_CSR);
        }
    }




    static if(!is(typeof(RCC_SSCGR))) {
        private enum enumMixinStr_RCC_SSCGR = `enum RCC_SSCGR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x80 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR); }))) {
            mixin(enumMixinStr_RCC_SSCGR);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR = `enum RCC_PLLI2SCFGR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x84 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR))) {
        private enum enumMixinStr_RCC_PLLSAICFGR = `enum RCC_PLLSAICFGR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x88 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR))) {
        private enum enumMixinStr_RCC_DCKCFGR = `enum RCC_DCKCFGR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x8C );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR);
        }
    }




    static if(!is(typeof(RCC_CKGATENR))) {
        private enum enumMixinStr_RCC_CKGATENR = `enum RCC_CKGATENR = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x90 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR); }))) {
            mixin(enumMixinStr_RCC_CKGATENR);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR2))) {
        private enum enumMixinStr_RCC_DCKCFGR2 = `enum RCC_DCKCFGR2 = MMIO32 ( ( ( ( 0x40000000U ) + 0x20000 ) + 0x3800 ) + 0x94 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR2); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR2);
        }
    }




    static if(!is(typeof(RCC_CR_PLLSAIRDY))) {
        private enum enumMixinStr_RCC_CR_PLLSAIRDY = `enum RCC_CR_PLLSAIRDY = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_PLLSAIRDY); }))) {
            mixin(enumMixinStr_RCC_CR_PLLSAIRDY);
        }
    }




    static if(!is(typeof(RCC_CR_PLLSAION))) {
        private enum enumMixinStr_RCC_CR_PLLSAION = `enum RCC_CR_PLLSAION = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_PLLSAION); }))) {
            mixin(enumMixinStr_RCC_CR_PLLSAION);
        }
    }




    static if(!is(typeof(RCC_CR_PLLI2SRDY))) {
        private enum enumMixinStr_RCC_CR_PLLI2SRDY = `enum RCC_CR_PLLI2SRDY = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_PLLI2SRDY); }))) {
            mixin(enumMixinStr_RCC_CR_PLLI2SRDY);
        }
    }




    static if(!is(typeof(RCC_CR_PLLI2SON))) {
        private enum enumMixinStr_RCC_CR_PLLI2SON = `enum RCC_CR_PLLI2SON = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_PLLI2SON); }))) {
            mixin(enumMixinStr_RCC_CR_PLLI2SON);
        }
    }




    static if(!is(typeof(RCC_CR_PLLRDY))) {
        private enum enumMixinStr_RCC_CR_PLLRDY = `enum RCC_CR_PLLRDY = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_PLLRDY); }))) {
            mixin(enumMixinStr_RCC_CR_PLLRDY);
        }
    }




    static if(!is(typeof(RCC_CR_PLLON))) {
        private enum enumMixinStr_RCC_CR_PLLON = `enum RCC_CR_PLLON = ( 1 << 24 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_PLLON); }))) {
            mixin(enumMixinStr_RCC_CR_PLLON);
        }
    }




    static if(!is(typeof(RCC_CR_CSSON))) {
        private enum enumMixinStr_RCC_CR_CSSON = `enum RCC_CR_CSSON = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_CSSON); }))) {
            mixin(enumMixinStr_RCC_CR_CSSON);
        }
    }




    static if(!is(typeof(RCC_CR_HSEBYP))) {
        private enum enumMixinStr_RCC_CR_HSEBYP = `enum RCC_CR_HSEBYP = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSEBYP); }))) {
            mixin(enumMixinStr_RCC_CR_HSEBYP);
        }
    }




    static if(!is(typeof(RCC_CR_HSERDY))) {
        private enum enumMixinStr_RCC_CR_HSERDY = `enum RCC_CR_HSERDY = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSERDY); }))) {
            mixin(enumMixinStr_RCC_CR_HSERDY);
        }
    }




    static if(!is(typeof(RCC_CR_HSEON))) {
        private enum enumMixinStr_RCC_CR_HSEON = `enum RCC_CR_HSEON = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSEON); }))) {
            mixin(enumMixinStr_RCC_CR_HSEON);
        }
    }




    static if(!is(typeof(RCC_CR_HSITRIM_SHIFT))) {
        private enum enumMixinStr_RCC_CR_HSITRIM_SHIFT = `enum RCC_CR_HSITRIM_SHIFT = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSITRIM_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CR_HSITRIM_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CR_HSITRIM_MASK))) {
        private enum enumMixinStr_RCC_CR_HSITRIM_MASK = `enum RCC_CR_HSITRIM_MASK = 0x1f;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSITRIM_MASK); }))) {
            mixin(enumMixinStr_RCC_CR_HSITRIM_MASK);
        }
    }




    static if(!is(typeof(RCC_CR_HSIRDY))) {
        private enum enumMixinStr_RCC_CR_HSIRDY = `enum RCC_CR_HSIRDY = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSIRDY); }))) {
            mixin(enumMixinStr_RCC_CR_HSIRDY);
        }
    }




    static if(!is(typeof(RCC_CR_HSION))) {
        private enum enumMixinStr_RCC_CR_HSION = `enum RCC_CR_HSION = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CR_HSION); }))) {
            mixin(enumMixinStr_RCC_CR_HSION);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLR_SHIFT))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLR_SHIFT = `enum RCC_PLLCFGR_PLLR_SHIFT = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLR_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLR_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLR_MASK))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLR_MASK = `enum RCC_PLLCFGR_PLLR_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLR_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLR_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLQ_SHIFT))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLQ_SHIFT = `enum RCC_PLLCFGR_PLLQ_SHIFT = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLQ_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLQ_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLQ_MASK))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLQ_MASK = `enum RCC_PLLCFGR_PLLQ_MASK = 0xf;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLQ_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLQ_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLSRC))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLSRC = `enum RCC_PLLCFGR_PLLSRC = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLSRC); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLSRC);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLP_SHIFT))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLP_SHIFT = `enum RCC_PLLCFGR_PLLP_SHIFT = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLP_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLP_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLP_MASK))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLP_MASK = `enum RCC_PLLCFGR_PLLP_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLP_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLP_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLN_SHIFT))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLN_SHIFT = `enum RCC_PLLCFGR_PLLN_SHIFT = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLN_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLN_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLN_MASK))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLN_MASK = `enum RCC_PLLCFGR_PLLN_MASK = 0x1ff;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLN_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLN_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLM_SHIFT))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLM_SHIFT = `enum RCC_PLLCFGR_PLLM_SHIFT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLM_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLM_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLCFGR_PLLM_MASK))) {
        private enum enumMixinStr_RCC_PLLCFGR_PLLM_MASK = `enum RCC_PLLCFGR_PLLM_MASK = 0x3f;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLCFGR_PLLM_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLCFGR_PLLM_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_MCO2_SHIFT = `enum RCC_CFGR_MCO2_SHIFT = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2_MASK))) {
        private enum enumMixinStr_RCC_CFGR_MCO2_MASK = `enum RCC_CFGR_MCO2_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2_SYSCLK))) {
        private enum enumMixinStr_RCC_CFGR_MCO2_SYSCLK = `enum RCC_CFGR_MCO2_SYSCLK = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2_SYSCLK); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2_SYSCLK);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2_PLLI2S))) {
        private enum enumMixinStr_RCC_CFGR_MCO2_PLLI2S = `enum RCC_CFGR_MCO2_PLLI2S = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2_PLLI2S); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2_PLLI2S);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2_HSE))) {
        private enum enumMixinStr_RCC_CFGR_MCO2_HSE = `enum RCC_CFGR_MCO2_HSE = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2_HSE); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2_HSE);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2_PLL))) {
        private enum enumMixinStr_RCC_CFGR_MCO2_PLL = `enum RCC_CFGR_MCO2_PLL = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2_PLL); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2_PLL);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2PRE_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_MCO2PRE_SHIFT = `enum RCC_CFGR_MCO2PRE_SHIFT = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2PRE_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2PRE_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO2PRE_MASK))) {
        private enum enumMixinStr_RCC_CFGR_MCO2PRE_MASK = `enum RCC_CFGR_MCO2PRE_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO2PRE_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO2PRE_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1PRE_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_MCO1PRE_SHIFT = `enum RCC_CFGR_MCO1PRE_SHIFT = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1PRE_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1PRE_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1PRE_MASK))) {
        private enum enumMixinStr_RCC_CFGR_MCO1PRE_MASK = `enum RCC_CFGR_MCO1PRE_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1PRE_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1PRE_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCOPRE_DIV_NONE))) {
        private enum enumMixinStr_RCC_CFGR_MCOPRE_DIV_NONE = `enum RCC_CFGR_MCOPRE_DIV_NONE = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_NONE); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_NONE);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCOPRE_DIV_2))) {
        private enum enumMixinStr_RCC_CFGR_MCOPRE_DIV_2 = `enum RCC_CFGR_MCOPRE_DIV_2 = 0x4;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_2); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_2);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCOPRE_DIV_3))) {
        private enum enumMixinStr_RCC_CFGR_MCOPRE_DIV_3 = `enum RCC_CFGR_MCOPRE_DIV_3 = 0x5;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_3); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_3);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCOPRE_DIV_4))) {
        private enum enumMixinStr_RCC_CFGR_MCOPRE_DIV_4 = `enum RCC_CFGR_MCOPRE_DIV_4 = 0x6;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_4); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_4);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCOPRE_DIV_5))) {
        private enum enumMixinStr_RCC_CFGR_MCOPRE_DIV_5 = `enum RCC_CFGR_MCOPRE_DIV_5 = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_5); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCOPRE_DIV_5);
        }
    }




    static if(!is(typeof(RCC_CFGR_PLLSRC_HSI_CLK))) {
        private enum enumMixinStr_RCC_CFGR_PLLSRC_HSI_CLK = `enum RCC_CFGR_PLLSRC_HSI_CLK = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PLLSRC_HSI_CLK); }))) {
            mixin(enumMixinStr_RCC_CFGR_PLLSRC_HSI_CLK);
        }
    }




    static if(!is(typeof(RCC_CFGR_PLLSRC_HSE_CLK))) {
        private enum enumMixinStr_RCC_CFGR_PLLSRC_HSE_CLK = `enum RCC_CFGR_PLLSRC_HSE_CLK = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PLLSRC_HSE_CLK); }))) {
            mixin(enumMixinStr_RCC_CFGR_PLLSRC_HSE_CLK);
        }
    }




    static if(!is(typeof(RCC_CFGR_I2SSRC))) {
        private enum enumMixinStr_RCC_CFGR_I2SSRC = `enum RCC_CFGR_I2SSRC = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_I2SSRC); }))) {
            mixin(enumMixinStr_RCC_CFGR_I2SSRC);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_MCO1_SHIFT = `enum RCC_CFGR_MCO1_SHIFT = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1_MASK))) {
        private enum enumMixinStr_RCC_CFGR_MCO1_MASK = `enum RCC_CFGR_MCO1_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1_HSI))) {
        private enum enumMixinStr_RCC_CFGR_MCO1_HSI = `enum RCC_CFGR_MCO1_HSI = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1_HSI); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1_HSI);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1_LSE))) {
        private enum enumMixinStr_RCC_CFGR_MCO1_LSE = `enum RCC_CFGR_MCO1_LSE = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1_LSE); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1_LSE);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1_HSE))) {
        private enum enumMixinStr_RCC_CFGR_MCO1_HSE = `enum RCC_CFGR_MCO1_HSE = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1_HSE); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1_HSE);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO1_PLL))) {
        private enum enumMixinStr_RCC_CFGR_MCO1_PLL = `enum RCC_CFGR_MCO1_PLL = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO1_PLL); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO1_PLL);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_MCO_SHIFT = `enum RCC_CFGR_MCO_SHIFT = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_MCO_MASK))) {
        private enum enumMixinStr_RCC_CFGR_MCO_MASK = `enum RCC_CFGR_MCO_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_MCO_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_MCO_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_RTCPRE_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_RTCPRE_SHIFT = `enum RCC_CFGR_RTCPRE_SHIFT = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_RTCPRE_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_RTCPRE_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_RTCPRE_MASK))) {
        private enum enumMixinStr_RCC_CFGR_RTCPRE_MASK = `enum RCC_CFGR_RTCPRE_MASK = 0x1f;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_RTCPRE_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_RTCPRE_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE2_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_PPRE2_SHIFT = `enum RCC_CFGR_PPRE2_SHIFT = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE2_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE2_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE2_MASK))) {
        private enum enumMixinStr_RCC_CFGR_PPRE2_MASK = `enum RCC_CFGR_PPRE2_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE2_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE2_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE1_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_PPRE1_SHIFT = `enum RCC_CFGR_PPRE1_SHIFT = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE1_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE1_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE1_MASK))) {
        private enum enumMixinStr_RCC_CFGR_PPRE1_MASK = `enum RCC_CFGR_PPRE1_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE1_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE1_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE_DIV_NONE))) {
        private enum enumMixinStr_RCC_CFGR_PPRE_DIV_NONE = `enum RCC_CFGR_PPRE_DIV_NONE = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_NONE); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_NONE);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE_DIV_2))) {
        private enum enumMixinStr_RCC_CFGR_PPRE_DIV_2 = `enum RCC_CFGR_PPRE_DIV_2 = 0x4;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_2); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_2);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE_DIV_4))) {
        private enum enumMixinStr_RCC_CFGR_PPRE_DIV_4 = `enum RCC_CFGR_PPRE_DIV_4 = 0x5;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_4); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_4);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE_DIV_8))) {
        private enum enumMixinStr_RCC_CFGR_PPRE_DIV_8 = `enum RCC_CFGR_PPRE_DIV_8 = 0x6;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_8); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_8);
        }
    }




    static if(!is(typeof(RCC_CFGR_PPRE_DIV_16))) {
        private enum enumMixinStr_RCC_CFGR_PPRE_DIV_16 = `enum RCC_CFGR_PPRE_DIV_16 = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_16); }))) {
            mixin(enumMixinStr_RCC_CFGR_PPRE_DIV_16);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_SHIFT = `enum RCC_CFGR_HPRE_SHIFT = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_MASK))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_MASK = `enum RCC_CFGR_HPRE_MASK = 0xf;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_NONE))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_NONE = `enum RCC_CFGR_HPRE_DIV_NONE = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_NONE); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_NONE);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_2))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_2 = `enum RCC_CFGR_HPRE_DIV_2 = ( 0x8 + 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_2); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_2);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_4))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_4 = `enum RCC_CFGR_HPRE_DIV_4 = ( 0x8 + 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_4); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_4);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_8))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_8 = `enum RCC_CFGR_HPRE_DIV_8 = ( 0x8 + 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_8); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_8);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_16))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_16 = `enum RCC_CFGR_HPRE_DIV_16 = ( 0x8 + 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_16); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_16);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_64))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_64 = `enum RCC_CFGR_HPRE_DIV_64 = ( 0x8 + 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_64); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_64);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_128))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_128 = `enum RCC_CFGR_HPRE_DIV_128 = ( 0x8 + 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_128); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_128);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_256))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_256 = `enum RCC_CFGR_HPRE_DIV_256 = ( 0x8 + 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_256); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_256);
        }
    }




    static if(!is(typeof(RCC_CFGR_HPRE_DIV_512))) {
        private enum enumMixinStr_RCC_CFGR_HPRE_DIV_512 = `enum RCC_CFGR_HPRE_DIV_512 = ( 0x8 + 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_512); }))) {
            mixin(enumMixinStr_RCC_CFGR_HPRE_DIV_512);
        }
    }




    static if(!is(typeof(RCC_CFGR_SWS_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_SWS_SHIFT = `enum RCC_CFGR_SWS_SHIFT = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SWS_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_SWS_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_SWS_MASK))) {
        private enum enumMixinStr_RCC_CFGR_SWS_MASK = `enum RCC_CFGR_SWS_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SWS_MASK); }))) {
            mixin(enumMixinStr_RCC_CFGR_SWS_MASK);
        }
    }




    static if(!is(typeof(RCC_CFGR_SWS_HSI))) {
        private enum enumMixinStr_RCC_CFGR_SWS_HSI = `enum RCC_CFGR_SWS_HSI = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SWS_HSI); }))) {
            mixin(enumMixinStr_RCC_CFGR_SWS_HSI);
        }
    }




    static if(!is(typeof(RCC_CFGR_SWS_HSE))) {
        private enum enumMixinStr_RCC_CFGR_SWS_HSE = `enum RCC_CFGR_SWS_HSE = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SWS_HSE); }))) {
            mixin(enumMixinStr_RCC_CFGR_SWS_HSE);
        }
    }




    static if(!is(typeof(RCC_CFGR_SWS_PLL))) {
        private enum enumMixinStr_RCC_CFGR_SWS_PLL = `enum RCC_CFGR_SWS_PLL = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SWS_PLL); }))) {
            mixin(enumMixinStr_RCC_CFGR_SWS_PLL);
        }
    }




    static if(!is(typeof(RCC_CFGR_SW_SHIFT))) {
        private enum enumMixinStr_RCC_CFGR_SW_SHIFT = `enum RCC_CFGR_SW_SHIFT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SW_SHIFT); }))) {
            mixin(enumMixinStr_RCC_CFGR_SW_SHIFT);
        }
    }




    static if(!is(typeof(RCC_CFGR_SW_HSI))) {
        private enum enumMixinStr_RCC_CFGR_SW_HSI = `enum RCC_CFGR_SW_HSI = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SW_HSI); }))) {
            mixin(enumMixinStr_RCC_CFGR_SW_HSI);
        }
    }




    static if(!is(typeof(RCC_CFGR_SW_HSE))) {
        private enum enumMixinStr_RCC_CFGR_SW_HSE = `enum RCC_CFGR_SW_HSE = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SW_HSE); }))) {
            mixin(enumMixinStr_RCC_CFGR_SW_HSE);
        }
    }




    static if(!is(typeof(RCC_CFGR_SW_PLL))) {
        private enum enumMixinStr_RCC_CFGR_SW_PLL = `enum RCC_CFGR_SW_PLL = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CFGR_SW_PLL); }))) {
            mixin(enumMixinStr_RCC_CFGR_SW_PLL);
        }
    }




    static if(!is(typeof(RCC_CIR_CSSC))) {
        private enum enumMixinStr_RCC_CIR_CSSC = `enum RCC_CIR_CSSC = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_CSSC); }))) {
            mixin(enumMixinStr_RCC_CIR_CSSC);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLSAIRDYC))) {
        private enum enumMixinStr_RCC_CIR_PLLSAIRDYC = `enum RCC_CIR_PLLSAIRDYC = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLSAIRDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLSAIRDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLI2SRDYC))) {
        private enum enumMixinStr_RCC_CIR_PLLI2SRDYC = `enum RCC_CIR_PLLI2SRDYC = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLI2SRDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLI2SRDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLRDYC))) {
        private enum enumMixinStr_RCC_CIR_PLLRDYC = `enum RCC_CIR_PLLRDYC = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLRDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLRDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_HSERDYC))) {
        private enum enumMixinStr_RCC_CIR_HSERDYC = `enum RCC_CIR_HSERDYC = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_HSERDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_HSERDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_HSIRDYC))) {
        private enum enumMixinStr_RCC_CIR_HSIRDYC = `enum RCC_CIR_HSIRDYC = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_HSIRDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_HSIRDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_LSERDYC))) {
        private enum enumMixinStr_RCC_CIR_LSERDYC = `enum RCC_CIR_LSERDYC = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_LSERDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_LSERDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_LSIRDYC))) {
        private enum enumMixinStr_RCC_CIR_LSIRDYC = `enum RCC_CIR_LSIRDYC = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_LSIRDYC); }))) {
            mixin(enumMixinStr_RCC_CIR_LSIRDYC);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLSAIRDYIE))) {
        private enum enumMixinStr_RCC_CIR_PLLSAIRDYIE = `enum RCC_CIR_PLLSAIRDYIE = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLSAIRDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLSAIRDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLI2SRDYIE))) {
        private enum enumMixinStr_RCC_CIR_PLLI2SRDYIE = `enum RCC_CIR_PLLI2SRDYIE = ( 1 << 13 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLI2SRDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLI2SRDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLRDYIE))) {
        private enum enumMixinStr_RCC_CIR_PLLRDYIE = `enum RCC_CIR_PLLRDYIE = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLRDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLRDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_HSERDYIE))) {
        private enum enumMixinStr_RCC_CIR_HSERDYIE = `enum RCC_CIR_HSERDYIE = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_HSERDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_HSERDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_HSIRDYIE))) {
        private enum enumMixinStr_RCC_CIR_HSIRDYIE = `enum RCC_CIR_HSIRDYIE = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_HSIRDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_HSIRDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_LSERDYIE))) {
        private enum enumMixinStr_RCC_CIR_LSERDYIE = `enum RCC_CIR_LSERDYIE = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_LSERDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_LSERDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_LSIRDYIE))) {
        private enum enumMixinStr_RCC_CIR_LSIRDYIE = `enum RCC_CIR_LSIRDYIE = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_LSIRDYIE); }))) {
            mixin(enumMixinStr_RCC_CIR_LSIRDYIE);
        }
    }




    static if(!is(typeof(RCC_CIR_CSSF))) {
        private enum enumMixinStr_RCC_CIR_CSSF = `enum RCC_CIR_CSSF = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_CSSF); }))) {
            mixin(enumMixinStr_RCC_CIR_CSSF);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLSAIRDYF))) {
        private enum enumMixinStr_RCC_CIR_PLLSAIRDYF = `enum RCC_CIR_PLLSAIRDYF = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLSAIRDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLSAIRDYF);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLI2SRDYF))) {
        private enum enumMixinStr_RCC_CIR_PLLI2SRDYF = `enum RCC_CIR_PLLI2SRDYF = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLI2SRDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLI2SRDYF);
        }
    }




    static if(!is(typeof(RCC_CIR_PLLRDYF))) {
        private enum enumMixinStr_RCC_CIR_PLLRDYF = `enum RCC_CIR_PLLRDYF = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_PLLRDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_PLLRDYF);
        }
    }




    static if(!is(typeof(RCC_CIR_HSERDYF))) {
        private enum enumMixinStr_RCC_CIR_HSERDYF = `enum RCC_CIR_HSERDYF = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_HSERDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_HSERDYF);
        }
    }




    static if(!is(typeof(RCC_CIR_HSIRDYF))) {
        private enum enumMixinStr_RCC_CIR_HSIRDYF = `enum RCC_CIR_HSIRDYF = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_HSIRDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_HSIRDYF);
        }
    }




    static if(!is(typeof(RCC_CIR_LSERDYF))) {
        private enum enumMixinStr_RCC_CIR_LSERDYF = `enum RCC_CIR_LSERDYF = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_LSERDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_LSERDYF);
        }
    }




    static if(!is(typeof(RCC_CIR_LSIRDYF))) {
        private enum enumMixinStr_RCC_CIR_LSIRDYF = `enum RCC_CIR_LSIRDYF = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CIR_LSIRDYF); }))) {
            mixin(enumMixinStr_RCC_CIR_LSIRDYF);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_OTGHSRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_OTGHSRST = `enum RCC_AHB1RSTR_OTGHSRST = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_OTGHSRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_OTGHSRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_ETHMACRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_ETHMACRST = `enum RCC_AHB1RSTR_ETHMACRST = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_ETHMACRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_ETHMACRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_DMA2DRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_DMA2DRST = `enum RCC_AHB1RSTR_DMA2DRST = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_DMA2DRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_DMA2DRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_DMA2RST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_DMA2RST = `enum RCC_AHB1RSTR_DMA2RST = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_DMA2RST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_DMA2RST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_DMA1RST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_DMA1RST = `enum RCC_AHB1RSTR_DMA1RST = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_DMA1RST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_DMA1RST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_CRCRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_CRCRST = `enum RCC_AHB1RSTR_CRCRST = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_CRCRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_CRCRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOKRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOKRST = `enum RCC_AHB1RSTR_GPIOKRST = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOKRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOKRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOJRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOJRST = `enum RCC_AHB1RSTR_GPIOJRST = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOJRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOJRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOIRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOIRST = `enum RCC_AHB1RSTR_GPIOIRST = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOIRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOIRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOHRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOHRST = `enum RCC_AHB1RSTR_GPIOHRST = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOHRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOHRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOGRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOGRST = `enum RCC_AHB1RSTR_GPIOGRST = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOGRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOGRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOFRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOFRST = `enum RCC_AHB1RSTR_GPIOFRST = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOFRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOFRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOERST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOERST = `enum RCC_AHB1RSTR_GPIOERST = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOERST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOERST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIODRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIODRST = `enum RCC_AHB1RSTR_GPIODRST = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIODRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIODRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOCRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOCRST = `enum RCC_AHB1RSTR_GPIOCRST = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOCRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOCRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOBRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOBRST = `enum RCC_AHB1RSTR_GPIOBRST = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOBRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOBRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_GPIOARST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_GPIOARST = `enum RCC_AHB1RSTR_GPIOARST = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_GPIOARST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_GPIOARST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPKRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPKRST = `enum RCC_AHB1RSTR_IOPKRST = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPKRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPKRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPJRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPJRST = `enum RCC_AHB1RSTR_IOPJRST = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPJRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPJRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPIRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPIRST = `enum RCC_AHB1RSTR_IOPIRST = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPIRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPIRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPHRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPHRST = `enum RCC_AHB1RSTR_IOPHRST = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPHRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPHRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPGRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPGRST = `enum RCC_AHB1RSTR_IOPGRST = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPGRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPGRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPFRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPFRST = `enum RCC_AHB1RSTR_IOPFRST = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPFRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPFRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPERST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPERST = `enum RCC_AHB1RSTR_IOPERST = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPERST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPERST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPDRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPDRST = `enum RCC_AHB1RSTR_IOPDRST = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPDRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPDRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPCRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPCRST = `enum RCC_AHB1RSTR_IOPCRST = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPCRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPCRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPBRST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPBRST = `enum RCC_AHB1RSTR_IOPBRST = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPBRST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPBRST);
        }
    }




    static if(!is(typeof(RCC_AHB1RSTR_IOPARST))) {
        private enum enumMixinStr_RCC_AHB1RSTR_IOPARST = `enum RCC_AHB1RSTR_IOPARST = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1RSTR_IOPARST); }))) {
            mixin(enumMixinStr_RCC_AHB1RSTR_IOPARST);
        }
    }




    static if(!is(typeof(RCC_AHB2RSTR_OTGFSRST))) {
        private enum enumMixinStr_RCC_AHB2RSTR_OTGFSRST = `enum RCC_AHB2RSTR_OTGFSRST = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2RSTR_OTGFSRST); }))) {
            mixin(enumMixinStr_RCC_AHB2RSTR_OTGFSRST);
        }
    }




    static if(!is(typeof(RCC_AHB2RSTR_RNGRST))) {
        private enum enumMixinStr_RCC_AHB2RSTR_RNGRST = `enum RCC_AHB2RSTR_RNGRST = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2RSTR_RNGRST); }))) {
            mixin(enumMixinStr_RCC_AHB2RSTR_RNGRST);
        }
    }




    static if(!is(typeof(RCC_AHB2RSTR_HASHRST))) {
        private enum enumMixinStr_RCC_AHB2RSTR_HASHRST = `enum RCC_AHB2RSTR_HASHRST = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2RSTR_HASHRST); }))) {
            mixin(enumMixinStr_RCC_AHB2RSTR_HASHRST);
        }
    }




    static if(!is(typeof(RCC_AHB2RSTR_CRYPRST))) {
        private enum enumMixinStr_RCC_AHB2RSTR_CRYPRST = `enum RCC_AHB2RSTR_CRYPRST = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2RSTR_CRYPRST); }))) {
            mixin(enumMixinStr_RCC_AHB2RSTR_CRYPRST);
        }
    }




    static if(!is(typeof(RCC_AHB2RSTR_DCMIRST))) {
        private enum enumMixinStr_RCC_AHB2RSTR_DCMIRST = `enum RCC_AHB2RSTR_DCMIRST = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2RSTR_DCMIRST); }))) {
            mixin(enumMixinStr_RCC_AHB2RSTR_DCMIRST);
        }
    }




    static if(!is(typeof(RCC_AHB3RSTR_QSPIRST))) {
        private enum enumMixinStr_RCC_AHB3RSTR_QSPIRST = `enum RCC_AHB3RSTR_QSPIRST = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3RSTR_QSPIRST); }))) {
            mixin(enumMixinStr_RCC_AHB3RSTR_QSPIRST);
        }
    }




    static if(!is(typeof(RCC_AHB3RSTR_FSMCRST))) {
        private enum enumMixinStr_RCC_AHB3RSTR_FSMCRST = `enum RCC_AHB3RSTR_FSMCRST = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3RSTR_FSMCRST); }))) {
            mixin(enumMixinStr_RCC_AHB3RSTR_FSMCRST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_UART8RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_UART8RST = `enum RCC_APB1RSTR_UART8RST = ( 1 << 31 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_UART8RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_UART8RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_UART7RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_UART7RST = `enum RCC_APB1RSTR_UART7RST = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_UART7RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_UART7RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_DACRST))) {
        private enum enumMixinStr_RCC_APB1RSTR_DACRST = `enum RCC_APB1RSTR_DACRST = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_DACRST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_DACRST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_PWRRST))) {
        private enum enumMixinStr_RCC_APB1RSTR_PWRRST = `enum RCC_APB1RSTR_PWRRST = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_PWRRST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_PWRRST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_CAN2RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_CAN2RST = `enum RCC_APB1RSTR_CAN2RST = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_CAN2RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_CAN2RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_CAN1RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_CAN1RST = `enum RCC_APB1RSTR_CAN1RST = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_CAN1RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_CAN1RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_I2C3RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_I2C3RST = `enum RCC_APB1RSTR_I2C3RST = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_I2C3RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_I2C3RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_I2C2RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_I2C2RST = `enum RCC_APB1RSTR_I2C2RST = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_I2C2RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_I2C2RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_I2C1RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_I2C1RST = `enum RCC_APB1RSTR_I2C1RST = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_I2C1RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_I2C1RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_UART5RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_UART5RST = `enum RCC_APB1RSTR_UART5RST = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_UART5RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_UART5RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_UART4RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_UART4RST = `enum RCC_APB1RSTR_UART4RST = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_UART4RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_UART4RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_USART3RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_USART3RST = `enum RCC_APB1RSTR_USART3RST = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_USART3RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_USART3RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_USART2RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_USART2RST = `enum RCC_APB1RSTR_USART2RST = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_USART2RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_USART2RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_SPI3RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_SPI3RST = `enum RCC_APB1RSTR_SPI3RST = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_SPI3RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_SPI3RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_SPI2RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_SPI2RST = `enum RCC_APB1RSTR_SPI2RST = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_SPI2RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_SPI2RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_WWDGRST))) {
        private enum enumMixinStr_RCC_APB1RSTR_WWDGRST = `enum RCC_APB1RSTR_WWDGRST = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_WWDGRST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_WWDGRST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM14RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM14RST = `enum RCC_APB1RSTR_TIM14RST = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM14RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM14RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM13RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM13RST = `enum RCC_APB1RSTR_TIM13RST = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM13RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM13RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM12RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM12RST = `enum RCC_APB1RSTR_TIM12RST = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM12RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM12RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM7RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM7RST = `enum RCC_APB1RSTR_TIM7RST = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM7RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM7RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM6RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM6RST = `enum RCC_APB1RSTR_TIM6RST = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM6RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM6RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM5RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM5RST = `enum RCC_APB1RSTR_TIM5RST = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM5RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM5RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM4RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM4RST = `enum RCC_APB1RSTR_TIM4RST = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM4RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM4RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM3RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM3RST = `enum RCC_APB1RSTR_TIM3RST = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM3RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM3RST);
        }
    }




    static if(!is(typeof(RCC_APB1RSTR_TIM2RST))) {
        private enum enumMixinStr_RCC_APB1RSTR_TIM2RST = `enum RCC_APB1RSTR_TIM2RST = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1RSTR_TIM2RST); }))) {
            mixin(enumMixinStr_RCC_APB1RSTR_TIM2RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_DSIRST))) {
        private enum enumMixinStr_RCC_APB2RSTR_DSIRST = `enum RCC_APB2RSTR_DSIRST = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_DSIRST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_DSIRST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_LTDCRST))) {
        private enum enumMixinStr_RCC_APB2RSTR_LTDCRST = `enum RCC_APB2RSTR_LTDCRST = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_LTDCRST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_LTDCRST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SAI1RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SAI1RST = `enum RCC_APB2RSTR_SAI1RST = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SAI1RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SAI1RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SPI6RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SPI6RST = `enum RCC_APB2RSTR_SPI6RST = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SPI6RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SPI6RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SPI5RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SPI5RST = `enum RCC_APB2RSTR_SPI5RST = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SPI5RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SPI5RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_TIM11RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_TIM11RST = `enum RCC_APB2RSTR_TIM11RST = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_TIM11RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_TIM11RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_TIM10RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_TIM10RST = `enum RCC_APB2RSTR_TIM10RST = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_TIM10RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_TIM10RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_TIM9RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_TIM9RST = `enum RCC_APB2RSTR_TIM9RST = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_TIM9RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_TIM9RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SYSCFGRST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SYSCFGRST = `enum RCC_APB2RSTR_SYSCFGRST = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SYSCFGRST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SYSCFGRST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SPI4RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SPI4RST = `enum RCC_APB2RSTR_SPI4RST = ( 1 << 13 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SPI4RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SPI4RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SPI1RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SPI1RST = `enum RCC_APB2RSTR_SPI1RST = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SPI1RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SPI1RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_SDIORST))) {
        private enum enumMixinStr_RCC_APB2RSTR_SDIORST = `enum RCC_APB2RSTR_SDIORST = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_SDIORST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_SDIORST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_ADCRST))) {
        private enum enumMixinStr_RCC_APB2RSTR_ADCRST = `enum RCC_APB2RSTR_ADCRST = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_ADCRST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_ADCRST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_USART6RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_USART6RST = `enum RCC_APB2RSTR_USART6RST = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_USART6RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_USART6RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_USART1RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_USART1RST = `enum RCC_APB2RSTR_USART1RST = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_USART1RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_USART1RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_TIM8RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_TIM8RST = `enum RCC_APB2RSTR_TIM8RST = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_TIM8RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_TIM8RST);
        }
    }




    static if(!is(typeof(RCC_APB2RSTR_TIM1RST))) {
        private enum enumMixinStr_RCC_APB2RSTR_TIM1RST = `enum RCC_APB2RSTR_TIM1RST = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2RSTR_TIM1RST); }))) {
            mixin(enumMixinStr_RCC_APB2RSTR_TIM1RST);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_OTGHSULPIEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_OTGHSULPIEN = `enum RCC_AHB1ENR_OTGHSULPIEN = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_OTGHSULPIEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_OTGHSULPIEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_OTGHSEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_OTGHSEN = `enum RCC_AHB1ENR_OTGHSEN = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_OTGHSEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_OTGHSEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_ETHMACPTPEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_ETHMACPTPEN = `enum RCC_AHB1ENR_ETHMACPTPEN = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_ETHMACPTPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_ETHMACPTPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_ETHMACRXEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_ETHMACRXEN = `enum RCC_AHB1ENR_ETHMACRXEN = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_ETHMACRXEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_ETHMACRXEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_ETHMACTXEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_ETHMACTXEN = `enum RCC_AHB1ENR_ETHMACTXEN = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_ETHMACTXEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_ETHMACTXEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_ETHMACEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_ETHMACEN = `enum RCC_AHB1ENR_ETHMACEN = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_ETHMACEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_ETHMACEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_DMA2DEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_DMA2DEN = `enum RCC_AHB1ENR_DMA2DEN = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_DMA2DEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_DMA2DEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_DMA2EN))) {
        private enum enumMixinStr_RCC_AHB1ENR_DMA2EN = `enum RCC_AHB1ENR_DMA2EN = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_DMA2EN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_DMA2EN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_DMA1EN))) {
        private enum enumMixinStr_RCC_AHB1ENR_DMA1EN = `enum RCC_AHB1ENR_DMA1EN = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_DMA1EN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_DMA1EN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_CCMDATARAMEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_CCMDATARAMEN = `enum RCC_AHB1ENR_CCMDATARAMEN = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_CCMDATARAMEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_CCMDATARAMEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_BKPSRAMEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_BKPSRAMEN = `enum RCC_AHB1ENR_BKPSRAMEN = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_BKPSRAMEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_BKPSRAMEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_CRCEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_CRCEN = `enum RCC_AHB1ENR_CRCEN = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_CRCEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_CRCEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOKEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOKEN = `enum RCC_AHB1ENR_GPIOKEN = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOKEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOKEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOJEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOJEN = `enum RCC_AHB1ENR_GPIOJEN = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOJEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOJEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOIEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOIEN = `enum RCC_AHB1ENR_GPIOIEN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOIEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOIEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOHEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOHEN = `enum RCC_AHB1ENR_GPIOHEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOHEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOHEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOGEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOGEN = `enum RCC_AHB1ENR_GPIOGEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOGEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOGEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOFEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOFEN = `enum RCC_AHB1ENR_GPIOFEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOFEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOFEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOEEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOEEN = `enum RCC_AHB1ENR_GPIOEEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOEEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOEEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIODEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIODEN = `enum RCC_AHB1ENR_GPIODEN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIODEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIODEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOCEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOCEN = `enum RCC_AHB1ENR_GPIOCEN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOCEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOCEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOBEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOBEN = `enum RCC_AHB1ENR_GPIOBEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOBEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOBEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_GPIOAEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_GPIOAEN = `enum RCC_AHB1ENR_GPIOAEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_GPIOAEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_GPIOAEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPKEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPKEN = `enum RCC_AHB1ENR_IOPKEN = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPKEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPKEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPJEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPJEN = `enum RCC_AHB1ENR_IOPJEN = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPJEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPJEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPIEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPIEN = `enum RCC_AHB1ENR_IOPIEN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPIEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPIEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPHEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPHEN = `enum RCC_AHB1ENR_IOPHEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPHEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPHEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPGEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPGEN = `enum RCC_AHB1ENR_IOPGEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPGEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPGEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPFEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPFEN = `enum RCC_AHB1ENR_IOPFEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPFEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPFEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPEEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPEEN = `enum RCC_AHB1ENR_IOPEEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPEEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPEEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPDEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPDEN = `enum RCC_AHB1ENR_IOPDEN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPDEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPDEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPCEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPCEN = `enum RCC_AHB1ENR_IOPCEN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPCEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPCEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPBEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPBEN = `enum RCC_AHB1ENR_IOPBEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPBEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPBEN);
        }
    }




    static if(!is(typeof(RCC_AHB1ENR_IOPAEN))) {
        private enum enumMixinStr_RCC_AHB1ENR_IOPAEN = `enum RCC_AHB1ENR_IOPAEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1ENR_IOPAEN); }))) {
            mixin(enumMixinStr_RCC_AHB1ENR_IOPAEN);
        }
    }




    static if(!is(typeof(RCC_AHB2ENR_OTGFSEN))) {
        private enum enumMixinStr_RCC_AHB2ENR_OTGFSEN = `enum RCC_AHB2ENR_OTGFSEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2ENR_OTGFSEN); }))) {
            mixin(enumMixinStr_RCC_AHB2ENR_OTGFSEN);
        }
    }




    static if(!is(typeof(RCC_AHB2ENR_RNGEN))) {
        private enum enumMixinStr_RCC_AHB2ENR_RNGEN = `enum RCC_AHB2ENR_RNGEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2ENR_RNGEN); }))) {
            mixin(enumMixinStr_RCC_AHB2ENR_RNGEN);
        }
    }




    static if(!is(typeof(RCC_AHB2ENR_HASHEN))) {
        private enum enumMixinStr_RCC_AHB2ENR_HASHEN = `enum RCC_AHB2ENR_HASHEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2ENR_HASHEN); }))) {
            mixin(enumMixinStr_RCC_AHB2ENR_HASHEN);
        }
    }




    static if(!is(typeof(RCC_AHB2ENR_CRYPEN))) {
        private enum enumMixinStr_RCC_AHB2ENR_CRYPEN = `enum RCC_AHB2ENR_CRYPEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2ENR_CRYPEN); }))) {
            mixin(enumMixinStr_RCC_AHB2ENR_CRYPEN);
        }
    }




    static if(!is(typeof(RCC_AHB2ENR_DCMIEN))) {
        private enum enumMixinStr_RCC_AHB2ENR_DCMIEN = `enum RCC_AHB2ENR_DCMIEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2ENR_DCMIEN); }))) {
            mixin(enumMixinStr_RCC_AHB2ENR_DCMIEN);
        }
    }




    static if(!is(typeof(RCC_AHB3ENR_QSPIEN))) {
        private enum enumMixinStr_RCC_AHB3ENR_QSPIEN = `enum RCC_AHB3ENR_QSPIEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3ENR_QSPIEN); }))) {
            mixin(enumMixinStr_RCC_AHB3ENR_QSPIEN);
        }
    }




    static if(!is(typeof(RCC_AHB3ENR_FSMCEN))) {
        private enum enumMixinStr_RCC_AHB3ENR_FSMCEN = `enum RCC_AHB3ENR_FSMCEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3ENR_FSMCEN); }))) {
            mixin(enumMixinStr_RCC_AHB3ENR_FSMCEN);
        }
    }




    static if(!is(typeof(RCC_AHB3ENR_FMCEN))) {
        private enum enumMixinStr_RCC_AHB3ENR_FMCEN = `enum RCC_AHB3ENR_FMCEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3ENR_FMCEN); }))) {
            mixin(enumMixinStr_RCC_AHB3ENR_FMCEN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_UART8EN))) {
        private enum enumMixinStr_RCC_APB1ENR_UART8EN = `enum RCC_APB1ENR_UART8EN = ( 1 << 31 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_UART8EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_UART8EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_UART7EN))) {
        private enum enumMixinStr_RCC_APB1ENR_UART7EN = `enum RCC_APB1ENR_UART7EN = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_UART7EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_UART7EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_DACEN))) {
        private enum enumMixinStr_RCC_APB1ENR_DACEN = `enum RCC_APB1ENR_DACEN = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_DACEN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_DACEN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_PWREN))) {
        private enum enumMixinStr_RCC_APB1ENR_PWREN = `enum RCC_APB1ENR_PWREN = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_PWREN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_PWREN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_CAN2EN))) {
        private enum enumMixinStr_RCC_APB1ENR_CAN2EN = `enum RCC_APB1ENR_CAN2EN = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_CAN2EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_CAN2EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_CAN1EN))) {
        private enum enumMixinStr_RCC_APB1ENR_CAN1EN = `enum RCC_APB1ENR_CAN1EN = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_CAN1EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_CAN1EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_I2C3EN))) {
        private enum enumMixinStr_RCC_APB1ENR_I2C3EN = `enum RCC_APB1ENR_I2C3EN = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_I2C3EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_I2C3EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_I2C2EN))) {
        private enum enumMixinStr_RCC_APB1ENR_I2C2EN = `enum RCC_APB1ENR_I2C2EN = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_I2C2EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_I2C2EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_I2C1EN))) {
        private enum enumMixinStr_RCC_APB1ENR_I2C1EN = `enum RCC_APB1ENR_I2C1EN = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_I2C1EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_I2C1EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_UART5EN))) {
        private enum enumMixinStr_RCC_APB1ENR_UART5EN = `enum RCC_APB1ENR_UART5EN = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_UART5EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_UART5EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_UART4EN))) {
        private enum enumMixinStr_RCC_APB1ENR_UART4EN = `enum RCC_APB1ENR_UART4EN = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_UART4EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_UART4EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_USART3EN))) {
        private enum enumMixinStr_RCC_APB1ENR_USART3EN = `enum RCC_APB1ENR_USART3EN = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_USART3EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_USART3EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_USART2EN))) {
        private enum enumMixinStr_RCC_APB1ENR_USART2EN = `enum RCC_APB1ENR_USART2EN = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_USART2EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_USART2EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_SPI3EN))) {
        private enum enumMixinStr_RCC_APB1ENR_SPI3EN = `enum RCC_APB1ENR_SPI3EN = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_SPI3EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_SPI3EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_SPI2EN))) {
        private enum enumMixinStr_RCC_APB1ENR_SPI2EN = `enum RCC_APB1ENR_SPI2EN = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_SPI2EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_SPI2EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_WWDGEN))) {
        private enum enumMixinStr_RCC_APB1ENR_WWDGEN = `enum RCC_APB1ENR_WWDGEN = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_WWDGEN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_WWDGEN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM14EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM14EN = `enum RCC_APB1ENR_TIM14EN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM14EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM14EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM13EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM13EN = `enum RCC_APB1ENR_TIM13EN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM13EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM13EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM12EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM12EN = `enum RCC_APB1ENR_TIM12EN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM12EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM12EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM7EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM7EN = `enum RCC_APB1ENR_TIM7EN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM7EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM7EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM6EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM6EN = `enum RCC_APB1ENR_TIM6EN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM6EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM6EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM5EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM5EN = `enum RCC_APB1ENR_TIM5EN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM5EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM5EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM4EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM4EN = `enum RCC_APB1ENR_TIM4EN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM4EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM4EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM3EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM3EN = `enum RCC_APB1ENR_TIM3EN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM3EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM3EN);
        }
    }




    static if(!is(typeof(RCC_APB1ENR_TIM2EN))) {
        private enum enumMixinStr_RCC_APB1ENR_TIM2EN = `enum RCC_APB1ENR_TIM2EN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1ENR_TIM2EN); }))) {
            mixin(enumMixinStr_RCC_APB1ENR_TIM2EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_DSIEN))) {
        private enum enumMixinStr_RCC_APB2ENR_DSIEN = `enum RCC_APB2ENR_DSIEN = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_DSIEN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_DSIEN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_LTDCEN))) {
        private enum enumMixinStr_RCC_APB2ENR_LTDCEN = `enum RCC_APB2ENR_LTDCEN = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_LTDCEN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_LTDCEN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SAI1EN))) {
        private enum enumMixinStr_RCC_APB2ENR_SAI1EN = `enum RCC_APB2ENR_SAI1EN = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SAI1EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SAI1EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SPI6EN))) {
        private enum enumMixinStr_RCC_APB2ENR_SPI6EN = `enum RCC_APB2ENR_SPI6EN = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SPI6EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SPI6EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SPI5EN))) {
        private enum enumMixinStr_RCC_APB2ENR_SPI5EN = `enum RCC_APB2ENR_SPI5EN = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SPI5EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SPI5EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_TIM11EN))) {
        private enum enumMixinStr_RCC_APB2ENR_TIM11EN = `enum RCC_APB2ENR_TIM11EN = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_TIM11EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_TIM11EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_TIM10EN))) {
        private enum enumMixinStr_RCC_APB2ENR_TIM10EN = `enum RCC_APB2ENR_TIM10EN = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_TIM10EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_TIM10EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_TIM9EN))) {
        private enum enumMixinStr_RCC_APB2ENR_TIM9EN = `enum RCC_APB2ENR_TIM9EN = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_TIM9EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_TIM9EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SYSCFGEN))) {
        private enum enumMixinStr_RCC_APB2ENR_SYSCFGEN = `enum RCC_APB2ENR_SYSCFGEN = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SYSCFGEN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SYSCFGEN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SPI4EN))) {
        private enum enumMixinStr_RCC_APB2ENR_SPI4EN = `enum RCC_APB2ENR_SPI4EN = ( 1 << 13 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SPI4EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SPI4EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SPI1EN))) {
        private enum enumMixinStr_RCC_APB2ENR_SPI1EN = `enum RCC_APB2ENR_SPI1EN = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SPI1EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SPI1EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_SDIOEN))) {
        private enum enumMixinStr_RCC_APB2ENR_SDIOEN = `enum RCC_APB2ENR_SDIOEN = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_SDIOEN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_SDIOEN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_ADC3EN))) {
        private enum enumMixinStr_RCC_APB2ENR_ADC3EN = `enum RCC_APB2ENR_ADC3EN = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_ADC3EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_ADC3EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_ADC2EN))) {
        private enum enumMixinStr_RCC_APB2ENR_ADC2EN = `enum RCC_APB2ENR_ADC2EN = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_ADC2EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_ADC2EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_ADC1EN))) {
        private enum enumMixinStr_RCC_APB2ENR_ADC1EN = `enum RCC_APB2ENR_ADC1EN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_ADC1EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_ADC1EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_USART6EN))) {
        private enum enumMixinStr_RCC_APB2ENR_USART6EN = `enum RCC_APB2ENR_USART6EN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_USART6EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_USART6EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_USART1EN))) {
        private enum enumMixinStr_RCC_APB2ENR_USART1EN = `enum RCC_APB2ENR_USART1EN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_USART1EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_USART1EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_TIM8EN))) {
        private enum enumMixinStr_RCC_APB2ENR_TIM8EN = `enum RCC_APB2ENR_TIM8EN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_TIM8EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_TIM8EN);
        }
    }




    static if(!is(typeof(RCC_APB2ENR_TIM1EN))) {
        private enum enumMixinStr_RCC_APB2ENR_TIM1EN = `enum RCC_APB2ENR_TIM1EN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2ENR_TIM1EN); }))) {
            mixin(enumMixinStr_RCC_APB2ENR_TIM1EN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_OTGHSULPILPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_OTGHSULPILPEN = `enum RCC_AHB1LPENR_OTGHSULPILPEN = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_OTGHSULPILPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_OTGHSULPILPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_OTGHSLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_OTGHSLPEN = `enum RCC_AHB1LPENR_OTGHSLPEN = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_OTGHSLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_OTGHSLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_ETHMACPTPLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_ETHMACPTPLPEN = `enum RCC_AHB1LPENR_ETHMACPTPLPEN = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACPTPLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACPTPLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_ETHMACRXLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_ETHMACRXLPEN = `enum RCC_AHB1LPENR_ETHMACRXLPEN = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACRXLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACRXLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_ETHMACTXLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_ETHMACTXLPEN = `enum RCC_AHB1LPENR_ETHMACTXLPEN = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACTXLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACTXLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_ETHMACLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_ETHMACLPEN = `enum RCC_AHB1LPENR_ETHMACLPEN = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_ETHMACLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_DMA2DLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_DMA2DLPEN = `enum RCC_AHB1LPENR_DMA2DLPEN = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_DMA2DLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_DMA2DLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_DMA2LPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_DMA2LPEN = `enum RCC_AHB1LPENR_DMA2LPEN = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_DMA2LPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_DMA2LPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_DMA1LPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_DMA1LPEN = `enum RCC_AHB1LPENR_DMA1LPEN = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_DMA1LPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_DMA1LPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_SRAM3LPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_SRAM3LPEN = `enum RCC_AHB1LPENR_SRAM3LPEN = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_SRAM3LPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_SRAM3LPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_BKPSRAMLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_BKPSRAMLPEN = `enum RCC_AHB1LPENR_BKPSRAMLPEN = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_BKPSRAMLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_BKPSRAMLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_SRAM2LPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_SRAM2LPEN = `enum RCC_AHB1LPENR_SRAM2LPEN = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_SRAM2LPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_SRAM2LPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_SRAM1LPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_SRAM1LPEN = `enum RCC_AHB1LPENR_SRAM1LPEN = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_SRAM1LPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_SRAM1LPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_FLITFLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_FLITFLPEN = `enum RCC_AHB1LPENR_FLITFLPEN = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_FLITFLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_FLITFLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_CRCLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_CRCLPEN = `enum RCC_AHB1LPENR_CRCLPEN = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_CRCLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_CRCLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOKLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOKLPEN = `enum RCC_AHB1LPENR_GPIOKLPEN = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOKLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOKLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOJLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOJLPEN = `enum RCC_AHB1LPENR_GPIOJLPEN = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOJLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOJLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOILPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOILPEN = `enum RCC_AHB1LPENR_GPIOILPEN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOILPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOILPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOHLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOHLPEN = `enum RCC_AHB1LPENR_GPIOHLPEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOHLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOHLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOGLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOGLPEN = `enum RCC_AHB1LPENR_GPIOGLPEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOGLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOGLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOFLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOFLPEN = `enum RCC_AHB1LPENR_GPIOFLPEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOFLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOFLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOELPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOELPEN = `enum RCC_AHB1LPENR_GPIOELPEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOELPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOELPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIODLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIODLPEN = `enum RCC_AHB1LPENR_GPIODLPEN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIODLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIODLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOCLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOCLPEN = `enum RCC_AHB1LPENR_GPIOCLPEN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOCLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOCLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOBLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOBLPEN = `enum RCC_AHB1LPENR_GPIOBLPEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOBLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOBLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_GPIOALPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_GPIOALPEN = `enum RCC_AHB1LPENR_GPIOALPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_GPIOALPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_GPIOALPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPKLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPKLPEN = `enum RCC_AHB1LPENR_IOPKLPEN = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPKLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPKLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPJLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPJLPEN = `enum RCC_AHB1LPENR_IOPJLPEN = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPJLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPJLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPILPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPILPEN = `enum RCC_AHB1LPENR_IOPILPEN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPILPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPILPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPHLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPHLPEN = `enum RCC_AHB1LPENR_IOPHLPEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPHLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPHLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPGLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPGLPEN = `enum RCC_AHB1LPENR_IOPGLPEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPGLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPGLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPFLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPFLPEN = `enum RCC_AHB1LPENR_IOPFLPEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPFLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPFLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPELPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPELPEN = `enum RCC_AHB1LPENR_IOPELPEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPELPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPELPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPDLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPDLPEN = `enum RCC_AHB1LPENR_IOPDLPEN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPDLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPDLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPCLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPCLPEN = `enum RCC_AHB1LPENR_IOPCLPEN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPCLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPCLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPBLPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPBLPEN = `enum RCC_AHB1LPENR_IOPBLPEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPBLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPBLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB1LPENR_IOPALPEN))) {
        private enum enumMixinStr_RCC_AHB1LPENR_IOPALPEN = `enum RCC_AHB1LPENR_IOPALPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB1LPENR_IOPALPEN); }))) {
            mixin(enumMixinStr_RCC_AHB1LPENR_IOPALPEN);
        }
    }




    static if(!is(typeof(RCC_AHB2LPENR_OTGFSLPEN))) {
        private enum enumMixinStr_RCC_AHB2LPENR_OTGFSLPEN = `enum RCC_AHB2LPENR_OTGFSLPEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2LPENR_OTGFSLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB2LPENR_OTGFSLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB2LPENR_RNGLPEN))) {
        private enum enumMixinStr_RCC_AHB2LPENR_RNGLPEN = `enum RCC_AHB2LPENR_RNGLPEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2LPENR_RNGLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB2LPENR_RNGLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB2LPENR_HASHLPEN))) {
        private enum enumMixinStr_RCC_AHB2LPENR_HASHLPEN = `enum RCC_AHB2LPENR_HASHLPEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2LPENR_HASHLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB2LPENR_HASHLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB2LPENR_CRYPLPEN))) {
        private enum enumMixinStr_RCC_AHB2LPENR_CRYPLPEN = `enum RCC_AHB2LPENR_CRYPLPEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2LPENR_CRYPLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB2LPENR_CRYPLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB2LPENR_DCMILPEN))) {
        private enum enumMixinStr_RCC_AHB2LPENR_DCMILPEN = `enum RCC_AHB2LPENR_DCMILPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB2LPENR_DCMILPEN); }))) {
            mixin(enumMixinStr_RCC_AHB2LPENR_DCMILPEN);
        }
    }




    static if(!is(typeof(RCC_AHB3LPENR_QSPIEN))) {
        private enum enumMixinStr_RCC_AHB3LPENR_QSPIEN = `enum RCC_AHB3LPENR_QSPIEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3LPENR_QSPIEN); }))) {
            mixin(enumMixinStr_RCC_AHB3LPENR_QSPIEN);
        }
    }




    static if(!is(typeof(RCC_AHB3LPENR_FSMCLPEN))) {
        private enum enumMixinStr_RCC_AHB3LPENR_FSMCLPEN = `enum RCC_AHB3LPENR_FSMCLPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3LPENR_FSMCLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB3LPENR_FSMCLPEN);
        }
    }




    static if(!is(typeof(RCC_AHB3LPENR_FMCLPEN))) {
        private enum enumMixinStr_RCC_AHB3LPENR_FMCLPEN = `enum RCC_AHB3LPENR_FMCLPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_AHB3LPENR_FMCLPEN); }))) {
            mixin(enumMixinStr_RCC_AHB3LPENR_FMCLPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_UART8EN))) {
        private enum enumMixinStr_RCC_APB1LPENR_UART8EN = `enum RCC_APB1LPENR_UART8EN = ( 1 << 31 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_UART8EN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_UART8EN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_UART7EN))) {
        private enum enumMixinStr_RCC_APB1LPENR_UART7EN = `enum RCC_APB1LPENR_UART7EN = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_UART7EN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_UART7EN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_DACLPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_DACLPEN = `enum RCC_APB1LPENR_DACLPEN = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_DACLPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_DACLPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_PWRLPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_PWRLPEN = `enum RCC_APB1LPENR_PWRLPEN = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_PWRLPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_PWRLPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_CAN2LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_CAN2LPEN = `enum RCC_APB1LPENR_CAN2LPEN = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_CAN2LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_CAN2LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_CAN1LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_CAN1LPEN = `enum RCC_APB1LPENR_CAN1LPEN = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_CAN1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_CAN1LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_I2C3LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_I2C3LPEN = `enum RCC_APB1LPENR_I2C3LPEN = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_I2C3LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_I2C3LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_I2C2LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_I2C2LPEN = `enum RCC_APB1LPENR_I2C2LPEN = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_I2C2LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_I2C2LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_I2C1LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_I2C1LPEN = `enum RCC_APB1LPENR_I2C1LPEN = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_I2C1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_I2C1LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_UART5LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_UART5LPEN = `enum RCC_APB1LPENR_UART5LPEN = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_UART5LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_UART5LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_UART4LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_UART4LPEN = `enum RCC_APB1LPENR_UART4LPEN = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_UART4LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_UART4LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_USART3LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_USART3LPEN = `enum RCC_APB1LPENR_USART3LPEN = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_USART3LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_USART3LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_USART2LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_USART2LPEN = `enum RCC_APB1LPENR_USART2LPEN = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_USART2LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_USART2LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_SPI3LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_SPI3LPEN = `enum RCC_APB1LPENR_SPI3LPEN = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_SPI3LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_SPI3LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_SPI2LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_SPI2LPEN = `enum RCC_APB1LPENR_SPI2LPEN = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_SPI2LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_SPI2LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_WWDGLPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_WWDGLPEN = `enum RCC_APB1LPENR_WWDGLPEN = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_WWDGLPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_WWDGLPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM14LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM14LPEN = `enum RCC_APB1LPENR_TIM14LPEN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM14LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM14LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM13LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM13LPEN = `enum RCC_APB1LPENR_TIM13LPEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM13LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM13LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM12LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM12LPEN = `enum RCC_APB1LPENR_TIM12LPEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM12LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM12LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM7LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM7LPEN = `enum RCC_APB1LPENR_TIM7LPEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM7LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM7LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM6LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM6LPEN = `enum RCC_APB1LPENR_TIM6LPEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM6LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM6LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM5LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM5LPEN = `enum RCC_APB1LPENR_TIM5LPEN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM5LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM5LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM4LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM4LPEN = `enum RCC_APB1LPENR_TIM4LPEN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM4LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM4LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM3LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM3LPEN = `enum RCC_APB1LPENR_TIM3LPEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM3LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM3LPEN);
        }
    }




    static if(!is(typeof(RCC_APB1LPENR_TIM2LPEN))) {
        private enum enumMixinStr_RCC_APB1LPENR_TIM2LPEN = `enum RCC_APB1LPENR_TIM2LPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB1LPENR_TIM2LPEN); }))) {
            mixin(enumMixinStr_RCC_APB1LPENR_TIM2LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_DSILPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_DSILPEN = `enum RCC_APB2LPENR_DSILPEN = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_DSILPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_DSILPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_LTDCLPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_LTDCLPEN = `enum RCC_APB2LPENR_LTDCLPEN = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_LTDCLPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_LTDCLPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_SAI1LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_SAI1LPEN = `enum RCC_APB2LPENR_SAI1LPEN = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_SAI1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_SAI1LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_SPI6LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_SPI6LPEN = `enum RCC_APB2LPENR_SPI6LPEN = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_SPI6LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_SPI6LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_SPI5LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_SPI5LPEN = `enum RCC_APB2LPENR_SPI5LPEN = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_SPI5LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_SPI5LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_TIM11LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_TIM11LPEN = `enum RCC_APB2LPENR_TIM11LPEN = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_TIM11LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_TIM11LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_TIM10LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_TIM10LPEN = `enum RCC_APB2LPENR_TIM10LPEN = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_TIM10LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_TIM10LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_TIM9LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_TIM9LPEN = `enum RCC_APB2LPENR_TIM9LPEN = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_TIM9LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_TIM9LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_SYSCFGLPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_SYSCFGLPEN = `enum RCC_APB2LPENR_SYSCFGLPEN = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_SYSCFGLPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_SYSCFGLPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_SPI1LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_SPI1LPEN = `enum RCC_APB2LPENR_SPI1LPEN = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_SPI1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_SPI1LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_SDIOLPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_SDIOLPEN = `enum RCC_APB2LPENR_SDIOLPEN = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_SDIOLPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_SDIOLPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_ADC3LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_ADC3LPEN = `enum RCC_APB2LPENR_ADC3LPEN = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_ADC3LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_ADC3LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_ADC2LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_ADC2LPEN = `enum RCC_APB2LPENR_ADC2LPEN = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_ADC2LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_ADC2LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_ADC1LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_ADC1LPEN = `enum RCC_APB2LPENR_ADC1LPEN = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_ADC1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_ADC1LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_USART6LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_USART6LPEN = `enum RCC_APB2LPENR_USART6LPEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_USART6LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_USART6LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_USART1LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_USART1LPEN = `enum RCC_APB2LPENR_USART1LPEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_USART1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_USART1LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_TIM8LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_TIM8LPEN = `enum RCC_APB2LPENR_TIM8LPEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_TIM8LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_TIM8LPEN);
        }
    }




    static if(!is(typeof(RCC_APB2LPENR_TIM1LPEN))) {
        private enum enumMixinStr_RCC_APB2LPENR_TIM1LPEN = `enum RCC_APB2LPENR_TIM1LPEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_APB2LPENR_TIM1LPEN); }))) {
            mixin(enumMixinStr_RCC_APB2LPENR_TIM1LPEN);
        }
    }




    static if(!is(typeof(RCC_BDCR_BDRST))) {
        private enum enumMixinStr_RCC_BDCR_BDRST = `enum RCC_BDCR_BDRST = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_BDRST); }))) {
            mixin(enumMixinStr_RCC_BDCR_BDRST);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCEN))) {
        private enum enumMixinStr_RCC_BDCR_RTCEN = `enum RCC_BDCR_RTCEN = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCEN); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCEN);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCSEL_SHIFT))) {
        private enum enumMixinStr_RCC_BDCR_RTCSEL_SHIFT = `enum RCC_BDCR_RTCSEL_SHIFT = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCSEL_SHIFT); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCSEL_SHIFT);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCSEL_MASK))) {
        private enum enumMixinStr_RCC_BDCR_RTCSEL_MASK = `enum RCC_BDCR_RTCSEL_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCSEL_MASK); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCSEL_MASK);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCSEL_NONE))) {
        private enum enumMixinStr_RCC_BDCR_RTCSEL_NONE = `enum RCC_BDCR_RTCSEL_NONE = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCSEL_NONE); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCSEL_NONE);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCSEL_LSE))) {
        private enum enumMixinStr_RCC_BDCR_RTCSEL_LSE = `enum RCC_BDCR_RTCSEL_LSE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCSEL_LSE); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCSEL_LSE);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCSEL_LSI))) {
        private enum enumMixinStr_RCC_BDCR_RTCSEL_LSI = `enum RCC_BDCR_RTCSEL_LSI = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCSEL_LSI); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCSEL_LSI);
        }
    }




    static if(!is(typeof(RCC_BDCR_RTCSEL_HSE))) {
        private enum enumMixinStr_RCC_BDCR_RTCSEL_HSE = `enum RCC_BDCR_RTCSEL_HSE = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_RTCSEL_HSE); }))) {
            mixin(enumMixinStr_RCC_BDCR_RTCSEL_HSE);
        }
    }




    static if(!is(typeof(RCC_BDCR_LSEMOD))) {
        private enum enumMixinStr_RCC_BDCR_LSEMOD = `enum RCC_BDCR_LSEMOD = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_LSEMOD); }))) {
            mixin(enumMixinStr_RCC_BDCR_LSEMOD);
        }
    }




    static if(!is(typeof(RCC_BDCR_LSEBYP))) {
        private enum enumMixinStr_RCC_BDCR_LSEBYP = `enum RCC_BDCR_LSEBYP = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_LSEBYP); }))) {
            mixin(enumMixinStr_RCC_BDCR_LSEBYP);
        }
    }




    static if(!is(typeof(RCC_BDCR_LSERDY))) {
        private enum enumMixinStr_RCC_BDCR_LSERDY = `enum RCC_BDCR_LSERDY = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_LSERDY); }))) {
            mixin(enumMixinStr_RCC_BDCR_LSERDY);
        }
    }




    static if(!is(typeof(RCC_BDCR_LSEON))) {
        private enum enumMixinStr_RCC_BDCR_LSEON = `enum RCC_BDCR_LSEON = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_BDCR_LSEON); }))) {
            mixin(enumMixinStr_RCC_BDCR_LSEON);
        }
    }




    static if(!is(typeof(RCC_CSR_LPWRRSTF))) {
        private enum enumMixinStr_RCC_CSR_LPWRRSTF = `enum RCC_CSR_LPWRRSTF = ( 1 << 31 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_LPWRRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_LPWRRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_WWDGRSTF))) {
        private enum enumMixinStr_RCC_CSR_WWDGRSTF = `enum RCC_CSR_WWDGRSTF = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_WWDGRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_WWDGRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_IWDGRSTF))) {
        private enum enumMixinStr_RCC_CSR_IWDGRSTF = `enum RCC_CSR_IWDGRSTF = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_IWDGRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_IWDGRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_SFTRSTF))) {
        private enum enumMixinStr_RCC_CSR_SFTRSTF = `enum RCC_CSR_SFTRSTF = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_SFTRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_SFTRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_PORRSTF))) {
        private enum enumMixinStr_RCC_CSR_PORRSTF = `enum RCC_CSR_PORRSTF = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_PORRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_PORRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_PINRSTF))) {
        private enum enumMixinStr_RCC_CSR_PINRSTF = `enum RCC_CSR_PINRSTF = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_PINRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_PINRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_BORRSTF))) {
        private enum enumMixinStr_RCC_CSR_BORRSTF = `enum RCC_CSR_BORRSTF = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_BORRSTF); }))) {
            mixin(enumMixinStr_RCC_CSR_BORRSTF);
        }
    }




    static if(!is(typeof(RCC_CSR_RMVF))) {
        private enum enumMixinStr_RCC_CSR_RMVF = `enum RCC_CSR_RMVF = ( 1 << 24 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_RMVF); }))) {
            mixin(enumMixinStr_RCC_CSR_RMVF);
        }
    }




    static if(!is(typeof(RCC_CSR_RESET_FLAGS))) {
        private enum enumMixinStr_RCC_CSR_RESET_FLAGS = `enum RCC_CSR_RESET_FLAGS = ( ( 1 << 31 ) | ( 1 << 30 ) | ( 1 << 29 ) | ( 1 << 28 ) | ( 1 << 27 ) | ( 1 << 26 ) | ( 1 << 25 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_RESET_FLAGS); }))) {
            mixin(enumMixinStr_RCC_CSR_RESET_FLAGS);
        }
    }




    static if(!is(typeof(RCC_CSR_LSIRDY))) {
        private enum enumMixinStr_RCC_CSR_LSIRDY = `enum RCC_CSR_LSIRDY = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_LSIRDY); }))) {
            mixin(enumMixinStr_RCC_CSR_LSIRDY);
        }
    }




    static if(!is(typeof(RCC_CSR_LSION))) {
        private enum enumMixinStr_RCC_CSR_LSION = `enum RCC_CSR_LSION = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CSR_LSION); }))) {
            mixin(enumMixinStr_RCC_CSR_LSION);
        }
    }




    static if(!is(typeof(RCC_SSCGR_SSCGEN))) {
        private enum enumMixinStr_RCC_SSCGR_SSCGEN = `enum RCC_SSCGR_SSCGEN = ( 1 << 31 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR_SSCGEN); }))) {
            mixin(enumMixinStr_RCC_SSCGR_SSCGEN);
        }
    }




    static if(!is(typeof(RCC_SSCGR_SPREADSEL))) {
        private enum enumMixinStr_RCC_SSCGR_SPREADSEL = `enum RCC_SSCGR_SPREADSEL = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR_SPREADSEL); }))) {
            mixin(enumMixinStr_RCC_SSCGR_SPREADSEL);
        }
    }




    static if(!is(typeof(RCC_SSCGR_INCSTEP_SHIFT))) {
        private enum enumMixinStr_RCC_SSCGR_INCSTEP_SHIFT = `enum RCC_SSCGR_INCSTEP_SHIFT = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR_INCSTEP_SHIFT); }))) {
            mixin(enumMixinStr_RCC_SSCGR_INCSTEP_SHIFT);
        }
    }




    static if(!is(typeof(RCC_SSCGR_INCSTEP_MASK))) {
        private enum enumMixinStr_RCC_SSCGR_INCSTEP_MASK = `enum RCC_SSCGR_INCSTEP_MASK = 0x7fff;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR_INCSTEP_MASK); }))) {
            mixin(enumMixinStr_RCC_SSCGR_INCSTEP_MASK);
        }
    }




    static if(!is(typeof(RCC_SSCGR_MODPER_SHIFT))) {
        private enum enumMixinStr_RCC_SSCGR_MODPER_SHIFT = `enum RCC_SSCGR_MODPER_SHIFT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR_MODPER_SHIFT); }))) {
            mixin(enumMixinStr_RCC_SSCGR_MODPER_SHIFT);
        }
    }




    static if(!is(typeof(RCC_SSCGR_MODPER_MASK))) {
        private enum enumMixinStr_RCC_SSCGR_MODPER_MASK = `enum RCC_SSCGR_MODPER_MASK = 0x1fff;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_SSCGR_MODPER_MASK); }))) {
            mixin(enumMixinStr_RCC_SSCGR_MODPER_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR_PLLI2SR_SHIFT))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR_PLLI2SR_SHIFT = `enum RCC_PLLI2SCFGR_PLLI2SR_SHIFT = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SR_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SR_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR_PLLI2SR_MASK))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR_PLLI2SR_MASK = `enum RCC_PLLI2SCFGR_PLLI2SR_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SR_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SR_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR_PLLI2SQ_SHIFT))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR_PLLI2SQ_SHIFT = `enum RCC_PLLI2SCFGR_PLLI2SQ_SHIFT = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SQ_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SQ_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR_PLLI2SQ_MASK))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR_PLLI2SQ_MASK = `enum RCC_PLLI2SCFGR_PLLI2SQ_MASK = 0xf;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SQ_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SQ_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR_PLLI2SN_SHIFT))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR_PLLI2SN_SHIFT = `enum RCC_PLLI2SCFGR_PLLI2SN_SHIFT = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SN_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SN_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLI2SCFGR_PLLI2SN_MASK))) {
        private enum enumMixinStr_RCC_PLLI2SCFGR_PLLI2SN_MASK = `enum RCC_PLLI2SCFGR_PLLI2SN_MASK = 0x1ff;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SN_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLI2SCFGR_PLLI2SN_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIR_SHIFT))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIR_SHIFT = `enum RCC_PLLSAICFGR_PLLSAIR_SHIFT = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIR_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIR_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIR_MASK))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIR_MASK = `enum RCC_PLLSAICFGR_PLLSAIR_MASK = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIR_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIR_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIQ_SHIFT))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIQ_SHIFT = `enum RCC_PLLSAICFGR_PLLSAIQ_SHIFT = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIQ_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIQ_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIQ_MASK))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIQ_MASK = `enum RCC_PLLSAICFGR_PLLSAIQ_MASK = 0xF;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIQ_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIQ_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIP_SHIFT))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_SHIFT = `enum RCC_PLLSAICFGR_PLLSAIP_SHIFT = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIP_MASK))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_MASK = `enum RCC_PLLSAICFGR_PLLSAIP_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_MASK);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIP_DIV2))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV2 = `enum RCC_PLLSAICFGR_PLLSAIP_DIV2 = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV2); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV2);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIP_DIV4))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV4 = `enum RCC_PLLSAICFGR_PLLSAIP_DIV4 = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV4); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV4);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIP_DIV6))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV6 = `enum RCC_PLLSAICFGR_PLLSAIP_DIV6 = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV6); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV6);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIP_DIV8))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV8 = `enum RCC_PLLSAICFGR_PLLSAIP_DIV8 = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV8); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIP_DIV8);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIN_SHIFT))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIN_SHIFT = `enum RCC_PLLSAICFGR_PLLSAIN_SHIFT = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIN_SHIFT); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIN_SHIFT);
        }
    }




    static if(!is(typeof(RCC_PLLSAICFGR_PLLSAIN_MASK))) {
        private enum enumMixinStr_RCC_PLLSAICFGR_PLLSAIN_MASK = `enum RCC_PLLSAICFGR_PLLSAIN_MASK = 0x1FF;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIN_MASK); }))) {
            mixin(enumMixinStr_RCC_PLLSAICFGR_PLLSAIN_MASK);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_DSISEL))) {
        private enum enumMixinStr_RCC_DCKCFGR_DSISEL = `enum RCC_DCKCFGR_DSISEL = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_DSISEL); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_DSISEL);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SDMMCSEL))) {
        private enum enumMixinStr_RCC_DCKCFGR_SDMMCSEL = `enum RCC_DCKCFGR_SDMMCSEL = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SDMMCSEL); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SDMMCSEL);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_48MSEL))) {
        private enum enumMixinStr_RCC_DCKCFGR_48MSEL = `enum RCC_DCKCFGR_48MSEL = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_48MSEL); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_48MSEL);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_TIMPRE))) {
        private enum enumMixinStr_RCC_DCKCFGR_TIMPRE = `enum RCC_DCKCFGR_TIMPRE = ( 1 << 24 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_TIMPRE); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_TIMPRE);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1BSRC_SHIFT))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1BSRC_SHIFT = `enum RCC_DCKCFGR_SAI1BSRC_SHIFT = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1BSRC_SHIFT); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1BSRC_SHIFT);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1BSRC_MASK))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1BSRC_MASK = `enum RCC_DCKCFGR_SAI1BSRC_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1BSRC_MASK); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1BSRC_MASK);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1ASRC_SHIFT))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1ASRC_SHIFT = `enum RCC_DCKCFGR_SAI1ASRC_SHIFT = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1ASRC_SHIFT); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1ASRC_SHIFT);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1ASRC_MASK))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1ASRC_MASK = `enum RCC_DCKCFGR_SAI1ASRC_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1ASRC_MASK); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1ASRC_MASK);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1SRC_SAIQ))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1SRC_SAIQ = `enum RCC_DCKCFGR_SAI1SRC_SAIQ = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_SAIQ); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_SAIQ);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1SRC_I2SQ))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1SRC_I2SQ = `enum RCC_DCKCFGR_SAI1SRC_I2SQ = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_I2SQ); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_I2SQ);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1SRC_ALT))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1SRC_ALT = `enum RCC_DCKCFGR_SAI1SRC_ALT = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_ALT); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_ALT);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_SAI1SRC_ERROR))) {
        private enum enumMixinStr_RCC_DCKCFGR_SAI1SRC_ERROR = `enum RCC_DCKCFGR_SAI1SRC_ERROR = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_ERROR); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_SAI1SRC_ERROR);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVR_SHIFT))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_SHIFT = `enum RCC_DCKCFGR_PLLSAIDIVR_SHIFT = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_SHIFT); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVR_MASK))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_MASK = `enum RCC_DCKCFGR_PLLSAIDIVR_MASK = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_MASK); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_MASK);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVR_DIVR_2))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_2 = `enum RCC_DCKCFGR_PLLSAIDIVR_DIVR_2 = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_2); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_2);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVR_DIVR_4))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_4 = `enum RCC_DCKCFGR_PLLSAIDIVR_DIVR_4 = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_4); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_4);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVR_DIVR_8))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_8 = `enum RCC_DCKCFGR_PLLSAIDIVR_DIVR_8 = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_8); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_8);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVR_DIVR_16))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_16 = `enum RCC_DCKCFGR_PLLSAIDIVR_DIVR_16 = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_16); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVR_DIVR_16);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVQ_SHIFT))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVQ_SHIFT = `enum RCC_DCKCFGR_PLLSAIDIVQ_SHIFT = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVQ_SHIFT); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVQ_SHIFT);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLSAIDIVQ_MASK))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLSAIDIVQ_MASK = `enum RCC_DCKCFGR_PLLSAIDIVQ_MASK = 0x1f;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVQ_MASK); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLSAIDIVQ_MASK);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLI2SDIVQ_SHIFT))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLI2SDIVQ_SHIFT = `enum RCC_DCKCFGR_PLLI2SDIVQ_SHIFT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLI2SDIVQ_SHIFT); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLI2SDIVQ_SHIFT);
        }
    }




    static if(!is(typeof(RCC_DCKCFGR_PLLI2SDIVQ_MASK))) {
        private enum enumMixinStr_RCC_DCKCFGR_PLLI2SDIVQ_MASK = `enum RCC_DCKCFGR_PLLI2SDIVQ_MASK = 0x1f;`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_DCKCFGR_PLLI2SDIVQ_MASK); }))) {
            mixin(enumMixinStr_RCC_DCKCFGR_PLLI2SDIVQ_MASK);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_EVTCL_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_EVTCL_CKEN = `enum RCC_CKGATENR_EVTCL_CKEN = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_EVTCL_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_EVTCL_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_RCC_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_RCC_CKEN = `enum RCC_CKGATENR_RCC_CKEN = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_RCC_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_RCC_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_FLITF_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_FLITF_CKEN = `enum RCC_CKGATENR_FLITF_CKEN = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_FLITF_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_FLITF_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_SRAM_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_SRAM_CKEN = `enum RCC_CKGATENR_SRAM_CKEN = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_SRAM_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_SRAM_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_SPARE_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_SPARE_CKEN = `enum RCC_CKGATENR_SPARE_CKEN = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_SPARE_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_SPARE_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_CM4DBG_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_CM4DBG_CKEN = `enum RCC_CKGATENR_CM4DBG_CKEN = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_CM4DBG_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_CM4DBG_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_AHB2APB2_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_AHB2APB2_CKEN = `enum RCC_CKGATENR_AHB2APB2_CKEN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_AHB2APB2_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_AHB2APB2_CKEN);
        }
    }




    static if(!is(typeof(RCC_CKGATENR_AHB2APB1_CKEN))) {
        private enum enumMixinStr_RCC_CKGATENR_AHB2APB1_CKEN = `enum RCC_CKGATENR_AHB2APB1_CKEN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RCC_CKGATENR_AHB2APB1_CKEN); }))) {
            mixin(enumMixinStr_RCC_CKGATENR_AHB2APB1_CKEN);
        }
    }




    static if(!is(typeof(SPI2))) {
        private enum enumMixinStr_SPI2 = `enum SPI2 = ( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI2); }))) {
            mixin(enumMixinStr_SPI2);
        }
    }




    static if(!is(typeof(SPI1))) {
        private enum enumMixinStr_SPI1 = `enum SPI1 = ( ( ( 0x40000000U ) + 0x10000 ) + 0x3000 );`;
        static if(is(typeof({ mixin(enumMixinStr_SPI1); }))) {
            mixin(enumMixinStr_SPI1);
        }
    }
    static if(!is(typeof(PWR_CSR_WUF))) {
        private enum enumMixinStr_PWR_CSR_WUF = `enum PWR_CSR_WUF = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_WUF); }))) {
            mixin(enumMixinStr_PWR_CSR_WUF);
        }
    }




    static if(!is(typeof(PWR_CSR_SBF))) {
        private enum enumMixinStr_PWR_CSR_SBF = `enum PWR_CSR_SBF = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_SBF); }))) {
            mixin(enumMixinStr_PWR_CSR_SBF);
        }
    }




    static if(!is(typeof(PWR_CSR_PVDO))) {
        private enum enumMixinStr_PWR_CSR_PVDO = `enum PWR_CSR_PVDO = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_PVDO); }))) {
            mixin(enumMixinStr_PWR_CSR_PVDO);
        }
    }




    static if(!is(typeof(PWR_CSR_EWUP))) {
        private enum enumMixinStr_PWR_CSR_EWUP = `enum PWR_CSR_EWUP = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR_EWUP); }))) {
            mixin(enumMixinStr_PWR_CSR_EWUP);
        }
    }




    static if(!is(typeof(PWR_CR_LPDS))) {
        private enum enumMixinStr_PWR_CR_LPDS = `enum PWR_CR_LPDS = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_LPDS); }))) {
            mixin(enumMixinStr_PWR_CR_LPDS);
        }
    }




    static if(!is(typeof(PWR_CR_PDDS))) {
        private enum enumMixinStr_PWR_CR_PDDS = `enum PWR_CR_PDDS = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PDDS); }))) {
            mixin(enumMixinStr_PWR_CR_PDDS);
        }
    }




    static if(!is(typeof(PWR_CR_CWUF))) {
        private enum enumMixinStr_PWR_CR_CWUF = `enum PWR_CR_CWUF = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_CWUF); }))) {
            mixin(enumMixinStr_PWR_CR_CWUF);
        }
    }




    static if(!is(typeof(_REG_BIT))) {
        private enum enumMixinStr__REG_BIT = `enum _REG_BIT = ( base , bit ) ( ( ( base ) << 5 ) + ( bit ) );`;
        static if(is(typeof({ mixin(enumMixinStr__REG_BIT); }))) {
            mixin(enumMixinStr__REG_BIT);
        }
    }




    static if(!is(typeof(PWR_CR_CSBF))) {
        private enum enumMixinStr_PWR_CR_CSBF = `enum PWR_CR_CSBF = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_CSBF); }))) {
            mixin(enumMixinStr_PWR_CR_CSBF);
        }
    }




    static if(!is(typeof(PWR_CR_PVDE))) {
        private enum enumMixinStr_PWR_CR_PVDE = `enum PWR_CR_PVDE = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PVDE); }))) {
            mixin(enumMixinStr_PWR_CR_PVDE);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_MASK))) {
        private enum enumMixinStr_PWR_CR_PLS_MASK = `enum PWR_CR_PLS_MASK = ( 0x7 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_MASK); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_MASK);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V9))) {
        private enum enumMixinStr_PWR_CR_PLS_2V9 = `enum PWR_CR_PLS_2V9 = ( 0x7 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V9); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V9);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V8))) {
        private enum enumMixinStr_PWR_CR_PLS_2V8 = `enum PWR_CR_PLS_2V8 = ( 0x6 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V8); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V8);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V7))) {
        private enum enumMixinStr_PWR_CR_PLS_2V7 = `enum PWR_CR_PLS_2V7 = ( 0x5 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V7); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V7);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V6))) {
        private enum enumMixinStr_PWR_CR_PLS_2V6 = `enum PWR_CR_PLS_2V6 = ( 0x4 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V6); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V6);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V5))) {
        private enum enumMixinStr_PWR_CR_PLS_2V5 = `enum PWR_CR_PLS_2V5 = ( 0x3 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V5); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V5);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V4))) {
        private enum enumMixinStr_PWR_CR_PLS_2V4 = `enum PWR_CR_PLS_2V4 = ( 0x2 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V4); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V4);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V3))) {
        private enum enumMixinStr_PWR_CR_PLS_2V3 = `enum PWR_CR_PLS_2V3 = ( 0x1 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V3); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V3);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_2V2))) {
        private enum enumMixinStr_PWR_CR_PLS_2V2 = `enum PWR_CR_PLS_2V2 = ( 0x0 << PWR_CR_PLS_LSB );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_2V2); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_2V2);
        }
    }




    static if(!is(typeof(PWR_CR_PLS_LSB))) {
        private enum enumMixinStr_PWR_CR_PLS_LSB = `enum PWR_CR_PLS_LSB = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_PLS_LSB); }))) {
            mixin(enumMixinStr_PWR_CR_PLS_LSB);
        }
    }




    static if(!is(typeof(PWR_CR_DBP))) {
        private enum enumMixinStr_PWR_CR_DBP = `enum PWR_CR_DBP = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR_DBP); }))) {
            mixin(enumMixinStr_PWR_CR_DBP);
        }
    }




    static if(!is(typeof(PWR_CSR))) {
        private enum enumMixinStr_PWR_CSR = `enum PWR_CSR = MMIO32 ( ( ( ( 0x40000000U ) + 0x00000 ) + 0x7000 ) + 0x04 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CSR); }))) {
            mixin(enumMixinStr_PWR_CSR);
        }
    }




    static if(!is(typeof(PWR_CR))) {
        private enum enumMixinStr_PWR_CR = `enum PWR_CR = MMIO32 ( ( ( ( 0x40000000U ) + 0x00000 ) + 0x7000 ) + 0x00 );`;
        static if(is(typeof({ mixin(enumMixinStr_PWR_CR); }))) {
            mixin(enumMixinStr_PWR_CR);
        }
    }






    static if(!is(typeof(GPIOK_AFRH))) {
        private enum enumMixinStr_GPIOK_AFRH = `enum GPIOK_AFRH = GPIO_AFRH ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_AFRH); }))) {
            mixin(enumMixinStr_GPIOK_AFRH);
        }
    }




    static if(!is(typeof(GPIOJ_AFRH))) {
        private enum enumMixinStr_GPIOJ_AFRH = `enum GPIOJ_AFRH = GPIO_AFRH ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_AFRH); }))) {
            mixin(enumMixinStr_GPIOJ_AFRH);
        }
    }




    static if(!is(typeof(GPIOI_AFRH))) {
        private enum enumMixinStr_GPIOI_AFRH = `enum GPIOI_AFRH = GPIO_AFRH ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_AFRH); }))) {
            mixin(enumMixinStr_GPIOI_AFRH);
        }
    }




    static if(!is(typeof(GPIOK_AFRL))) {
        private enum enumMixinStr_GPIOK_AFRL = `enum GPIOK_AFRL = GPIO_AFRL ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_AFRL); }))) {
            mixin(enumMixinStr_GPIOK_AFRL);
        }
    }




    static if(!is(typeof(GPIOJ_AFRL))) {
        private enum enumMixinStr_GPIOJ_AFRL = `enum GPIOJ_AFRL = GPIO_AFRL ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_AFRL); }))) {
            mixin(enumMixinStr_GPIOJ_AFRL);
        }
    }




    static if(!is(typeof(GPIOI_AFRL))) {
        private enum enumMixinStr_GPIOI_AFRL = `enum GPIOI_AFRL = GPIO_AFRL ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_AFRL); }))) {
            mixin(enumMixinStr_GPIOI_AFRL);
        }
    }




    static if(!is(typeof(GPIOK_LCKR))) {
        private enum enumMixinStr_GPIOK_LCKR = `enum GPIOK_LCKR = GPIO_LCKR ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_LCKR); }))) {
            mixin(enumMixinStr_GPIOK_LCKR);
        }
    }




    static if(!is(typeof(GPIOJ_LCKR))) {
        private enum enumMixinStr_GPIOJ_LCKR = `enum GPIOJ_LCKR = GPIO_LCKR ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_LCKR); }))) {
            mixin(enumMixinStr_GPIOJ_LCKR);
        }
    }




    static if(!is(typeof(GPIOI_LCKR))) {
        private enum enumMixinStr_GPIOI_LCKR = `enum GPIOI_LCKR = GPIO_LCKR ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_LCKR); }))) {
            mixin(enumMixinStr_GPIOI_LCKR);
        }
    }




    static if(!is(typeof(GPIOK_BSRR))) {
        private enum enumMixinStr_GPIOK_BSRR = `enum GPIOK_BSRR = GPIO_BSRR ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_BSRR); }))) {
            mixin(enumMixinStr_GPIOK_BSRR);
        }
    }




    static if(!is(typeof(GPIOJ_BSRR))) {
        private enum enumMixinStr_GPIOJ_BSRR = `enum GPIOJ_BSRR = GPIO_BSRR ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_BSRR); }))) {
            mixin(enumMixinStr_GPIOJ_BSRR);
        }
    }




    static if(!is(typeof(GPIOI_BSRR))) {
        private enum enumMixinStr_GPIOI_BSRR = `enum GPIOI_BSRR = GPIO_BSRR ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_BSRR); }))) {
            mixin(enumMixinStr_GPIOI_BSRR);
        }
    }




    static if(!is(typeof(GPIOK_ODR))) {
        private enum enumMixinStr_GPIOK_ODR = `enum GPIOK_ODR = GPIO_ODR ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_ODR); }))) {
            mixin(enumMixinStr_GPIOK_ODR);
        }
    }




    static if(!is(typeof(GPIOJ_ODR))) {
        private enum enumMixinStr_GPIOJ_ODR = `enum GPIOJ_ODR = GPIO_ODR ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_ODR); }))) {
            mixin(enumMixinStr_GPIOJ_ODR);
        }
    }




    static if(!is(typeof(GPIOI_ODR))) {
        private enum enumMixinStr_GPIOI_ODR = `enum GPIOI_ODR = GPIO_ODR ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_ODR); }))) {
            mixin(enumMixinStr_GPIOI_ODR);
        }
    }




    static if(!is(typeof(GPIOK_IDR))) {
        private enum enumMixinStr_GPIOK_IDR = `enum GPIOK_IDR = GPIO_IDR ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_IDR); }))) {
            mixin(enumMixinStr_GPIOK_IDR);
        }
    }




    static if(!is(typeof(GPIOJ_IDR))) {
        private enum enumMixinStr_GPIOJ_IDR = `enum GPIOJ_IDR = GPIO_IDR ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_IDR); }))) {
            mixin(enumMixinStr_GPIOJ_IDR);
        }
    }




    static if(!is(typeof(GPIOI_IDR))) {
        private enum enumMixinStr_GPIOI_IDR = `enum GPIOI_IDR = GPIO_IDR ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_IDR); }))) {
            mixin(enumMixinStr_GPIOI_IDR);
        }
    }




    static if(!is(typeof(GPIOK_PUPDR))) {
        private enum enumMixinStr_GPIOK_PUPDR = `enum GPIOK_PUPDR = GPIO_PUPDR ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_PUPDR); }))) {
            mixin(enumMixinStr_GPIOK_PUPDR);
        }
    }




    static if(!is(typeof(GPIOJ_PUPDR))) {
        private enum enumMixinStr_GPIOJ_PUPDR = `enum GPIOJ_PUPDR = GPIO_PUPDR ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_PUPDR); }))) {
            mixin(enumMixinStr_GPIOJ_PUPDR);
        }
    }




    static if(!is(typeof(GPIOI_PUPDR))) {
        private enum enumMixinStr_GPIOI_PUPDR = `enum GPIOI_PUPDR = GPIO_PUPDR ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_PUPDR); }))) {
            mixin(enumMixinStr_GPIOI_PUPDR);
        }
    }




    static if(!is(typeof(GPIOK_OSPEEDR))) {
        private enum enumMixinStr_GPIOK_OSPEEDR = `enum GPIOK_OSPEEDR = GPIO_OSPEEDR ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOK_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOJ_OSPEEDR))) {
        private enum enumMixinStr_GPIOJ_OSPEEDR = `enum GPIOJ_OSPEEDR = GPIO_OSPEEDR ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOJ_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOI_OSPEEDR))) {
        private enum enumMixinStr_GPIOI_OSPEEDR = `enum GPIOI_OSPEEDR = GPIO_OSPEEDR ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOI_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOK_OTYPER))) {
        private enum enumMixinStr_GPIOK_OTYPER = `enum GPIOK_OTYPER = GPIO_OTYPER ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_OTYPER); }))) {
            mixin(enumMixinStr_GPIOK_OTYPER);
        }
    }




    static if(!is(typeof(GPIOJ_OTYPER))) {
        private enum enumMixinStr_GPIOJ_OTYPER = `enum GPIOJ_OTYPER = GPIO_OTYPER ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_OTYPER); }))) {
            mixin(enumMixinStr_GPIOJ_OTYPER);
        }
    }




    static if(!is(typeof(GPIOI_OTYPER))) {
        private enum enumMixinStr_GPIOI_OTYPER = `enum GPIOI_OTYPER = GPIO_OTYPER ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_OTYPER); }))) {
            mixin(enumMixinStr_GPIOI_OTYPER);
        }
    }




    static if(!is(typeof(GPIOK_MODER))) {
        private enum enumMixinStr_GPIOK_MODER = `enum GPIOK_MODER = GPIO_MODER ( GPIOK );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK_MODER); }))) {
            mixin(enumMixinStr_GPIOK_MODER);
        }
    }




    static if(!is(typeof(GPIOJ_MODER))) {
        private enum enumMixinStr_GPIOJ_MODER = `enum GPIOJ_MODER = GPIO_MODER ( GPIOJ );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ_MODER); }))) {
            mixin(enumMixinStr_GPIOJ_MODER);
        }
    }




    static if(!is(typeof(GPIOI_MODER))) {
        private enum enumMixinStr_GPIOI_MODER = `enum GPIOI_MODER = GPIO_MODER ( GPIOI );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI_MODER); }))) {
            mixin(enumMixinStr_GPIOI_MODER);
        }
    }




    static if(!is(typeof(GPIOK))) {
        private enum enumMixinStr_GPIOK = `enum GPIOK = ( ( ( 0x40000000U ) + 0x20000 ) + 0x2800 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOK); }))) {
            mixin(enumMixinStr_GPIOK);
        }
    }




    static if(!is(typeof(GPIOJ))) {
        private enum enumMixinStr_GPIOJ = `enum GPIOJ = ( ( ( 0x40000000U ) + 0x20000 ) + 0x2400 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOJ); }))) {
            mixin(enumMixinStr_GPIOJ);
        }
    }




    static if(!is(typeof(GPIOI))) {
        private enum enumMixinStr_GPIOI = `enum GPIOI = ( ( ( 0x40000000U ) + 0x20000 ) + 0x2000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOI); }))) {
            mixin(enumMixinStr_GPIOI);
        }
    }






    static if(!is(typeof(GPIO_AF15))) {
        private enum enumMixinStr_GPIO_AF15 = `enum GPIO_AF15 = 0xf;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF15); }))) {
            mixin(enumMixinStr_GPIO_AF15);
        }
    }




    static if(!is(typeof(GPIO_AF14))) {
        private enum enumMixinStr_GPIO_AF14 = `enum GPIO_AF14 = 0xe;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF14); }))) {
            mixin(enumMixinStr_GPIO_AF14);
        }
    }




    static if(!is(typeof(GPIO_AF13))) {
        private enum enumMixinStr_GPIO_AF13 = `enum GPIO_AF13 = 0xd;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF13); }))) {
            mixin(enumMixinStr_GPIO_AF13);
        }
    }




    static if(!is(typeof(GPIO_AF12))) {
        private enum enumMixinStr_GPIO_AF12 = `enum GPIO_AF12 = 0xc;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF12); }))) {
            mixin(enumMixinStr_GPIO_AF12);
        }
    }




    static if(!is(typeof(GPIO_AF11))) {
        private enum enumMixinStr_GPIO_AF11 = `enum GPIO_AF11 = 0xb;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF11); }))) {
            mixin(enumMixinStr_GPIO_AF11);
        }
    }




    static if(!is(typeof(GPIO_AF10))) {
        private enum enumMixinStr_GPIO_AF10 = `enum GPIO_AF10 = 0xa;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF10); }))) {
            mixin(enumMixinStr_GPIO_AF10);
        }
    }




    static if(!is(typeof(GPIO_AF9))) {
        private enum enumMixinStr_GPIO_AF9 = `enum GPIO_AF9 = 0x9;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF9); }))) {
            mixin(enumMixinStr_GPIO_AF9);
        }
    }




    static if(!is(typeof(GPIO_AF8))) {
        private enum enumMixinStr_GPIO_AF8 = `enum GPIO_AF8 = 0x8;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF8); }))) {
            mixin(enumMixinStr_GPIO_AF8);
        }
    }




    static if(!is(typeof(GPIO_AF7))) {
        private enum enumMixinStr_GPIO_AF7 = `enum GPIO_AF7 = 0x7;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF7); }))) {
            mixin(enumMixinStr_GPIO_AF7);
        }
    }




    static if(!is(typeof(GPIO_AF6))) {
        private enum enumMixinStr_GPIO_AF6 = `enum GPIO_AF6 = 0x6;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF6); }))) {
            mixin(enumMixinStr_GPIO_AF6);
        }
    }




    static if(!is(typeof(GPIO_AF5))) {
        private enum enumMixinStr_GPIO_AF5 = `enum GPIO_AF5 = 0x5;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF5); }))) {
            mixin(enumMixinStr_GPIO_AF5);
        }
    }




    static if(!is(typeof(GPIO_AF4))) {
        private enum enumMixinStr_GPIO_AF4 = `enum GPIO_AF4 = 0x4;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF4); }))) {
            mixin(enumMixinStr_GPIO_AF4);
        }
    }




    static if(!is(typeof(GPIO_AF3))) {
        private enum enumMixinStr_GPIO_AF3 = `enum GPIO_AF3 = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF3); }))) {
            mixin(enumMixinStr_GPIO_AF3);
        }
    }




    static if(!is(typeof(GPIO_AF2))) {
        private enum enumMixinStr_GPIO_AF2 = `enum GPIO_AF2 = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF2); }))) {
            mixin(enumMixinStr_GPIO_AF2);
        }
    }




    static if(!is(typeof(GPIO_AF1))) {
        private enum enumMixinStr_GPIO_AF1 = `enum GPIO_AF1 = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF1); }))) {
            mixin(enumMixinStr_GPIO_AF1);
        }
    }




    static if(!is(typeof(GPIO_AF0))) {
        private enum enumMixinStr_GPIO_AF0 = `enum GPIO_AF0 = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_AF0); }))) {
            mixin(enumMixinStr_GPIO_AF0);
        }
    }
    static if(!is(typeof(GPIO_LCKK))) {
        private enum enumMixinStr_GPIO_LCKK = `enum GPIO_LCKK = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_LCKK); }))) {
            mixin(enumMixinStr_GPIO_LCKK);
        }
    }




    static if(!is(typeof(GPIO_PUPD_PULLDOWN))) {
        private enum enumMixinStr_GPIO_PUPD_PULLDOWN = `enum GPIO_PUPD_PULLDOWN = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PUPD_PULLDOWN); }))) {
            mixin(enumMixinStr_GPIO_PUPD_PULLDOWN);
        }
    }




    static if(!is(typeof(GPIO_PUPD_PULLUP))) {
        private enum enumMixinStr_GPIO_PUPD_PULLUP = `enum GPIO_PUPD_PULLUP = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PUPD_PULLUP); }))) {
            mixin(enumMixinStr_GPIO_PUPD_PULLUP);
        }
    }




    static if(!is(typeof(GPIO_PUPD_NONE))) {
        private enum enumMixinStr_GPIO_PUPD_NONE = `enum GPIO_PUPD_NONE = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_PUPD_NONE); }))) {
            mixin(enumMixinStr_GPIO_PUPD_NONE);
        }
    }
    static if(!is(typeof(GPIO_OSPEED_100MHZ))) {
        private enum enumMixinStr_GPIO_OSPEED_100MHZ = `enum GPIO_OSPEED_100MHZ = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_OSPEED_100MHZ); }))) {
            mixin(enumMixinStr_GPIO_OSPEED_100MHZ);
        }
    }




    static if(!is(typeof(GPIO_OSPEED_50MHZ))) {
        private enum enumMixinStr_GPIO_OSPEED_50MHZ = `enum GPIO_OSPEED_50MHZ = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_OSPEED_50MHZ); }))) {
            mixin(enumMixinStr_GPIO_OSPEED_50MHZ);
        }
    }




    static if(!is(typeof(GPIO_OSPEED_25MHZ))) {
        private enum enumMixinStr_GPIO_OSPEED_25MHZ = `enum GPIO_OSPEED_25MHZ = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_OSPEED_25MHZ); }))) {
            mixin(enumMixinStr_GPIO_OSPEED_25MHZ);
        }
    }




    static if(!is(typeof(GPIO_OSPEED_2MHZ))) {
        private enum enumMixinStr_GPIO_OSPEED_2MHZ = `enum GPIO_OSPEED_2MHZ = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_OSPEED_2MHZ); }))) {
            mixin(enumMixinStr_GPIO_OSPEED_2MHZ);
        }
    }
    static if(!is(typeof(GPIO_OTYPE_OD))) {
        private enum enumMixinStr_GPIO_OTYPE_OD = `enum GPIO_OTYPE_OD = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_OTYPE_OD); }))) {
            mixin(enumMixinStr_GPIO_OTYPE_OD);
        }
    }




    static if(!is(typeof(GPIO_OTYPE_PP))) {
        private enum enumMixinStr_GPIO_OTYPE_PP = `enum GPIO_OTYPE_PP = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_OTYPE_PP); }))) {
            mixin(enumMixinStr_GPIO_OTYPE_PP);
        }
    }




    static if(!is(typeof(GPIO_MODE_ANALOG))) {
        private enum enumMixinStr_GPIO_MODE_ANALOG = `enum GPIO_MODE_ANALOG = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_MODE_ANALOG); }))) {
            mixin(enumMixinStr_GPIO_MODE_ANALOG);
        }
    }




    static if(!is(typeof(GPIO_MODE_AF))) {
        private enum enumMixinStr_GPIO_MODE_AF = `enum GPIO_MODE_AF = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_MODE_AF); }))) {
            mixin(enumMixinStr_GPIO_MODE_AF);
        }
    }




    static if(!is(typeof(GPIO_MODE_OUTPUT))) {
        private enum enumMixinStr_GPIO_MODE_OUTPUT = `enum GPIO_MODE_OUTPUT = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_MODE_OUTPUT); }))) {
            mixin(enumMixinStr_GPIO_MODE_OUTPUT);
        }
    }




    static if(!is(typeof(GPIO_MODE_INPUT))) {
        private enum enumMixinStr_GPIO_MODE_INPUT = `enum GPIO_MODE_INPUT = 0x0;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_MODE_INPUT); }))) {
            mixin(enumMixinStr_GPIO_MODE_INPUT);
        }
    }
    static if(!is(typeof(GPIOH_AFRH))) {
        private enum enumMixinStr_GPIOH_AFRH = `enum GPIOH_AFRH = GPIO_AFRH ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_AFRH); }))) {
            mixin(enumMixinStr_GPIOH_AFRH);
        }
    }




    static if(!is(typeof(GPIOG_AFRH))) {
        private enum enumMixinStr_GPIOG_AFRH = `enum GPIOG_AFRH = GPIO_AFRH ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_AFRH); }))) {
            mixin(enumMixinStr_GPIOG_AFRH);
        }
    }




    static if(!is(typeof(GPIOF_AFRH))) {
        private enum enumMixinStr_GPIOF_AFRH = `enum GPIOF_AFRH = GPIO_AFRH ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_AFRH); }))) {
            mixin(enumMixinStr_GPIOF_AFRH);
        }
    }




    static if(!is(typeof(GPIOE_AFRH))) {
        private enum enumMixinStr_GPIOE_AFRH = `enum GPIOE_AFRH = GPIO_AFRH ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_AFRH); }))) {
            mixin(enumMixinStr_GPIOE_AFRH);
        }
    }




    static if(!is(typeof(GPIOD_AFRH))) {
        private enum enumMixinStr_GPIOD_AFRH = `enum GPIOD_AFRH = GPIO_AFRH ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_AFRH); }))) {
            mixin(enumMixinStr_GPIOD_AFRH);
        }
    }




    static if(!is(typeof(GPIOC_AFRH))) {
        private enum enumMixinStr_GPIOC_AFRH = `enum GPIOC_AFRH = GPIO_AFRH ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_AFRH); }))) {
            mixin(enumMixinStr_GPIOC_AFRH);
        }
    }




    static if(!is(typeof(GPIOB_AFRH))) {
        private enum enumMixinStr_GPIOB_AFRH = `enum GPIOB_AFRH = GPIO_AFRH ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_AFRH); }))) {
            mixin(enumMixinStr_GPIOB_AFRH);
        }
    }




    static if(!is(typeof(GPIOA_AFRH))) {
        private enum enumMixinStr_GPIOA_AFRH = `enum GPIOA_AFRH = GPIO_AFRH ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_AFRH); }))) {
            mixin(enumMixinStr_GPIOA_AFRH);
        }
    }






    static if(!is(typeof(GPIOH_AFRL))) {
        private enum enumMixinStr_GPIOH_AFRL = `enum GPIOH_AFRL = GPIO_AFRL ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_AFRL); }))) {
            mixin(enumMixinStr_GPIOH_AFRL);
        }
    }




    static if(!is(typeof(GPIOG_AFRL))) {
        private enum enumMixinStr_GPIOG_AFRL = `enum GPIOG_AFRL = GPIO_AFRL ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_AFRL); }))) {
            mixin(enumMixinStr_GPIOG_AFRL);
        }
    }




    static if(!is(typeof(GPIOF_AFRL))) {
        private enum enumMixinStr_GPIOF_AFRL = `enum GPIOF_AFRL = GPIO_AFRL ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_AFRL); }))) {
            mixin(enumMixinStr_GPIOF_AFRL);
        }
    }




    static if(!is(typeof(GPIOE_AFRL))) {
        private enum enumMixinStr_GPIOE_AFRL = `enum GPIOE_AFRL = GPIO_AFRL ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_AFRL); }))) {
            mixin(enumMixinStr_GPIOE_AFRL);
        }
    }




    static if(!is(typeof(GPIOD_AFRL))) {
        private enum enumMixinStr_GPIOD_AFRL = `enum GPIOD_AFRL = GPIO_AFRL ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_AFRL); }))) {
            mixin(enumMixinStr_GPIOD_AFRL);
        }
    }




    static if(!is(typeof(GPIOC_AFRL))) {
        private enum enumMixinStr_GPIOC_AFRL = `enum GPIOC_AFRL = GPIO_AFRL ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_AFRL); }))) {
            mixin(enumMixinStr_GPIOC_AFRL);
        }
    }




    static if(!is(typeof(GPIOB_AFRL))) {
        private enum enumMixinStr_GPIOB_AFRL = `enum GPIOB_AFRL = GPIO_AFRL ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_AFRL); }))) {
            mixin(enumMixinStr_GPIOB_AFRL);
        }
    }




    static if(!is(typeof(GPIOA_AFRL))) {
        private enum enumMixinStr_GPIOA_AFRL = `enum GPIOA_AFRL = GPIO_AFRL ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_AFRL); }))) {
            mixin(enumMixinStr_GPIOA_AFRL);
        }
    }






    static if(!is(typeof(GPIOH_LCKR))) {
        private enum enumMixinStr_GPIOH_LCKR = `enum GPIOH_LCKR = GPIO_LCKR ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_LCKR); }))) {
            mixin(enumMixinStr_GPIOH_LCKR);
        }
    }




    static if(!is(typeof(GPIOG_LCKR))) {
        private enum enumMixinStr_GPIOG_LCKR = `enum GPIOG_LCKR = GPIO_LCKR ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_LCKR); }))) {
            mixin(enumMixinStr_GPIOG_LCKR);
        }
    }




    static if(!is(typeof(GPIOF_LCKR))) {
        private enum enumMixinStr_GPIOF_LCKR = `enum GPIOF_LCKR = GPIO_LCKR ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_LCKR); }))) {
            mixin(enumMixinStr_GPIOF_LCKR);
        }
    }




    static if(!is(typeof(GPIOE_LCKR))) {
        private enum enumMixinStr_GPIOE_LCKR = `enum GPIOE_LCKR = GPIO_LCKR ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_LCKR); }))) {
            mixin(enumMixinStr_GPIOE_LCKR);
        }
    }




    static if(!is(typeof(GPIOD_LCKR))) {
        private enum enumMixinStr_GPIOD_LCKR = `enum GPIOD_LCKR = GPIO_LCKR ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_LCKR); }))) {
            mixin(enumMixinStr_GPIOD_LCKR);
        }
    }




    static if(!is(typeof(GPIOC_LCKR))) {
        private enum enumMixinStr_GPIOC_LCKR = `enum GPIOC_LCKR = GPIO_LCKR ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_LCKR); }))) {
            mixin(enumMixinStr_GPIOC_LCKR);
        }
    }




    static if(!is(typeof(GPIOB_LCKR))) {
        private enum enumMixinStr_GPIOB_LCKR = `enum GPIOB_LCKR = GPIO_LCKR ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_LCKR); }))) {
            mixin(enumMixinStr_GPIOB_LCKR);
        }
    }




    static if(!is(typeof(GPIOA_LCKR))) {
        private enum enumMixinStr_GPIOA_LCKR = `enum GPIOA_LCKR = GPIO_LCKR ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_LCKR); }))) {
            mixin(enumMixinStr_GPIOA_LCKR);
        }
    }






    static if(!is(typeof(GPIOH_BSRR))) {
        private enum enumMixinStr_GPIOH_BSRR = `enum GPIOH_BSRR = GPIO_BSRR ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_BSRR); }))) {
            mixin(enumMixinStr_GPIOH_BSRR);
        }
    }




    static if(!is(typeof(GPIOG_BSRR))) {
        private enum enumMixinStr_GPIOG_BSRR = `enum GPIOG_BSRR = GPIO_BSRR ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_BSRR); }))) {
            mixin(enumMixinStr_GPIOG_BSRR);
        }
    }




    static if(!is(typeof(GPIOF_BSRR))) {
        private enum enumMixinStr_GPIOF_BSRR = `enum GPIOF_BSRR = GPIO_BSRR ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_BSRR); }))) {
            mixin(enumMixinStr_GPIOF_BSRR);
        }
    }




    static if(!is(typeof(GPIOE_BSRR))) {
        private enum enumMixinStr_GPIOE_BSRR = `enum GPIOE_BSRR = GPIO_BSRR ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_BSRR); }))) {
            mixin(enumMixinStr_GPIOE_BSRR);
        }
    }




    static if(!is(typeof(GPIOD_BSRR))) {
        private enum enumMixinStr_GPIOD_BSRR = `enum GPIOD_BSRR = GPIO_BSRR ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_BSRR); }))) {
            mixin(enumMixinStr_GPIOD_BSRR);
        }
    }




    static if(!is(typeof(GPIOC_BSRR))) {
        private enum enumMixinStr_GPIOC_BSRR = `enum GPIOC_BSRR = GPIO_BSRR ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_BSRR); }))) {
            mixin(enumMixinStr_GPIOC_BSRR);
        }
    }




    static if(!is(typeof(GPIOB_BSRR))) {
        private enum enumMixinStr_GPIOB_BSRR = `enum GPIOB_BSRR = GPIO_BSRR ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_BSRR); }))) {
            mixin(enumMixinStr_GPIOB_BSRR);
        }
    }




    static if(!is(typeof(GPIOA_BSRR))) {
        private enum enumMixinStr_GPIOA_BSRR = `enum GPIOA_BSRR = GPIO_BSRR ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_BSRR); }))) {
            mixin(enumMixinStr_GPIOA_BSRR);
        }
    }






    static if(!is(typeof(GPIOH_ODR))) {
        private enum enumMixinStr_GPIOH_ODR = `enum GPIOH_ODR = GPIO_ODR ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_ODR); }))) {
            mixin(enumMixinStr_GPIOH_ODR);
        }
    }




    static if(!is(typeof(GPIOG_ODR))) {
        private enum enumMixinStr_GPIOG_ODR = `enum GPIOG_ODR = GPIO_ODR ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_ODR); }))) {
            mixin(enumMixinStr_GPIOG_ODR);
        }
    }




    static if(!is(typeof(GPIOF_ODR))) {
        private enum enumMixinStr_GPIOF_ODR = `enum GPIOF_ODR = GPIO_ODR ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_ODR); }))) {
            mixin(enumMixinStr_GPIOF_ODR);
        }
    }




    static if(!is(typeof(GPIOE_ODR))) {
        private enum enumMixinStr_GPIOE_ODR = `enum GPIOE_ODR = GPIO_ODR ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_ODR); }))) {
            mixin(enumMixinStr_GPIOE_ODR);
        }
    }




    static if(!is(typeof(GPIOD_ODR))) {
        private enum enumMixinStr_GPIOD_ODR = `enum GPIOD_ODR = GPIO_ODR ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_ODR); }))) {
            mixin(enumMixinStr_GPIOD_ODR);
        }
    }




    static if(!is(typeof(GPIOC_ODR))) {
        private enum enumMixinStr_GPIOC_ODR = `enum GPIOC_ODR = GPIO_ODR ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_ODR); }))) {
            mixin(enumMixinStr_GPIOC_ODR);
        }
    }




    static if(!is(typeof(GPIOB_ODR))) {
        private enum enumMixinStr_GPIOB_ODR = `enum GPIOB_ODR = GPIO_ODR ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_ODR); }))) {
            mixin(enumMixinStr_GPIOB_ODR);
        }
    }




    static if(!is(typeof(GPIOA_ODR))) {
        private enum enumMixinStr_GPIOA_ODR = `enum GPIOA_ODR = GPIO_ODR ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_ODR); }))) {
            mixin(enumMixinStr_GPIOA_ODR);
        }
    }






    static if(!is(typeof(GPIOH_IDR))) {
        private enum enumMixinStr_GPIOH_IDR = `enum GPIOH_IDR = GPIO_IDR ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_IDR); }))) {
            mixin(enumMixinStr_GPIOH_IDR);
        }
    }




    static if(!is(typeof(GPIOG_IDR))) {
        private enum enumMixinStr_GPIOG_IDR = `enum GPIOG_IDR = GPIO_IDR ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_IDR); }))) {
            mixin(enumMixinStr_GPIOG_IDR);
        }
    }




    static if(!is(typeof(GPIOF_IDR))) {
        private enum enumMixinStr_GPIOF_IDR = `enum GPIOF_IDR = GPIO_IDR ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_IDR); }))) {
            mixin(enumMixinStr_GPIOF_IDR);
        }
    }




    static if(!is(typeof(GPIOE_IDR))) {
        private enum enumMixinStr_GPIOE_IDR = `enum GPIOE_IDR = GPIO_IDR ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_IDR); }))) {
            mixin(enumMixinStr_GPIOE_IDR);
        }
    }




    static if(!is(typeof(GPIOD_IDR))) {
        private enum enumMixinStr_GPIOD_IDR = `enum GPIOD_IDR = GPIO_IDR ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_IDR); }))) {
            mixin(enumMixinStr_GPIOD_IDR);
        }
    }




    static if(!is(typeof(GPIOC_IDR))) {
        private enum enumMixinStr_GPIOC_IDR = `enum GPIOC_IDR = GPIO_IDR ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_IDR); }))) {
            mixin(enumMixinStr_GPIOC_IDR);
        }
    }




    static if(!is(typeof(GPIOB_IDR))) {
        private enum enumMixinStr_GPIOB_IDR = `enum GPIOB_IDR = GPIO_IDR ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_IDR); }))) {
            mixin(enumMixinStr_GPIOB_IDR);
        }
    }




    static if(!is(typeof(GPIOA_IDR))) {
        private enum enumMixinStr_GPIOA_IDR = `enum GPIOA_IDR = GPIO_IDR ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_IDR); }))) {
            mixin(enumMixinStr_GPIOA_IDR);
        }
    }






    static if(!is(typeof(GPIOH_PUPDR))) {
        private enum enumMixinStr_GPIOH_PUPDR = `enum GPIOH_PUPDR = GPIO_PUPDR ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_PUPDR); }))) {
            mixin(enumMixinStr_GPIOH_PUPDR);
        }
    }




    static if(!is(typeof(GPIOG_PUPDR))) {
        private enum enumMixinStr_GPIOG_PUPDR = `enum GPIOG_PUPDR = GPIO_PUPDR ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_PUPDR); }))) {
            mixin(enumMixinStr_GPIOG_PUPDR);
        }
    }




    static if(!is(typeof(GPIOF_PUPDR))) {
        private enum enumMixinStr_GPIOF_PUPDR = `enum GPIOF_PUPDR = GPIO_PUPDR ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_PUPDR); }))) {
            mixin(enumMixinStr_GPIOF_PUPDR);
        }
    }




    static if(!is(typeof(GPIOE_PUPDR))) {
        private enum enumMixinStr_GPIOE_PUPDR = `enum GPIOE_PUPDR = GPIO_PUPDR ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_PUPDR); }))) {
            mixin(enumMixinStr_GPIOE_PUPDR);
        }
    }




    static if(!is(typeof(GPIOD_PUPDR))) {
        private enum enumMixinStr_GPIOD_PUPDR = `enum GPIOD_PUPDR = GPIO_PUPDR ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_PUPDR); }))) {
            mixin(enumMixinStr_GPIOD_PUPDR);
        }
    }




    static if(!is(typeof(GPIOC_PUPDR))) {
        private enum enumMixinStr_GPIOC_PUPDR = `enum GPIOC_PUPDR = GPIO_PUPDR ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_PUPDR); }))) {
            mixin(enumMixinStr_GPIOC_PUPDR);
        }
    }




    static if(!is(typeof(GPIOB_PUPDR))) {
        private enum enumMixinStr_GPIOB_PUPDR = `enum GPIOB_PUPDR = GPIO_PUPDR ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_PUPDR); }))) {
            mixin(enumMixinStr_GPIOB_PUPDR);
        }
    }




    static if(!is(typeof(GPIOA_PUPDR))) {
        private enum enumMixinStr_GPIOA_PUPDR = `enum GPIOA_PUPDR = GPIO_PUPDR ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_PUPDR); }))) {
            mixin(enumMixinStr_GPIOA_PUPDR);
        }
    }






    static if(!is(typeof(GPIOH_OSPEEDR))) {
        private enum enumMixinStr_GPIOH_OSPEEDR = `enum GPIOH_OSPEEDR = GPIO_OSPEEDR ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOH_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOG_OSPEEDR))) {
        private enum enumMixinStr_GPIOG_OSPEEDR = `enum GPIOG_OSPEEDR = GPIO_OSPEEDR ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOG_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOF_OSPEEDR))) {
        private enum enumMixinStr_GPIOF_OSPEEDR = `enum GPIOF_OSPEEDR = GPIO_OSPEEDR ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOF_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOE_OSPEEDR))) {
        private enum enumMixinStr_GPIOE_OSPEEDR = `enum GPIOE_OSPEEDR = GPIO_OSPEEDR ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOE_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOD_OSPEEDR))) {
        private enum enumMixinStr_GPIOD_OSPEEDR = `enum GPIOD_OSPEEDR = GPIO_OSPEEDR ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOD_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOC_OSPEEDR))) {
        private enum enumMixinStr_GPIOC_OSPEEDR = `enum GPIOC_OSPEEDR = GPIO_OSPEEDR ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOC_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOB_OSPEEDR))) {
        private enum enumMixinStr_GPIOB_OSPEEDR = `enum GPIOB_OSPEEDR = GPIO_OSPEEDR ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOB_OSPEEDR);
        }
    }




    static if(!is(typeof(GPIOA_OSPEEDR))) {
        private enum enumMixinStr_GPIOA_OSPEEDR = `enum GPIOA_OSPEEDR = GPIO_OSPEEDR ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_OSPEEDR); }))) {
            mixin(enumMixinStr_GPIOA_OSPEEDR);
        }
    }






    static if(!is(typeof(GPIOH_OTYPER))) {
        private enum enumMixinStr_GPIOH_OTYPER = `enum GPIOH_OTYPER = GPIO_OTYPER ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_OTYPER); }))) {
            mixin(enumMixinStr_GPIOH_OTYPER);
        }
    }




    static if(!is(typeof(GPIOG_OTYPER))) {
        private enum enumMixinStr_GPIOG_OTYPER = `enum GPIOG_OTYPER = GPIO_OTYPER ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_OTYPER); }))) {
            mixin(enumMixinStr_GPIOG_OTYPER);
        }
    }




    static if(!is(typeof(GPIOF_OTYPER))) {
        private enum enumMixinStr_GPIOF_OTYPER = `enum GPIOF_OTYPER = GPIO_OTYPER ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_OTYPER); }))) {
            mixin(enumMixinStr_GPIOF_OTYPER);
        }
    }




    static if(!is(typeof(GPIOE_OTYPER))) {
        private enum enumMixinStr_GPIOE_OTYPER = `enum GPIOE_OTYPER = GPIO_OTYPER ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_OTYPER); }))) {
            mixin(enumMixinStr_GPIOE_OTYPER);
        }
    }




    static if(!is(typeof(GPIOD_OTYPER))) {
        private enum enumMixinStr_GPIOD_OTYPER = `enum GPIOD_OTYPER = GPIO_OTYPER ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_OTYPER); }))) {
            mixin(enumMixinStr_GPIOD_OTYPER);
        }
    }




    static if(!is(typeof(GPIOC_OTYPER))) {
        private enum enumMixinStr_GPIOC_OTYPER = `enum GPIOC_OTYPER = GPIO_OTYPER ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_OTYPER); }))) {
            mixin(enumMixinStr_GPIOC_OTYPER);
        }
    }




    static if(!is(typeof(GPIOB_OTYPER))) {
        private enum enumMixinStr_GPIOB_OTYPER = `enum GPIOB_OTYPER = GPIO_OTYPER ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_OTYPER); }))) {
            mixin(enumMixinStr_GPIOB_OTYPER);
        }
    }




    static if(!is(typeof(GPIOA_OTYPER))) {
        private enum enumMixinStr_GPIOA_OTYPER = `enum GPIOA_OTYPER = GPIO_OTYPER ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_OTYPER); }))) {
            mixin(enumMixinStr_GPIOA_OTYPER);
        }
    }






    static if(!is(typeof(GPIOH_MODER))) {
        private enum enumMixinStr_GPIOH_MODER = `enum GPIOH_MODER = GPIO_MODER ( GPIOH );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH_MODER); }))) {
            mixin(enumMixinStr_GPIOH_MODER);
        }
    }




    static if(!is(typeof(GPIOG_MODER))) {
        private enum enumMixinStr_GPIOG_MODER = `enum GPIOG_MODER = GPIO_MODER ( GPIOG );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG_MODER); }))) {
            mixin(enumMixinStr_GPIOG_MODER);
        }
    }




    static if(!is(typeof(GPIOF_MODER))) {
        private enum enumMixinStr_GPIOF_MODER = `enum GPIOF_MODER = GPIO_MODER ( GPIOF );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF_MODER); }))) {
            mixin(enumMixinStr_GPIOF_MODER);
        }
    }




    static if(!is(typeof(GPIOE_MODER))) {
        private enum enumMixinStr_GPIOE_MODER = `enum GPIOE_MODER = GPIO_MODER ( GPIOE );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE_MODER); }))) {
            mixin(enumMixinStr_GPIOE_MODER);
        }
    }




    static if(!is(typeof(GPIOD_MODER))) {
        private enum enumMixinStr_GPIOD_MODER = `enum GPIOD_MODER = GPIO_MODER ( GPIOD );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD_MODER); }))) {
            mixin(enumMixinStr_GPIOD_MODER);
        }
    }




    static if(!is(typeof(GPIOC_MODER))) {
        private enum enumMixinStr_GPIOC_MODER = `enum GPIOC_MODER = GPIO_MODER ( GPIOC );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC_MODER); }))) {
            mixin(enumMixinStr_GPIOC_MODER);
        }
    }




    static if(!is(typeof(GPIOB_MODER))) {
        private enum enumMixinStr_GPIOB_MODER = `enum GPIOB_MODER = GPIO_MODER ( GPIOB );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB_MODER); }))) {
            mixin(enumMixinStr_GPIOB_MODER);
        }
    }




    static if(!is(typeof(GPIOA_MODER))) {
        private enum enumMixinStr_GPIOA_MODER = `enum GPIOA_MODER = GPIO_MODER ( GPIOA );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA_MODER); }))) {
            mixin(enumMixinStr_GPIOA_MODER);
        }
    }






    static if(!is(typeof(GPIOH))) {
        private enum enumMixinStr_GPIOH = `enum GPIOH = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOH); }))) {
            mixin(enumMixinStr_GPIOH);
        }
    }




    static if(!is(typeof(GPIOG))) {
        private enum enumMixinStr_GPIOG = `enum GPIOG = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1800 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOG); }))) {
            mixin(enumMixinStr_GPIOG);
        }
    }




    static if(!is(typeof(GPIOF))) {
        private enum enumMixinStr_GPIOF = `enum GPIOF = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1400 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOF); }))) {
            mixin(enumMixinStr_GPIOF);
        }
    }




    static if(!is(typeof(GPIOE))) {
        private enum enumMixinStr_GPIOE = `enum GPIOE = ( ( ( 0x40000000U ) + 0x20000 ) + 0x1000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOE); }))) {
            mixin(enumMixinStr_GPIOE);
        }
    }




    static if(!is(typeof(GPIOD))) {
        private enum enumMixinStr_GPIOD = `enum GPIOD = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0C00 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOD); }))) {
            mixin(enumMixinStr_GPIOD);
        }
    }




    static if(!is(typeof(GPIOC))) {
        private enum enumMixinStr_GPIOC = `enum GPIOC = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0800 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOC); }))) {
            mixin(enumMixinStr_GPIOC);
        }
    }




    static if(!is(typeof(GPIOB))) {
        private enum enumMixinStr_GPIOB = `enum GPIOB = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOB); }))) {
            mixin(enumMixinStr_GPIOB);
        }
    }




    static if(!is(typeof(GPIOA))) {
        private enum enumMixinStr_GPIOA = `enum GPIOA = ( ( ( 0x40000000U ) + 0x20000 ) + 0x0000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIOA); }))) {
            mixin(enumMixinStr_GPIOA);
        }
    }






    static if(!is(typeof(GPIO_ALL))) {
        private enum enumMixinStr_GPIO_ALL = `enum GPIO_ALL = 0xffff;`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO_ALL); }))) {
            mixin(enumMixinStr_GPIO_ALL);
        }
    }




    static if(!is(typeof(GPIO15))) {
        private enum enumMixinStr_GPIO15 = `enum GPIO15 = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO15); }))) {
            mixin(enumMixinStr_GPIO15);
        }
    }




    static if(!is(typeof(GPIO14))) {
        private enum enumMixinStr_GPIO14 = `enum GPIO14 = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO14); }))) {
            mixin(enumMixinStr_GPIO14);
        }
    }




    static if(!is(typeof(GPIO13))) {
        private enum enumMixinStr_GPIO13 = `enum GPIO13 = ( 1 << 13 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO13); }))) {
            mixin(enumMixinStr_GPIO13);
        }
    }




    static if(!is(typeof(GPIO12))) {
        private enum enumMixinStr_GPIO12 = `enum GPIO12 = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO12); }))) {
            mixin(enumMixinStr_GPIO12);
        }
    }




    static if(!is(typeof(GPIO11))) {
        private enum enumMixinStr_GPIO11 = `enum GPIO11 = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO11); }))) {
            mixin(enumMixinStr_GPIO11);
        }
    }




    static if(!is(typeof(GPIO10))) {
        private enum enumMixinStr_GPIO10 = `enum GPIO10 = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO10); }))) {
            mixin(enumMixinStr_GPIO10);
        }
    }




    static if(!is(typeof(GPIO9))) {
        private enum enumMixinStr_GPIO9 = `enum GPIO9 = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO9); }))) {
            mixin(enumMixinStr_GPIO9);
        }
    }




    static if(!is(typeof(GPIO8))) {
        private enum enumMixinStr_GPIO8 = `enum GPIO8 = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO8); }))) {
            mixin(enumMixinStr_GPIO8);
        }
    }




    static if(!is(typeof(GPIO7))) {
        private enum enumMixinStr_GPIO7 = `enum GPIO7 = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO7); }))) {
            mixin(enumMixinStr_GPIO7);
        }
    }




    static if(!is(typeof(GPIO6))) {
        private enum enumMixinStr_GPIO6 = `enum GPIO6 = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO6); }))) {
            mixin(enumMixinStr_GPIO6);
        }
    }




    static if(!is(typeof(GPIO5))) {
        private enum enumMixinStr_GPIO5 = `enum GPIO5 = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO5); }))) {
            mixin(enumMixinStr_GPIO5);
        }
    }




    static if(!is(typeof(GPIO4))) {
        private enum enumMixinStr_GPIO4 = `enum GPIO4 = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO4); }))) {
            mixin(enumMixinStr_GPIO4);
        }
    }




    static if(!is(typeof(GPIO3))) {
        private enum enumMixinStr_GPIO3 = `enum GPIO3 = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO3); }))) {
            mixin(enumMixinStr_GPIO3);
        }
    }




    static if(!is(typeof(GPIO2))) {
        private enum enumMixinStr_GPIO2 = `enum GPIO2 = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO2); }))) {
            mixin(enumMixinStr_GPIO2);
        }
    }




    static if(!is(typeof(GPIO1))) {
        private enum enumMixinStr_GPIO1 = `enum GPIO1 = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO1); }))) {
            mixin(enumMixinStr_GPIO1);
        }
    }




    static if(!is(typeof(GPIO0))) {
        private enum enumMixinStr_GPIO0 = `enum GPIO0 = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_GPIO0); }))) {
            mixin(enumMixinStr_GPIO0);
        }
    }






    static if(!is(typeof(CORESIGHT_LAR_KEY))) {
        private enum enumMixinStr_CORESIGHT_LAR_KEY = `enum CORESIGHT_LAR_KEY = 0xC5ACCE55;`;
        static if(is(typeof({ mixin(enumMixinStr_CORESIGHT_LAR_KEY); }))) {
            mixin(enumMixinStr_CORESIGHT_LAR_KEY);
        }
    }




    static if(!is(typeof(CORESIGHT_LSR_SLI))) {
        private enum enumMixinStr_CORESIGHT_LSR_SLI = `enum CORESIGHT_LSR_SLI = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_CORESIGHT_LSR_SLI); }))) {
            mixin(enumMixinStr_CORESIGHT_LSR_SLI);
        }
    }




    static if(!is(typeof(CORESIGHT_LSR_SLK))) {
        private enum enumMixinStr_CORESIGHT_LSR_SLK = `enum CORESIGHT_LSR_SLK = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_CORESIGHT_LSR_SLK); }))) {
            mixin(enumMixinStr_CORESIGHT_LSR_SLK);
        }
    }




    static if(!is(typeof(CORESIGHT_LAR_OFFSET))) {
        private enum enumMixinStr_CORESIGHT_LAR_OFFSET = `enum CORESIGHT_LAR_OFFSET = 0xfb0;`;
        static if(is(typeof({ mixin(enumMixinStr_CORESIGHT_LAR_OFFSET); }))) {
            mixin(enumMixinStr_CORESIGHT_LAR_OFFSET);
        }
    }




    static if(!is(typeof(CORESIGHT_LSR_OFFSET))) {
        private enum enumMixinStr_CORESIGHT_LSR_OFFSET = `enum CORESIGHT_LSR_OFFSET = 0xfb4;`;
        static if(is(typeof({ mixin(enumMixinStr_CORESIGHT_LSR_OFFSET); }))) {
            mixin(enumMixinStr_CORESIGHT_LSR_OFFSET);
        }
    }




    static if(!is(typeof(MPU_BASE))) {
        private enum enumMixinStr_MPU_BASE = `enum MPU_BASE = ( SCS_BASE + 0x0D90 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPU_BASE); }))) {
            mixin(enumMixinStr_MPU_BASE);
        }
    }




    static if(!is(typeof(SCB_BASE))) {
        private enum enumMixinStr_SCB_BASE = `enum SCB_BASE = ( SCS_BASE + 0x0D00 );`;
        static if(is(typeof({ mixin(enumMixinStr_SCB_BASE); }))) {
            mixin(enumMixinStr_SCB_BASE);
        }
    }




    static if(!is(typeof(NVIC_BASE))) {
        private enum enumMixinStr_NVIC_BASE = `enum NVIC_BASE = ( SCS_BASE + 0x0100 );`;
        static if(is(typeof({ mixin(enumMixinStr_NVIC_BASE); }))) {
            mixin(enumMixinStr_NVIC_BASE);
        }
    }




    static if(!is(typeof(SYS_TICK_BASE))) {
        private enum enumMixinStr_SYS_TICK_BASE = `enum SYS_TICK_BASE = ( SCS_BASE + 0x0010 );`;
        static if(is(typeof({ mixin(enumMixinStr_SYS_TICK_BASE); }))) {
            mixin(enumMixinStr_SYS_TICK_BASE);
        }
    }




    static if(!is(typeof(SCS_BASE))) {
        private enum enumMixinStr_SCS_BASE = `enum SCS_BASE = ( PPBI_BASE + 0xE000 );`;
        static if(is(typeof({ mixin(enumMixinStr_SCS_BASE); }))) {
            mixin(enumMixinStr_SCS_BASE);
        }
    }




    static if(!is(typeof(PPBI_BASE))) {
        private enum enumMixinStr_PPBI_BASE = `enum PPBI_BASE = ( 0xE0000000U );`;
        static if(is(typeof({ mixin(enumMixinStr_PPBI_BASE); }))) {
            mixin(enumMixinStr_PPBI_BASE);
        }
    }






    static if(!is(typeof(BIT31))) {
        private enum enumMixinStr_BIT31 = `enum BIT31 = ( 1 << 31 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT31); }))) {
            mixin(enumMixinStr_BIT31);
        }
    }




    static if(!is(typeof(BIT30))) {
        private enum enumMixinStr_BIT30 = `enum BIT30 = ( 1 << 30 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT30); }))) {
            mixin(enumMixinStr_BIT30);
        }
    }




    static if(!is(typeof(BIT29))) {
        private enum enumMixinStr_BIT29 = `enum BIT29 = ( 1 << 29 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT29); }))) {
            mixin(enumMixinStr_BIT29);
        }
    }




    static if(!is(typeof(BIT28))) {
        private enum enumMixinStr_BIT28 = `enum BIT28 = ( 1 << 28 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT28); }))) {
            mixin(enumMixinStr_BIT28);
        }
    }




    static if(!is(typeof(BIT27))) {
        private enum enumMixinStr_BIT27 = `enum BIT27 = ( 1 << 27 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT27); }))) {
            mixin(enumMixinStr_BIT27);
        }
    }




    static if(!is(typeof(BIT26))) {
        private enum enumMixinStr_BIT26 = `enum BIT26 = ( 1 << 26 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT26); }))) {
            mixin(enumMixinStr_BIT26);
        }
    }




    static if(!is(typeof(BIT25))) {
        private enum enumMixinStr_BIT25 = `enum BIT25 = ( 1 << 25 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT25); }))) {
            mixin(enumMixinStr_BIT25);
        }
    }




    static if(!is(typeof(BIT24))) {
        private enum enumMixinStr_BIT24 = `enum BIT24 = ( 1 << 24 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT24); }))) {
            mixin(enumMixinStr_BIT24);
        }
    }




    static if(!is(typeof(BIT23))) {
        private enum enumMixinStr_BIT23 = `enum BIT23 = ( 1 << 23 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT23); }))) {
            mixin(enumMixinStr_BIT23);
        }
    }




    static if(!is(typeof(BIT22))) {
        private enum enumMixinStr_BIT22 = `enum BIT22 = ( 1 << 22 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT22); }))) {
            mixin(enumMixinStr_BIT22);
        }
    }




    static if(!is(typeof(BIT21))) {
        private enum enumMixinStr_BIT21 = `enum BIT21 = ( 1 << 21 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT21); }))) {
            mixin(enumMixinStr_BIT21);
        }
    }




    static if(!is(typeof(BIT20))) {
        private enum enumMixinStr_BIT20 = `enum BIT20 = ( 1 << 20 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT20); }))) {
            mixin(enumMixinStr_BIT20);
        }
    }




    static if(!is(typeof(BIT19))) {
        private enum enumMixinStr_BIT19 = `enum BIT19 = ( 1 << 19 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT19); }))) {
            mixin(enumMixinStr_BIT19);
        }
    }




    static if(!is(typeof(BIT18))) {
        private enum enumMixinStr_BIT18 = `enum BIT18 = ( 1 << 18 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT18); }))) {
            mixin(enumMixinStr_BIT18);
        }
    }




    static if(!is(typeof(BIT17))) {
        private enum enumMixinStr_BIT17 = `enum BIT17 = ( 1 << 17 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT17); }))) {
            mixin(enumMixinStr_BIT17);
        }
    }




    static if(!is(typeof(BIT16))) {
        private enum enumMixinStr_BIT16 = `enum BIT16 = ( 1 << 16 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT16); }))) {
            mixin(enumMixinStr_BIT16);
        }
    }




    static if(!is(typeof(BIT15))) {
        private enum enumMixinStr_BIT15 = `enum BIT15 = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT15); }))) {
            mixin(enumMixinStr_BIT15);
        }
    }




    static if(!is(typeof(BIT14))) {
        private enum enumMixinStr_BIT14 = `enum BIT14 = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT14); }))) {
            mixin(enumMixinStr_BIT14);
        }
    }




    static if(!is(typeof(BIT13))) {
        private enum enumMixinStr_BIT13 = `enum BIT13 = ( 1 << 13 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT13); }))) {
            mixin(enumMixinStr_BIT13);
        }
    }




    static if(!is(typeof(BIT12))) {
        private enum enumMixinStr_BIT12 = `enum BIT12 = ( 1 << 12 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT12); }))) {
            mixin(enumMixinStr_BIT12);
        }
    }




    static if(!is(typeof(BIT11))) {
        private enum enumMixinStr_BIT11 = `enum BIT11 = ( 1 << 11 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT11); }))) {
            mixin(enumMixinStr_BIT11);
        }
    }




    static if(!is(typeof(BIT10))) {
        private enum enumMixinStr_BIT10 = `enum BIT10 = ( 1 << 10 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT10); }))) {
            mixin(enumMixinStr_BIT10);
        }
    }




    static if(!is(typeof(BIT9))) {
        private enum enumMixinStr_BIT9 = `enum BIT9 = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT9); }))) {
            mixin(enumMixinStr_BIT9);
        }
    }




    static if(!is(typeof(BIT8))) {
        private enum enumMixinStr_BIT8 = `enum BIT8 = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT8); }))) {
            mixin(enumMixinStr_BIT8);
        }
    }




    static if(!is(typeof(BIT7))) {
        private enum enumMixinStr_BIT7 = `enum BIT7 = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT7); }))) {
            mixin(enumMixinStr_BIT7);
        }
    }




    static if(!is(typeof(BIT6))) {
        private enum enumMixinStr_BIT6 = `enum BIT6 = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT6); }))) {
            mixin(enumMixinStr_BIT6);
        }
    }




    static if(!is(typeof(BIT5))) {
        private enum enumMixinStr_BIT5 = `enum BIT5 = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT5); }))) {
            mixin(enumMixinStr_BIT5);
        }
    }




    static if(!is(typeof(BIT4))) {
        private enum enumMixinStr_BIT4 = `enum BIT4 = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT4); }))) {
            mixin(enumMixinStr_BIT4);
        }
    }




    static if(!is(typeof(BIT3))) {
        private enum enumMixinStr_BIT3 = `enum BIT3 = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT3); }))) {
            mixin(enumMixinStr_BIT3);
        }
    }




    static if(!is(typeof(BIT2))) {
        private enum enumMixinStr_BIT2 = `enum BIT2 = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT2); }))) {
            mixin(enumMixinStr_BIT2);
        }
    }




    static if(!is(typeof(BIT1))) {
        private enum enumMixinStr_BIT1 = `enum BIT1 = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT1); }))) {
            mixin(enumMixinStr_BIT1);
        }
    }




    static if(!is(typeof(BIT0))) {
        private enum enumMixinStr_BIT0 = `enum BIT0 = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_BIT0); }))) {
            mixin(enumMixinStr_BIT0);
        }
    }
    static if(!is(typeof(_FEATURES_H))) {
        private enum enumMixinStr__FEATURES_H = `enum _FEATURES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FEATURES_H); }))) {
            mixin(enumMixinStr__FEATURES_H);
        }
    }
    static if(!is(typeof(_DEFAULT_SOURCE))) {
        private enum enumMixinStr__DEFAULT_SOURCE = `enum _DEFAULT_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__DEFAULT_SOURCE); }))) {
            mixin(enumMixinStr__DEFAULT_SOURCE);
        }
    }




    static if(!is(typeof(__GLIBC_USE_ISOC2X))) {
        private enum enumMixinStr___GLIBC_USE_ISOC2X = `enum __GLIBC_USE_ISOC2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_ISOC2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_ISOC2X);
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
        private enum enumMixinStr___GLIBC_MINOR__ = `enum __GLIBC_MINOR__ = 31;`;
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




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT_C2X))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X = `enum __GLIBC_USE_IEC_60559_BFP_EXT_C2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT_C2X))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT = `enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT);
        }
    }




    static if(!is(typeof(__LONG_DOUBLE_USES_FLOAT128))) {
        private enum enumMixinStr___LONG_DOUBLE_USES_FLOAT128 = `enum __LONG_DOUBLE_USES_FLOAT128 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___LONG_DOUBLE_USES_FLOAT128); }))) {
            mixin(enumMixinStr___LONG_DOUBLE_USES_FLOAT128);
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




    static if(!is(typeof(__STATFS_MATCHES_STATFS64))) {
        private enum enumMixinStr___STATFS_MATCHES_STATFS64 = `enum __STATFS_MATCHES_STATFS64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___STATFS_MATCHES_STATFS64); }))) {
            mixin(enumMixinStr___STATFS_MATCHES_STATFS64);
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






    static if(!is(typeof(bool_))) {
        private enum enumMixinStr_bool_ = `enum bool_ = _Bool;`;
        static if(is(typeof({ mixin(enumMixinStr_bool_); }))) {
            mixin(enumMixinStr_bool_);
        }
    }




    static if(!is(typeof(true_))) {
        private enum enumMixinStr_true_ = `enum true_ = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_true_); }))) {
            mixin(enumMixinStr_true_);
        }
    }




    static if(!is(typeof(false_))) {
        private enum enumMixinStr_false_ = `enum false_ = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_false_); }))) {
            mixin(enumMixinStr_false_);
        }
    }




    static if(!is(typeof(__bool_true_false_are_defined))) {
        private enum enumMixinStr___bool_true_false_are_defined = `enum __bool_true_false_are_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___bool_true_false_are_defined); }))) {
            mixin(enumMixinStr___bool_true_false_are_defined);
        }
    }



}


import external.libc.config;


@nogc:
nothrow:







void blink_gpio_setup_temporary_disabled()
{
    rcc_periph_clock_enable(RCC_GPIOB);




        gpio_mode_setup(( ( ( 0x40000000U ) + 0x20000 ) + 0x0800 ), 0x1, 0x0, ( 1 << 13 ));

}

void spi_setup()
{
    rcc_periph_clock_enable(RCC_GPIOB);
        gpio_mode_setup(
            ( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 ),
            0x2,
            0x2,
            ( 1 << 13 ) |
            ( 1 << 14 ) |
            ( 1 << 15 )
        );

        gpio_set_af(
            ( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 ),
            0x5,
            ( 1 << 13 ) |
            ( 1 << 14 ) |
            ( 1 << 15 )
        );

        gpio_set_output_options(
            ( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 ),
            0x0,
            0x0,
            ( 1 << 13 ) |
            ( 1 << 15 )
        );

        rcc_periph_clock_enable(RCC_SPI2);



    spi_reset(( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ));
    spi_init_master(
        ( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ),
        ( 0x05 << 3 ),
        ( 1 << 1 ),
        ( 1 << 0 ),
        ( 1 << 11 ),
        ( 0 << 7 )
    );
    spi_set_master_mode(( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ));
    spi_set_unidirectional_mode(( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ));

    spi_enable_ss_output(( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ));


    spi_enable(( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ));



        gpio_mode_setup(( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 ), 0x1, 0x0, ( 1 << 12 ));

}

void sendDataToSegmentDisplay(ushort data)
{
    spi_xfer(( ( ( 0x40000000U ) + 0x00000 ) + 0x3800 ), data);
}

void beginRefresh()
{
    gpio_clear(( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 ), ( 1 << 12 ));
}

void endRefresh()
{
    gpio_set(( ( ( 0x40000000U ) + 0x20000 ) + 0x0400 ), ( 1 << 12 ));
}
