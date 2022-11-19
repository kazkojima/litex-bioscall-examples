/* LWIP example */

#include <generated/csr.h>
#include <generated/soc.h>

#include <string.h>

#include "lwip/ip.h"
#include "lwip/init.h"
#include "lwip/tcp.h"
#include "lwip/udp.h"
#include "lwip/timeouts.h"

extern err_t ethernetif_init(struct netif *netif);
extern void ethernetif_input(struct netif *netif) ;
extern err_t ethernet_input(struct pbuf *p, struct netif *netif);

extern int printf(const char *format, ...);
extern int puts(const char *s);
extern char uart_read(void);
extern void _bios_reboot_handler(void);

static uint32_t sys_time_start, sys_time_now;
static uint64_t clocks;
static uint32_t millis;

uint32_t sys_now (void)
{
  timer0_update_value_write(1);
  sys_time_now = timer0_value_read();
  clocks += (uint32_t)(sys_time_start - sys_time_now);
  millis = (uint32_t)(clocks / (CONFIG_CLOCK_FREQUENCY/1000));
  //printf("millis: %d\n", millis);
  timer0_en_write(0);
  timer0_load_write(0xffffffff);
  timer0_en_write(1);
  timer0_update_value_write(1);
  sys_time_start = timer0_value_read();
  return millis;
}

static int handle_pwmi_req(uint8_t *p, size_t n)
{
  if (n % 4)
    return -1;
  uint8_t *regs = p;
  while (n) {
    if (regs[0] != 4)
      return -1;
    // Add 1-bit dummy bit to register number.
    uint32_t dat = ((uint32_t)regs[2] << 9) | regs[3];
    while(!pwmi_status_done_read())
      ;
    pwmi_data_write(dat);
    pwmi_control_start_write(1);
    //printf("spi write %02x reg=%02x\n", regs[3], regs[2]);
    n -= 4;
    regs += 4;
  }
  return 0;
}

static err_t
tcp_appserver_recv(void* arg, struct tcp_pcb* pcb, struct pbuf* p, err_t err)
{
  if (p != NULL) {
    // handle pbuf contents
    struct pbuf* q;
    for (q = p; q != NULL; q = q->next) {
#if 0
      printf("Got tcp packet len=%d\n", q->len);
      for (int i = 0; i < q->len; i++)
	printf("%02x ", ((char *)(q->payload))[i]);
      puts("\n");
#endif
      if (p->len == 8 && 0 == memcmp(p->payload, "reboot", 6U))
	_bios_reboot_handler();
      else
	handle_pwmi_req(q->payload, q->len);
    }
    pbuf_free(p);
  }

  return ERR_OK;
}

static void tcp_appserver_err(void* arg, err_t err)
{
  //puts("err\n");
}

static err_t tcp_appserver_poll(void *arg, struct tcp_pcb *pcb)
{
  //puts("poll\n");
  return 0;
}

