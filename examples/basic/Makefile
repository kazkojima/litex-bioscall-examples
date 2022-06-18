TOP=../..
PROGRAM=app
SRC=main.c

include $(TOP)/common.mk

INCLUDE_DIRS+=-I $(LITEX_BUILD_PATH)/$(TARGET)/software/include -I $(TOP)/include
BIOS=$(LITEX_BUILD_PATH)/$(TARGET)/software/bios/bios.elf

all: $(PROGRAM).bin

$(PROGRAM).bin: $(PROGRAM).elf
	$(OBJCOPY) -O binary $(PROGRAM).elf $(PROGRAM).bin

$(PROGRAM).elf: $(SRC) $(TOP)/lib/stubs.s
	$(CC) $(CFLAGS) $(INCLUDE_DIRS) $(CRT_FLAGS) $(SRC) -o $(PROGRAM).elf $(LDFLAGS)

genstubs: $(TOP)/lib/stubs.s

$(TOP)/lib/stubs.s: $(BIOS)
	julia $(TOP)/tools/genstubs.jl $(BIOS) $(TOP)/lib/stubs.s

clean:
	rm -rf $(PROGRAM).elf $(PROGRAM).bin
