[> Intro
--------

LiteX bios call examples. Two small examples "basic" and "ad9874iq" are given in examples dir. These applications use LiteX bios functions which give the elementary functions like UART read/write, printf and other basic IO functions.

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
* [AD9874IQ](https://github.com/kazkojima/ad9874iq)