static err_t tcp_appserver_accept(void *arg, struct tcp_pcb *newpcb, err_t err)
{
  if ((err != ERR_OK) || (newpcb == NULL)) {
    return ERR_VAL;
  }

  tcp_setprio(newpcb, TCP_PRIO_MIN);
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

struct udp_pcb *udp_appclient_init(void)
{
  struct udp_pcb *pcb = udp_new();
  ip4_addr_t destIPAddr;

  IP4_ADDR(&destIPAddr,10,253,253,8);
 
  if (pcb != NULL) {
    err_t err;

    /* bind pcb to port 6001 */
    err = udp_bind(pcb, IP_ADDR_ANY, 6001);
    if (err != ERR_OK)
      goto failed;
    err = udp_connect(pcb, &destIPAddr, 6000);
    if (err != ERR_OK)
      goto failed;
    return pcb;

  failed:
    /* deallocate the pcb */
    memp_free(MEMP_UDP_PCB, pcb);
  }
  return NULL;
}

#define NDATA (256+64)
unsigned int iqdat[NDATA];
unsigned int iqdat_idx;

#define NSAMPLE 1024
unsigned int iqsample[NSAMPLE];
unsigned int iqsample_idx;
int iqsampling;

static void send_iq(struct udp_pcb *udp_pcb)
{
  unsigned int iq;
  while (iqdat_idx < NDATA) {
    if (!ad9874iq_ready_read())
      break;
    iq = ad9874iq_data_read();
    iqdat[iqdat_idx++] = iq;
    if (iqsampling) {
      iqsample[iqsample_idx++] = iq;
      if (iqsample_idx >= NSAMPLE) {
	iqsample_idx = 0;
	iqsampling = 0;
      }
    }
  }

  if (iqdat_idx != NDATA)
    return;

  iqdat_idx = 0;
  if (udp_pcb) {
    struct pbuf *p;
    size_t len = sizeof(iqdat);
    p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
    if (p != NULL) {
      /* copy data to pbuf */
      pbuf_take(p, (char*)iqdat, len);
      udp_send(udp_pcb, p);
      pbuf_free(p);
    } else
      puts("can't get pbuf");
  } else {
    puts("iq packet trashed\n");
  }
}

struct udp_pcb *udp_appclient2_init(void)
{
  struct udp_pcb *pcb = udp_new();
  ip4_addr_t destIPAddr;

  //IP4_ADDR(&destIPAddr,10,253,253,75);
  IP4_ADDR(&destIPAddr,10,253,253,8);
 
  if (pcb != NULL) {
    err_t err;

    err = udp_connect(pcb, &destIPAddr, 6001);
    if (err != ERR_OK)
      goto failed;
    return pcb;

  failed:
    /* deallocate the pcb */
    memp_free(MEMP_UDP_PCB, pcb);
  }
  return NULL;
}

#define NFFTBUF NSAMPLE
unsigned int fftbuf[NFFTBUF];
unsigned int fftbuf_idx;
#define NFFTSEG (128)
unsigned int fftseg_num;

uint16_t fft_sample_count;
#define SAMPLE_RATIO 50

int fft_state;
#define FFT_IDLE 0
#define FFT_CONV 1
#define FFT_DONE 2
#define FFT_SEND 3
#define FFT_SENDRAW 4

static void send_fft(struct udp_pcb *udp_pcb)
{
  if (fft_state == FFT_IDLE) {
    if ((fft_sample_count++ % SAMPLE_RATIO) == 0) {
      // Start sampling IQ
      iqsampling = 1;
      // Start FFT
      ad9874iq_fft_control_start_write(1);
      fft_state = FFT_CONV;
      //puts("start FFT");
    }
    return;
  } else if (fft_state == FFT_CONV) {
    if (ad9874iq_fft_status_done_read()) {
      fft_state = FFT_DONE;
      //puts("done FFT");
    }
    return;
  } else if (fft_state == FFT_DONE) {
    while (fftbuf_idx < NFFTBUF) {
      if (!ad9874iq_fft_ready_read())
	break;
      fftbuf[fftbuf_idx++] = ad9874iq_fft_data_read();
    }
    if (fftbuf_idx == NFFTBUF) {
      fft_state = FFT_SEND;
      fftbuf_idx = 0;
      //puts("send FFT");
    } else
      return;
  }

  // FFT_SEND or SEND_RAW
  if (udp_pcb) {
    struct pbuf *p;
    p = pbuf_alloc(PBUF_TRANSPORT, 4+4*(NFFTSEG), PBUF_RAM);
    if (p != NULL) {
      /* copy data to pbuf */
      uint16_t header[2];
      unsigned int *src;
      header[0] = fftseg_num;
      header[1] = (fft_state == FFT_SEND) ? 0 : 1;
      pbuf_take_at(p, (char *)header, sizeof(header), 0);
      fftseg_num++;
      src =  (fft_state == FFT_SEND) ? fftbuf : iqsample;
      pbuf_take_at(p, (char*)(src + fftbuf_idx), 4*(NFFTSEG), 4);
      fftbuf_idx += NFFTSEG;
      udp_send(udp_pcb, p);
      //puts("FFT seg");
      pbuf_free(p);
    } else
      puts("can't get fft pbuf");

    if (fftbuf_idx >= NFFTBUF) {
      if (fft_state == FFT_SEND)
	fft_state = FFT_SENDRAW;
      else
	fft_state = FFT_IDLE;
      fftbuf_idx = 0;
      //puts("return to idle FFT");
    }
  } else {
    puts("fft packet trashed\n");
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
  
  puts("lwip initialized");

  IP4_ADDR (&ip, 10, 253, 253, 129);
  IP4_ADDR (&netmask, 255, 255, 255, 0);
  IP4_ADDR (&gateway, 10, 253, 253, 1);
  netif_add(&thisif, &ip, &netmask, &gateway, NULL,
            ethernetif_init, ethernet_input);
  netif_set_default(&thisif);
  netif_set_up(&thisif);

  puts("netif setup");

  tcp_appserver_init();
  puts("tcp server initialized");

  struct udp_pcb *upcb;
  upcb = udp_appclient_init();
  if (upcb)
    puts("udp client initialized");

  struct udp_pcb *upcb2;
  upcb2 = udp_appclient2_init();
  if (upcb2)
    puts("udp client2 initialized");

  while (1) {
    if(ethmac_sram_writer_ev_pending_read() & ETHMAC_EV_SRAM_WRITER) {
      ethernetif_input(&thisif);
    }
    send_fft(upcb2);
    send_iq(upcb);
    sys_check_timeouts();
  }

  puts("Hit key for reboot");
  uart_read();
}
