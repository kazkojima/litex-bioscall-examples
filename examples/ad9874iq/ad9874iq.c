#include <generated/soc.h>
#include <generated/csr.h>
#include "nettype.h"

extern int printf(const char *format, ...);
extern int puts(const char *s);
extern char uart_read(void);
extern int udp_arp_resolve(unsigned int ip);

extern void __attribute__((weak)) udp_start(const unsigned char *macaddr, unsigned int ip);
extern int __attribute__((weak)) udp_send(unsigned short src_port, unsigned short dst_port, unsigned int length);
extern void __attribute__((weak)) udp_start_constprop_0(unsigned int ip, const unsigned char *macaddr);
extern int __attribute__((weak)) udp_send_constprop_0_isra_0(unsigned short dst_port, unsigned int length);
void * __attribute__((weak)) udp_get_tx_buffer(void);

void xudp_start(const unsigned char *macaddr, unsigned int ip)
{
  if (udp_start)
    udp_start(macaddr, ip);
  else if (udp_start_constprop_0)
    udp_start_constprop_0(ip, macaddr);
  else
    printf("no udp_start variants\n");
}

int xudp_send(unsigned short src_port, unsigned short dst_port, unsigned int length)
{
  if (udp_send)
    return udp_send(src_port, dst_port, length);
  else if (udp_send_constprop_0_isra_0)
    // src_port ignored
    return udp_send_constprop_0_isra_0(dst_port, length);
  else {
    printf("no udp_send variants\n");
    return -1;
  }
}

static unsigned char macadr[6] = {0x10, 0xe2, 0xd5, 0x00, 0x00, 0x00};

#define IPTOINT(a, b, c, d) ((a << 24)|(b << 16)|(c << 8)|d)

extern void **_bios_txbuffer_p;

void *xudp_get_tx_buffer(void)
{
  if (udp_get_tx_buffer)
    return udp_get_tx_buffer();

  ethernet_buffer *txbuffer = *_bios_txbuffer_p;
  return txbuffer->frame.contents.udp.payload;
}

int main()
{
  unsigned int ip;

  printf("Generate packets with IQ data\n");
  printf("Local IP : %d.%d.%d.%d\n", LOCALIP1, LOCALIP2, LOCALIP3, LOCALIP4);
  printf("Remote IP: %d.%d.%d.%d\n", REMOTEIP1, REMOTEIP2, REMOTEIP3, REMOTEIP4);

  ip = IPTOINT(REMOTEIP1, REMOTEIP2, REMOTEIP3, REMOTEIP4);
  xudp_start(macadr, IPTOINT(LOCALIP1, LOCALIP2, LOCALIP3, LOCALIP4));

  if(!udp_arp_resolve(ip)) {
    printf("arp resolve fail\n");
    puts("Hit key for reboot");
    uart_read();
    return -1;
  }

  int j;
  unsigned int iqdat[256];
  char *buf;

  for (;;) {
    for (j = 0; j < 256; j++) {
      while (*(volatile char *)CSR_AD9874IQ_READY_ADDR == 0) ;
      iqdat[j] = *(volatile int *)CSR_AD9874IQ_DATA_ADDR;
    }
    buf = xudp_get_tx_buffer();
    for (j = 0; j < 256*4; j++)
      buf[j] = ((char *)iqdat)[j];
    xudp_send(7642, 6000, 256*4);
  }

  return 0;
}

