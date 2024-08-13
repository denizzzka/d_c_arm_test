extern int rt_init(void);
extern int rt_term(void);
extern void d_app_main(void);

void app_main(void)
{
    rt_init();
    d_app_main();
    rt_term();
}
