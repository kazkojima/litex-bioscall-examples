	.file	"stubs.s"
	.option	nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.startup,"ax",@progbits
	.align	 2
	.globl	trap_entry
	.type	trap_entry, @function
trap_entry:
	li	t0, 32
	jr	t0
	.size	trap_entry, .-trap_entry
	.globl	crt_init
	.type	crt_init, @function
crt_init:
	li	t0, 176
	jr	t0
	.size	crt_init, .-crt_init
	.globl	data_init
	.type	data_init, @function
data_init:
	li	t0, 196
	jr	t0
	.size	data_init, .-data_init
	.globl	data_loop
	.type	data_loop, @function
data_loop:
	li	t0, 220
	jr	t0
	.size	data_loop, .-data_loop
	.globl	bss_init
	.type	bss_init, @function
bss_init:
	li	t0, 244
	jr	t0
	.size	bss_init, .-bss_init
	.globl	data_done
	.type	data_done, @function
data_done:
	li	t0, 244
	jr	t0
	.size	data_done, .-data_done
	.globl	bss_loop
	.type	bss_loop, @function
bss_loop:
	li	t0, 260
	jr	t0
	.size	bss_loop, .-bss_loop
	.globl	bss_done
	.type	bss_done, @function
bss_done:
	li	t0, 276
	jr	t0
	.size	bss_done, .-bss_done
	.globl	infinit_loop
	.type	infinit_loop, @function
infinit_loop:
	li	t0, 292
	jr	t0
	.size	infinit_loop, .-infinit_loop
	.globl	flush_cpu_dcache_lto_priv_0
	.type	flush_cpu_dcache_lto_priv_0, @function
flush_cpu_dcache_lto_priv_0:
	li	t0, 296
	jr	t0
	.size	flush_cpu_dcache_lto_priv_0, .-flush_cpu_dcache_lto_priv_0
	.globl	flush_cpu_dcache_lto_priv_1
	.type	flush_cpu_dcache_lto_priv_1, @function
flush_cpu_dcache_lto_priv_1:
	li	t0, 296
	jr	t0
	.size	flush_cpu_dcache_lto_priv_1, .-flush_cpu_dcache_lto_priv_1
	.globl	flush_cpu_dcache_lto_priv_2
	.type	flush_cpu_dcache_lto_priv_2, @function
flush_cpu_dcache_lto_priv_2:
	li	t0, 296
	jr	t0
	.size	flush_cpu_dcache_lto_priv_2, .-flush_cpu_dcache_lto_priv_2
	.globl	flush_cpu_dcache_lto_priv_3
	.type	flush_cpu_dcache_lto_priv_3, @function
flush_cpu_dcache_lto_priv_3:
	li	t0, 296
	jr	t0
	.size	flush_cpu_dcache_lto_priv_3, .-flush_cpu_dcache_lto_priv_3
	.globl	reboot_handler
	.type	reboot_handler, @function
reboot_handler:
	li	t0, 304
	jr	t0
	.size	reboot_handler, .-reboot_handler
	.globl	crc32
	.type	crc32, @function
crc32:
	li	t0, 320
	jr	t0
	.size	crc32, .-crc32
	.globl	flush_l2_cache
	.type	flush_l2_cache, @function
flush_l2_cache:
	li	t0, 704
	jr	t0
	.size	flush_l2_cache, .-flush_l2_cache
	.globl	uart_read
	.type	uart_read, @function
uart_read:
	li	t0, 728
	jr	t0
	.size	uart_read, .-uart_read
	.globl	litex_getc
	.type	litex_getc, @function
litex_getc:
	li	t0, 812
	jr	t0
	.size	litex_getc, .-litex_getc
	.globl	uart_write
	.type	uart_write, @function
uart_write:
	li	t0, 856
	jr	t0
	.size	uart_write, .-uart_write
	.globl	litex_putc
	.type	litex_putc, @function
litex_putc:
	li	t0, 976
	jr	t0
	.size	litex_putc, .-litex_putc
	.globl	cdelay
	.type	cdelay, @function
