/* LWIP example */

#include <generated/csr.h>
#include <generated/soc.h>

#include "lwip/ip.h"
#include "lwip/init.h"
#include "lwip/tcp.h"
#include "lwip/timeouts.h"

extern err_t ethernetif_init(struct netif *netif);
extern void ethernetif_input(struct netif *netif) ;
extern err_t ethernet_input(struct pbuf *p, struct netif *netif);

extern void *memcpy(void *dest, const void *src, unsigned n);
extern int printf(const char *format, ...);
extern int puts(const char *s);
extern char uart_read(void);

static uint32_t sys_time_start, sys_time_now;
static uint32_t millis;

uint32_t sys_now (void)
{
  uint32_t ms;
  timer0_update_value_write(1);
  sys_time_now = timer0_value_read();
  ms = (uint32_t)(sys_time_start - sys_time_now) / (CONFIG_CLOCK_FREQUENCY/1000);
  millis += ms;
  sys_time_start = sys_time_now;
  return millis;
}

int memcmp(const void *s1, const void *s2, size_t n)
{
  while (n) {
    int d = (int)*((uint8_t *)s1) - (int)*((uint8_t *)s2);
    s1++;
    s2++;
    n--;
    if (d)
      return d;
  }

  return 0;
}

/* reduced atoi - only one digit */
int atoi(const char *s)
{
  if (s[0] >= '0' && s[0] <= '9')
    return s[0] - '0';
  return 0;
}

static err_t
tcp_appserver_recv(void* arg, struct tcp_pcb* pcb, struct pbuf* p, err_t err)
{
  if (p != NULL) {
    // handle pbuf contents
    struct pbuf* q;
    for (q = p; q != NULL; q = q->next) {
      printf("Got tcp packet len=%d\n", q->len);
      for (int i = 0; i < q->len; i++)
	printf("%02x ", ((char *)(q->payload))[i]);
      puts("\n");
    }
    pbuf_free(p);
  }

  return ERR_OK;
}

static void tcp_appserver_err(void* arg, err_t err)
{
}

static err_t tcp_appserver_poll(void *arg, struct tcp_pcb *pcb)
{
}

static err_t tcp_appserver_accept(void *arg, struct tcp_pcb *newpcb, err_t err)
{

  tcp_arg(newpcb, NULL);

  /* initialize lwIP tcp callbacks */
  tcp_recv(newpcb, tcp_appserver_recv);
  tcp_err(newpcb, tcp_appserver_err);
  tcp_poll(newpcb, tcp_appserver_poll, 1);

  return ERR_OK;
}

void tcp_appserver_init(void)
{
  struct tcp_pcb *pcb = tcp_new();

  if (pcb != NULL) {
    err_t err;

    /* bind pcb to port 6000 */
    err = tcp_bind(pcb, IP_ADDR_ANY, 6000);
    if (err == ERR_OK) {
      pcb = tcp_listen(pcb);

      /* initialize LwIP tcp_accept callback function */
      tcp_accept(pcb, tcp_appserver_accept);
    } else {
      /* deallocate the pcb */
      memp_free(MEMP_TCP_PCB, pcb);
    }
  }
}

#define ETHMAC_EV_SRAM_WRITER   0x1

int main()
{
  ip4_addr_t ip, gateway, netmask;
  static struct netif thisif;

  puts("hello, world\n");

  timer0_en_write(0);
  timer0_reload_write(0);
  timer0_load_write(0xffffffff);
  timer0_en_write(1);
  timer0_update_value_write(1);
  sys_time_start = timer0_value_read();

  lwip_init ();
  
  puts("lwip initialized\n");

  IP4_ADDR (&ip, 10, 253, 253, 129);
  IP4_ADDR (&netmask, 255, 255, 255, 0);
  IP4_ADDR (&gateway, 10, 253, 253, 1);
  netif_add(&thisif, &ip, &netmask, &gateway, NULL,
            ethernetif_init, ethernet_input);
  netif_set_default(&thisif);
  netif_set_up(&thisif);

  puts("netif setup\n");

  tcp_appserver_init();

  while (1) {
    if(ethmac_sram_writer_ev_pending_read() & ETHMAC_EV_SRAM_WRITER) {
      ethernetif_input(&thisif);
    }
    sys_check_timeouts();
  }

  puts("Hit key for reboot");
  uart_read();
}







