#include <generated/soc.h>
#include <generated/csr.h>
#include "nettype.h"

extern int printf(const char *format, ...);
extern int puts(const char *s);
extern char uart_read(void);
extern void udp_start_constprop_0(unsigned int ip, const unsigned char *macaddr);
extern int udp_send_constprop_0_isra_0(unsigned short dst_port, unsigned int length);
extern int udp_arp_resolve(unsigned int ip);

static unsigned char macadr[6] = {0x10, 0xe2, 0xd5, 0x00, 0x00, 0x00};

#define IPTOINT(a, b, c, d) ((a << 24)|(b << 16)|(c << 8)|d)

extern void **_bios_txbuffer_p;

void *udp_get_tx_buffer(void)
{
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
  udp_start_constprop_0(IPTOINT(LOCALIP1, LOCALIP2, LOCALIP3, LOCALIP4), macadr);

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
    buf = udp_get_tx_buffer();
    for (j = 0; j < 256*4; j++)
      buf[j] = ((char *)iqdat)[j];
    udp_send_constprop_0_isra_0(6000, 256*4);
  }

  return 0;
}