cdelay:
	li	t0, 1036
	jr	t0
	.size	cdelay, .-cdelay
	.globl	send_packet
	.type	send_packet, @function
send_packet:
	li	t0, 1104
	jr	t0
	.size	send_packet, .-send_packet
	.globl	ip_checksum
	.type	ip_checksum, @function
ip_checksum:
	li	t0, 1188
	jr	t0
	.size	ip_checksum, .-ip_checksum
	.globl	delay
	.type	delay, @function
delay:
	li	t0, 1288
	jr	t0
	.size	delay, .-delay
	.globl	raw_write
	.type	raw_write, @function
raw_write:
	li	t0, 1332
	jr	t0
	.size	raw_write, .-raw_write
	.globl	raw_turnaround
	.type	raw_turnaround, @function
raw_turnaround:
	li	t0, 1504
	jr	t0
	.size	raw_turnaround, .-raw_turnaround
	.globl	mdio_read
	.type	mdio_read, @function
mdio_read:
	li	t0, 1580
	jr	t0
	.size	mdio_read, .-mdio_read
	.globl	busy_wait_constprop_0
	.type	busy_wait_constprop_0, @function
busy_wait_constprop_0:
	li	t0, 1796
	jr	t0
	.size	busy_wait_constprop_0, .-busy_wait_constprop_0
	.globl	spiflash_master_write_constprop_0
	.type	spiflash_master_write_constprop_0, @function
spiflash_master_write_constprop_0:
	li	t0, 1856
	jr	t0
	.size	spiflash_master_write_constprop_0, .-spiflash_master_write_constprop_0
	.globl	udp_start_constprop_0
	.type	udp_start_constprop_0, @function
udp_start_constprop_0:
	li	t0, 1988
	jr	t0
	.size	udp_start_constprop_0, .-udp_start_constprop_0
	.globl	fill_eth_header_constprop_0
	.type	fill_eth_header_constprop_0, @function
fill_eth_header_constprop_0:
	li	t0, 2136
	jr	t0
	.size	fill_eth_header_constprop_0, .-fill_eth_header_constprop_0
	.globl	udp_service
	.type	udp_service, @function
udp_service:
	li	t0, 2240
	jr	t0
	.size	udp_service, .-udp_service
	.globl	udp_arp_resolve
	.type	udp_arp_resolve, @function
udp_arp_resolve:
	li	t0, 3196
	jr	t0
	.size	udp_arp_resolve, .-udp_arp_resolve
	.globl	udp_send_constprop_0_isra_0
	.type	udp_send_constprop_0_isra_0, @function
udp_send_constprop_0_isra_0:
	li	t0, 3680
	jr	t0
	.size	udp_send_constprop_0_isra_0, .-udp_send_constprop_0_isra_0
	.globl	rx_callback_lto_priv_1
	.type	rx_callback_lto_priv_1, @function
rx_callback_lto_priv_1:
	li	t0, 4304
	jr	t0
	.size	rx_callback_lto_priv_1, .-rx_callback_lto_priv_1
	.globl	boot
	.type	boot, @function
boot:
	li	t0, 4620
	jr	t0
	.size	boot, .-boot
	.globl	print_size
	.type	print_size, @function
print_size:
	li	t0, 4776
	jr	t0
	.size	print_size, .-print_size
	.globl	print_progress
	.type	print_progress, @function
print_progress:
	li	t0, 4916
	jr	t0
	.size	print_progress, .-print_progress
	.globl	memspeed
	.type	memspeed, @function
memspeed:
	li	t0, 4988
	jr	t0
	.size	memspeed, .-memspeed
	.globl	serialboot_part_0
	.type	serialboot_part_0, @function
serialboot_part_0:
	li	t0, 5528
	jr	t0
	.size	serialboot_part_0, .-serialboot_part_0
	.globl	serialboot
	.type	serialboot, @function
serialboot:
	li	t0, 6164
	jr	t0
	.size	serialboot, .-serialboot
	.globl	help_handler
	.type	help_handler, @function
