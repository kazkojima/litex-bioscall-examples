#include <generated/csr.h>

#ifdef CSR_ETHMAC_PREAMBLE_CRC_ADDR
#define HW_PREAMBLE_CRC
#endif

struct ethernet_header {
#ifndef HW_PREAMBLE_CRC
        unsigned char preamble[8];
#endif
        unsigned char destmac[6];
        unsigned char srcmac[6];
        unsigned short ethertype;
} __attribute__((packed));

struct arp_frame {
        unsigned short hwtype;
        unsigned short proto;
        unsigned char hwsize;
        unsigned char protosize;
        unsigned short opcode;
        unsigned char sender_mac[6];
        unsigned int sender_ip;
        unsigned char target_mac[6];
        unsigned int target_ip;
        unsigned char padding[18];
} __attribute__((packed));

struct ip_header {
        unsigned char version;
        unsigned char diff_services;
        unsigned short total_length;
        unsigned short identification;
        unsigned short fragment_offset;
        unsigned char ttl;
        unsigned char proto;
        unsigned short checksum;
        unsigned int src_ip;
        unsigned int dst_ip;
} __attribute__((packed));

struct udp_header {
        unsigned short src_port;
        unsigned short dst_port;
        unsigned short length;
        unsigned short checksum;
} __attribute__((packed));

struct udp_frame {
        struct ip_header ip;
        struct udp_header udp;
        char payload[];
} __attribute__((packed));

struct ethernet_frame {
        struct ethernet_header eth_header;
        union {
                struct arp_frame arp;
                struct udp_frame udp;
        } contents;
} __attribute__((packed));

typedef union {
        struct ethernet_frame frame;
        unsigned char raw[ETHMAC_SLOT_SIZE];
} ethernet_buffer;
