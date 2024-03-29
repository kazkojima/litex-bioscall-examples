[> Intro
--------

LiteX bios call examples. Two small examples "basic" and "ad9874iq" are given in examples dir. These applications use LiteX bios functions which give the elementary functions like UART read/write, printf and other basic IO functions.
Another example "mandelbloat" is the example taken from tutorial of [Bruno Levy's learn-fpga](https://github.com/BrunoLevy/learn-fpga.git). That example has its own LICENSE.

This is done by analyzing objects in bios program with the tool like nm. Then the addresses of functions can be seen and we can call them. The bad news is that it's not the case for all functions. [The process is a bit complicated.](https://github.com/kazkojima/litex-bioscall-examples/blob/main/doc/process.pdf)

Modern compiler technology sometimes performs optimizations which replace functions with other functions when possible and inline functions into other functions. For example, there is foo(x, y) function and assume that all the usage of foo(x, y) happen with x=1. If the compiler believes so, then it can replace foo(x,y) with foo1(y) which is essentially foo(1,y), as the compiled code of foo(1,y) is often simpler than that of foo(x,y). Since this optimization requires to know all usages of foo, all source files including library have to be seen if the function is not static, i.e., this requires "whole program optimization". gcc&clang can do such optimizations with -flto.

LiteX bios is build with -flto and some functions are inlined or replaced even if they are non-static. As the result, some useful functions are missing or replaced with modified functions. For example, udp_send is modified as udp_send.constprop.0.isra.0. "constprop" and "isra" are the name of optimizations.

Unfortunately, the result of compile is rather unstable - affected by slight changes of code, compiler flags and compiler itself.

The function F in bios is renamed to _bios_F to avoid conflicting with other liblaries, except some UART functions which will be called from libc.

The non-functional objects in bios are free from LTO issue. From an example app, their address can be referenced as _bios_symbolname_p. For example, _bios_txbuffer_p is the address of txbuffer in bios. Thus
```
extern void **_bios_txbuffer_p;

  ethernet_buffer *txbuffer = *_bios_txbuffer_p;
```
reproduces the original txbuffer in app. See ad9874iq example.

[> Updates
----------

[> Features
-----------
**TODO**

[> Getting started
------------------
**TODO**

Prerequisites: LiteX, riscv toolchain, julia lang, ...

```
cd exapmles/basic
make
```

makes app.bin which can be booted from LiteX bios with serial/SD/net-boot.

A few assumtions are hard-coded as the first several lines in common.mk. Fix them for you.

* LITEX_PATH: is the path where litex(https://github.com/enjoy-digital/litex) is installed.
* LITEX_BUILD_PATH: is the path which your litex target build directory.
* TARGET: litex target name

bios.elf should be built already as LITEX_BUILD_PATH/TARGET/software/bios/bios.elf.

* OBJCOPY, CC: cross toolchains. Adjust according to your cross target arch.
* CFLAGS: Also adjust for your target CPU.

[> Tips
--------
**TODO**

Here is an experimental patch to the litex with which bios can be built without -flto.

```
diff --git a/litex/soc/software/common.mak b/litex/soc/software/common.mak
index e7ffe9b2..6987b113 100644
--- a/litex/soc/software/common.mak
+++ b/litex/soc/software/common.mak
@@ -54,7 +54,10 @@ INCLUDES = -I$(PICOLIBC_DIRECTORY)/newlib/libc/tinystdio \
            -I$(BUILDINC_DIRECTORY) \
            -I$(BUILDINC_DIRECTORY)/../libc \
            -I$(CPU_DIRECTORY)
-COMMONFLAGS = $(DEPFLAGS) -Os $(CPUFLAGS) -g3 -fomit-frame-pointer -Wall -fno-builtin -fno-stack-protector -flto $(INCLUDES)
+COMMONFLAGS = $(DEPFLAGS) -Os $(CPUFLAGS) -g3 -fomit-frame-pointer -Wall -fno-builtin -fno-stack-protector $(INCLUDES)
+ifneq ($(NOLTO),1)
+COMMONFLAGS += -flto
+endif
 ifneq ($(CPUFAMILY), arm)
 COMMONFLAGS += -fexceptions
 endif

```

For example,
```
NOLTO=1 ./colorlite_i5.py ... --build
```
makes non LTOed bios when building the bit stream for colorlite_i5. Without NOLTO=1, a normal build will be done.

[> Tests
--------
**TODO**

[> Links
--------
**TODO**

* [LiteX](https://github.com/enjoy-digital/litex)
* [learn-fpga](https://github.com/BrunoLevy/learn-fpga.git)
* [AD9874IQ](https://github.com/kazkojima/ad9874iq)