help_handler:
	li	t0, 6536
	jr	t0
	.size	help_handler, .-help_handler
	.globl	mem_list_handler
	.type	mem_list_handler, @function
mem_list_handler:
	li	t0, 6740
	jr	t0
	.size	mem_list_handler, .-mem_list_handler
	.globl	ident_handler
	.type	ident_handler, @function
ident_handler:
	li	t0, 6780
	jr	t0
	.size	ident_handler, .-ident_handler
	.globl	crc_handler
	.type	crc_handler, @function
crc_handler:
	li	t0, 6864
	jr	t0
	.size	crc_handler, .-crc_handler
	.globl	leds_handler
	.type	leds_handler, @function
leds_handler:
	li	t0, 7040
	jr	t0
	.size	leds_handler, .-leds_handler
	.globl	mem_write_handler
	.type	mem_write_handler, @function
mem_write_handler:
	li	t0, 7160
	jr	t0
	.size	mem_write_handler, .-mem_write_handler
	.globl	mem_copy_handler
	.type	mem_copy_handler, @function
mem_copy_handler:
	li	t0, 7516
	jr	t0
	.size	mem_copy_handler, .-mem_copy_handler
	.globl	mem_speed_handler
	.type	mem_speed_handler, @function
mem_speed_handler:
	li	t0, 7776
	jr	t0
	.size	mem_speed_handler, .-mem_speed_handler
	.globl	mem_cmp_handler
	.type	mem_cmp_handler, @function
mem_cmp_handler:
	li	t0, 8084
	jr	t0
	.size	mem_cmp_handler, .-mem_cmp_handler
	.globl	boot_handler
	.type	boot_handler, @function
boot_handler:
	li	t0, 8392
	jr	t0
	.size	boot_handler, .-boot_handler
	.globl	mdio_write_handler
	.type	mdio_write_handler, @function
mdio_write_handler:
	li	t0, 8696
	jr	t0
	.size	mdio_write_handler, .-mdio_write_handler
	.globl	mdio_read_handler
	.type	mdio_read_handler, @function
mdio_read_handler:
	li	t0, 9052
	jr	t0
	.size	mdio_read_handler, .-mdio_read_handler
	.globl	mdio_dump_handler
	.type	mdio_dump_handler, @function
mdio_dump_handler:
	li	t0, 9252
	jr	t0
	.size	mdio_dump_handler, .-mdio_dump_handler
	.globl	mem_read_handler
	.type	mem_read_handler, @function
mem_read_handler:
	li	t0, 9480
	jr	t0
	.size	mem_read_handler, .-mem_read_handler
	.globl	cread_add_char
	.type	cread_add_char, @function
cread_add_char:
	li	t0, 9960
	jr	t0
	.size	cread_add_char, .-cread_add_char
	.globl	memtest
	.type	memtest, @function
memtest:
	li	t0, 10264
	jr	t0
	.size	memtest, .-memtest
	.globl	mem_test_handler
	.type	mem_test_handler, @function
mem_test_handler:
	li	t0, 11204
	jr	t0
	.size	mem_test_handler, .-mem_test_handler
	.globl	sdram_test_handler
	.type	sdram_test_handler, @function
sdram_test_handler:
	li	t0, 11384
	jr	t0
	.size	sdram_test_handler, .-sdram_test_handler
	.globl	tftp_get_constprop_0
	.type	tftp_get_constprop_0, @function
tftp_get_constprop_0:
	li	t0, 11396
	jr	t0
	.size	tftp_get_constprop_0, .-tftp_get_constprop_0
	.globl	copy_file_from_tftp_to_ram_constprop_0
	.type	copy_file_from_tftp_to_ram_constprop_0, @function
copy_file_from_tftp_to_ram_constprop_0:
	li	t0, 12044
	jr	t0
	.size	copy_file_from_tftp_to_ram_constprop_0, .-copy_file_from_tftp_to_ram_constprop_0
	.globl	tftp_load
	.type	tftp_load, @function
