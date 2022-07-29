TOP=../..
PROGRAM=app
SRC=main.c lwipif.c

include $(TOP)/common.mk

LWIPDIR=$(TOP)/modules/lwip/src

include $(LWIPDIR)/Filelists.mk

LWIPSRC= $(COREFILES) \
        $(CORE4FILES) \
        $(APIFILES) \
        $(filter-out $(LWIPDIR)/netif/slipif.c,$(NETIFFILES))

INCLUDE_DIRS+=-I $(LITEX_BUILD_PATH)/$(TARGET)/software/include -I $(TOP)/include -I $(LWIPDIR)/include -I ./arch -I .
BIOS=$(LITEX_BUILD_PATH)/$(TARGET)/software/bios/bios.elf

all: $(PROGRAM).bin

$(PROGRAM).bin: $(PROGRAM).elf
	$(OBJCOPY) -O binary $(PROGRAM).elf $(PROGRAM).bin

$(PROGRAM).elf: $(SRC) $(TOP)/lib/stubs.s
	$(CC) $(CFLAGS) $(INCLUDE_DIRS) $(CRT_FLAGS) $(SRC) $(LWIPSRC) -o $(PROGRAM).elf $(LDFLAGS)

genstubs: $(TOP)/lib/stubs.s

$(TOP)/lib/stubs.s: $(BIOS)
	julia $(TOP)/tools/genstubs.jl $(BIOS) $(TOP)/lib/stubs.s

clean:
	rm -rf $(PROGRAM).elf $(PROGRAM).bin

cleanall:
	rm -rf $(PROGRAM).elf $(PROGRAM).bin $(TOP)/lib/stubs.s
