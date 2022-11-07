LITEX_PATH=~/LiteX/litex
LITEX_BUILD_PATH ?=~/LiteX/litex-boards/litex_boards/targets/build
TARGET ?=colorlight_i5

OBJCOPY=riscv32-unknown-elf-objcopy
CC=riscv32-unknown-elf-gcc

CFLAGS=-march=rv32im2 -mabi=ilp32 -O2

INCLUDE_DIRS=-I $(LITEX_PATH)/litex/soc/cores/cpu/vexriscv -I $(LITEX_PATH)/litex/soc/software/include

CRT_FLAGS=-nostartfiles -nolibc $(TOP)/lib/start.c $(TOP)/lib/stubs.s
LDFLAGS=-L $(LITEX_BUILD_PATH)/$(TARGET)/software/libc -lc -T $(TOP)/lib/app.ld