tftp_load:
	li	t0, 12168
	jr	t0
	.size	tftp_load, .-tftp_load
	.globl	netboot_from_json_constprop_0
	.type	netboot_from_json_constprop_0, @function
netboot_from_json_constprop_0:
	li	t0, 12368
	jr	t0
	.size	netboot_from_json_constprop_0, .-netboot_from_json_constprop_0
	.globl	netboot
	.type	netboot, @function
netboot:
	li	t0, 14140
	jr	t0
	.size	netboot, .-netboot
	.globl	isr
	.type	isr, @function
isr:
	li	t0, 14392
	jr	t0
	.size	isr, .-isr
	.globl	getentropy
	.type	getentropy, @function
getentropy:
	li	t0, 14612
	jr	t0
	.size	getentropy, .-getentropy
	.globl	getpid
	.type	getpid, @function
getpid:
	li	t0, 14620
	jr	t0
	.size	getpid, .-getpid
	.globl	kill
	.type	kill, @function
kill:
	li	t0, 14632
	jr	t0
	.size	kill, .-kill
	.globl	boot_helper
	.type	boot_helper, @function
boot_helper:
	li	t0, 18632
	jr	t0
	.size	boot_helper, .-boot_helper
	.globl	strtoul_l
	.type	strtoul_l, @function
strtoul_l:
	li	t0, 18732
	jr	t0
	.size	strtoul_l, .-strtoul_l
	.globl	strtoul
	.type	strtoul, @function
strtoul:
	li	t0, 19088
	jr	t0
	.size	strtoul, .-strtoul
	.globl	strncmp
	.type	strncmp, @function
strncmp:
	li	t0, 19152
	jr	t0
	.size	strncmp, .-strncmp
	.globl	strncpy
	.type	strncpy, @function
strncpy:
	li	t0, 19216
	jr	t0
	.size	strncpy, .-strncpy
	.globl	strnlen
	.type	strnlen, @function
strnlen:
	li	t0, 19272
	jr	t0
	.size	strnlen, .-strnlen
	.globl	fgetc
	.type	fgetc, @function
fgetc:
	li	t0, 19308
	jr	t0
	.size	fgetc, .-fgetc
	.globl	getc
	.type	getc, @function
getc:
	li	t0, 19308
	jr	t0
	.size	getc, .-getc
	.globl	fputc
	.type	fputc, @function
fputc:
	li	t0, 19432
	jr	t0
	.size	fputc, .-fputc
	.globl	putc
	.type	putc, @function
putc:
	li	t0, 19432
	jr	t0
	.size	putc, .-putc
	.globl	fputs
	.type	fputs, @function
fputs:
	li	t0, 19500
	jr	t0
	.size	fputs, .-fputs
	.globl	printf
	.type	printf, @function
printf:
	li	t0, 19612
	jr	t0
	.size	printf, .-printf
	.globl	puts
	.type	puts, @function
puts:
	li	t0, 19684
	jr	t0
	.size	puts, .-puts
	.globl	vfprintf
	.type	vfprintf, @function
vfprintf:
	li	t0, 20264
	jr	t0
	.size	vfprintf, .-vfprintf
	.globl	memcpy
	.type	memcpy, @function
memcpy:
	li	t0, 22052
	jr	t0
	.size	memcpy, .-memcpy
	.globl	memmove
	.type	memmove, @function
memmove:
	li	t0, 22088
	jr	t0
	.size	memmove, .-memmove
	.globl	memset
	.type	memset, @function
memset:
	li	t0, 22148
	jr	t0
	.size	memset, .-memset
	.globl	strcmp
	.type	strcmp, @function
strcmp:
	li	t0, 22176
	jr	t0
	.size	strcmp, .-strcmp
	.globl	strcpy
	.type	strcpy, @function
strcpy:
	li	t0, 22208
	jr	t0
	.size	strcpy, .-strcpy
	.globl	strlen
	.type	strlen, @function
