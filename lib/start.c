#include "irq.h"
#include <generated/csr.h>

extern int main();
extern void reboot_handler();
extern void *memset(void *s, int c, int n);

extern char _bss_start[], _bss_end[];

void _start()
{

  memset(_bss_start, 0, (int)(_bss_end - _bss_start));
  
  irq_setie(1);
#ifdef CSR_UART_BASE
  irq_setmask(irq_getmask() | (1 << UART_INTERRUPT));
#endif

  main();

  reboot_handler();
}