strlen:
	li	t0, 22236
	jr	t0
	.size	strlen, .-strlen
	.section	.sdata,"aw"
	.align	4
	.globl	_bios_crc_table_p
	.type	_bios_crc_table_p, @object
	.size	_bios_crc_table_p, 4
_bios_crc_table_p:
	.long	27772
	.globl	_bios_crc16_table_p
	.type	_bios_crc16_table_p, @object
	.size	_bios_crc16_table_p, 4
_bios_crc16_table_p:
	.long	28796
	.globl	_bios_str_1_p
	.type	_bios_str_1_p, @object
	.size	_bios_str_1_p, 4
_bios_str_1_p:
	.long	29820
	.globl	_bios_str_0_p
	.type	_bios_str_0_p, @object
	.size	_bios_str_0_p, 4
_bios_str_0_p:
	.long	29836
	.globl	_bios_esccmds_p
	.type	_bios_esccmds_p, @object
	.size	_bios_esccmds_p, 4
_bios_esccmds_p:
	.long	29852
	.globl	_bios_stderr_p
	.type	_bios_stderr_p, @object
	.size	_bios_stderr_p, 4
_bios_stderr_p:
	.long	30288
	.globl	_bios_broadcast_p
	.type	_bios_broadcast_p, @object
	.size	_bios_broadcast_p, 4
_bios_broadcast_p:
	.long	30292
	.globl	_bios_stdin_p
	.type	_bios_stdin_p, @object
	.size	_bios_stdin_p, 4
_bios_stdin_p:
	.long	30300
	.globl	_bios_stdout_p
	.type	_bios_stdout_p, @object
	.size	_bios_stdout_p, 4
_bios_stdout_p:
	.long	30304
	.globl	_bios_s_help_p
	.type	_bios_s_help_p, @object
	.size	_bios_s_help_p, 4
_bios_s_help_p:
	.long	268435472
	.globl	_bios_s_ident_p
	.type	_bios_s_ident_p, @object
	.size	_bios_s_ident_p, 4
_bios_s_ident_p:
	.long	268435488
	.globl	_bios_s_crc_p
	.type	_bios_s_crc_p, @object
	.size	_bios_s_crc_p, 4
_bios_s_crc_p:
	.long	268435504
	.globl	_bios_s_flush_cpu_dcache_p
	.type	_bios_s_flush_cpu_dcache_p, @object
	.size	_bios_s_flush_cpu_dcache_p, 4
_bios_s_flush_cpu_dcache_p:
	.long	268435520
	.globl	_bios_s_flush_l2_cache_p
	.type	_bios_s_flush_l2_cache_p, @object
	.size	_bios_s_flush_l2_cache_p, 4
_bios_s_flush_l2_cache_p:
	.long	268435536
	.globl	_bios_s_leds_p
	.type	_bios_s_leds_p, @object
	.size	_bios_s_leds_p, 4
_bios_s_leds_p:
	.long	268435552
	.globl	_bios_s_mem_list_p
	.type	_bios_s_mem_list_p, @object
	.size	_bios_s_mem_list_p, 4
_bios_s_mem_list_p:
	.long	268435568
	.globl	_bios_s_mem_read_p
	.type	_bios_s_mem_read_p, @object
	.size	_bios_s_mem_read_p, 4
_bios_s_mem_read_p:
	.long	268435584
	.globl	_bios_s_mem_write_p
	.type	_bios_s_mem_write_p, @object
	.size	_bios_s_mem_write_p, 4
_bios_s_mem_write_p:
	.long	268435600
	.globl	_bios_s_mem_copy_p
	.type	_bios_s_mem_copy_p, @object
	.size	_bios_s_mem_copy_p, 4
_bios_s_mem_copy_p:
	.long	268435616
	.globl	_bios_s_mem_test_p
	.type	_bios_s_mem_test_p, @object
	.size	_bios_s_mem_test_p, 4
_bios_s_mem_test_p:
	.long	268435632
	.globl	_bios_s_mem_speed_p
	.type	_bios_s_mem_speed_p, @object
	.size	_bios_s_mem_speed_p, 4
_bios_s_mem_speed_p:
	.long	268435648
	.globl	_bios_s_mem_cmp_p
	.type	_bios_s_mem_cmp_p, @object
	.size	_bios_s_mem_cmp_p, 4
_bios_s_mem_cmp_p:
	.long	268435664
	.globl	_bios_s_boot_p
	.type	_bios_s_boot_p, @object
	.size	_bios_s_boot_p, 4
_bios_s_boot_p:
	.long	268435680
	.globl	_bios_s_reboot_p
	.type	_bios_s_reboot_p, @object
	.size	_bios_s_reboot_p, 4
_bios_s_reboot_p:
	.long	268435696
	.globl	_bios_s_serialboot_p
	.type	_bios_s_serialboot_p, @object
	.size	_bios_s_serialboot_p, 4
_bios_s_serialboot_p:
	.long	268435712
	.globl	_bios_s_netboot_p
	.type	_bios_s_netboot_p, @object
	.size	_bios_s_netboot_p, 4
_bios_s_netboot_p:
	.long	268435728
	.globl	_bios_s_sdram_test_p
	.type	_bios_s_sdram_test_p, @object
	.size	_bios_s_sdram_test_p, 4
_bios_s_sdram_test_p:
	.long	268435744
	.globl	_bios_s_mdio_write_p
	.type	_bios_s_mdio_write_p, @object
	.size	_bios_s_mdio_write_p, 4
_bios_s_mdio_write_p:
	.long	268435760
	.globl	_bios_s_mdio_read_p
	.type	_bios_s_mdio_read_p, @object
	.size	_bios_s_mdio_read_p, 4
_bios_s_mdio_read_p:
	.long	268435776
	.globl	_bios_s_mdio_dump_p
	.type	_bios_s_mdio_dump_p, @object
	.size	_bios_s_mdio_dump_p, 4
_bios_s_mdio_dump_p:
	.long	268435792
	.globl	_bios_s_tftp_load_p
	.type	_bios_s_tftp_load_p, @object
	.size	_bios_s_tftp_load_p, 4
_bios_s_tftp_load_p:
	.long	268435808
	.globl	_bios_macadr_p
	.type	_bios_macadr_p, @object
	.size	_bios_macadr_p, 4
_bios_macadr_p:
	.long	268436188
	.globl	_bios_printed_p
	.type	_bios_printed_p, @object
	.size	_bios_printed_p, 4
_bios_printed_p:
	.long	268436200
	.globl	_bios_progress_max_p
	.type	_bios_progress_max_p, @object
	.size	_bios_progress_max_p, 4
_bios_progress_max_p:
	.long	268436204
	.globl	_bios_spin_p
	.type	_bios_spin_p, @object
	.size	_bios_spin_p, 4
_bios_spin_p:
	.long	268436208
	.globl	_bios_transfer_finished_p
	.type	_bios_transfer_finished_p, @object
	.size	_bios_transfer_finished_p, 4
_bios_transfer_finished_p:
	.long	268436212
	.globl	_bios_total_length_p
	.type	_bios_total_length_p, @object
	.size	_bios_total_length_p, 4
_bios_total_length_p:
	.long	268436216
	.globl	_bios_dst_buffer_p
	.type	_bios_dst_buffer_p, @object
	.size	_bios_dst_buffer_p, 4
_bios_dst_buffer_p:
	.long	268436220
	.globl	_bios_rx_callback_lto_priv_0_p
	.type	_bios_rx_callback_lto_priv_0_p, @object
	.size	_bios_rx_callback_lto_priv_0_p, 4
_bios_rx_callback_lto_priv_0_p:
	.long	268436224
	.globl	_bios_rxlen_p
	.type	_bios_rxlen_p, @object
	.size	_bios_rxlen_p, 4
_bios_rxlen_p:
	.long	268436228
	.globl	_bios_rxbuffer_p
	.type	_bios_rxbuffer_p, @object
	.size	_bios_rxbuffer_p, 4
_bios_rxbuffer_p:
	.long	268436232
	.globl	_bios_my_ip_p
	.type	_bios_my_ip_p, @object
	.size	_bios_my_ip_p, 4
_bios_my_ip_p:
	.long	268436236
	.globl	_bios_my_mac_p
	.type	_bios_my_mac_p, @object
	.size	_bios_my_mac_p, 4
_bios_my_mac_p:
	.long	268436240
	.globl	_bios_cached_mac_p
	.type	_bios_cached_mac_p, @object
	.size	_bios_cached_mac_p, 4
_bios_cached_mac_p:
	.long	268436248
	.globl	_bios_cached_ip_p
	.type	_bios_cached_ip_p, @object
	.size	_bios_cached_ip_p, 4
_bios_cached_ip_p:
	.long	268436256
	.globl	_bios_txbuffer_p
	.type	_bios_txbuffer_p, @object
	.size	_bios_txbuffer_p, 4
_bios_txbuffer_p:
	.long	268436260
	.globl	_bios_txlen_p
	.type	_bios_txlen_p, @object
	.size	_bios_txlen_p, 4
_bios_txlen_p:
	.long	268436264
	.globl	_bios_txslot_p
	.type	_bios_txslot_p, @object
	.size	_bios_txslot_p, 4
_bios_txslot_p:
	.long	268436268
	.globl	_bios_tab_pressed_p
	.type	_bios_tab_pressed_p, @object
	.size	_bios_tab_pressed_p, 4
_bios_tab_pressed_p:
	.long	268436272
	.globl	_bios_hist_num_p
	.type	_bios_hist_num_p, @object
	.size	_bios_hist_num_p, 4
_bios_hist_num_p:
	.long	268436276
	.globl	_bios_hist_max_p
	.type	_bios_hist_max_p, @object
	.size	_bios_hist_max_p, 4
_bios_hist_max_p:
	.long	268436280
	.globl	_bios_hist_cur_p
	.type	_bios_hist_cur_p, @object
	.size	_bios_hist_cur_p, 4
_bios_hist_cur_p:
	.long	268436284
	.globl	_bios_hist_add_idx_p
	.type	_bios_hist_add_idx_p, @object
	.size	_bios_hist_add_idx_p, 4
_bios_hist_add_idx_p:
	.long	268436288
	.globl	_bios_tx_produce_p
	.type	_bios_tx_produce_p, @object
	.size	_bios_tx_produce_p, 4
_bios_tx_produce_p:
	.long	268436292
	.globl	_bios_tx_consume_p
	.type	_bios_tx_consume_p, @object
	.size	_bios_tx_consume_p, 4
_bios_tx_consume_p:
	.long	268436296
	.globl	_bios_rx_consume_p
	.type	_bios_rx_consume_p, @object
	.size	_bios_rx_consume_p, 4
_bios_rx_consume_p:
	.long	268436300
	.globl	_bios_rx_produce_p
	.type	_bios_rx_produce_p, @object
	.size	_bios_rx_produce_p, 4
_bios_rx_produce_p:
	.long	268436304
	.globl	_bios_errno_p
	.type	_bios_errno_p, @object
	.size	_bios_errno_p, 4
_bios_errno_p:
	.long	268436308
	.globl	_bios_rx_buf_p
	.type	_bios_rx_buf_p, @object
	.size	_bios_rx_buf_p, 4
_bios_rx_buf_p:
	.long	268436312
	.globl	_bios_tx_buf_p
	.type	_bios_tx_buf_p, @object
	.size	_bios_tx_buf_p, 4
_bios_tx_buf_p:
	.long	268436440
	.globl	_bios_out_p
	.type	_bios_out_p, @object
	.size	_bios_out_p, 4
_bios_out_p:
	.long	268436568
	.globl	_bios_hist_lines_p
	.type	_bios_hist_lines_p, @object
	.size	_bios_hist_lines_p, 4
_bios_hist_lines_p:
	.long	268436632
	.globl	_bios_sl_p
	.type	_bios_sl_p, @object
	.size	_bios_sl_p, 4
_bios_sl_p:
	.long	268437272
