MARSDEV ?= ${HOME}/mars
MARSBIN  = $(MARSDEV)/m68k-elf/bin
TOOLSBIN = $(MARSDEV)/bin

CC   = $(MARSBIN)/m68k-elf-gcc
AS   = $(MARSBIN)/m68k-elf-as
LD   = $(MARSBIN)/m68k-elf-ld
NM   = $(MARSBIN)/m68k-elf-nm
OBJC = $(MARSBIN)/m68k-elf-objcopy

# Some files needed are in a versioned directory
GCC_VER := $(shell $(CC) -dumpversion)

# Need the LTO plugin so NM can dump our symbol table
PLUGIN   = $(MARSDEV)/m68k-elf/libexec/gcc/m68k-elf/$(GCC_VER)
LTO_SO   = liblto_plugin.so
ifeq ($(OS),Windows_NT)
	LTO_SO = liblto_plugin-0.dll
endif

INCS    = -Ic_src
LIBS    = -L$(MARSDEV)/m68k-elf/lib/gcc/m68k-elf/$(GCC_VER) -lgcc
CCFLAGS = -Wall -Wextra -O3 -std=c99 -fomit-frame-pointer -fshort-enums -fno-builtin \
			-flto -fuse-linker-plugin -fno-web -fno-gcse -fno-unit-at-a-time -fcommon
ASFLAGS = -m68000 --register-prefix-optional --bitwise-or
LDFLAGS = -T $(MARSDEV)/ldscripts/md.ld -nostdlib

all: sonic.bin symbol.txt

symbol.txt: sonic.bin
	$(NM) --plugin=$(PLUGIN)/$(LTO_SO) -n sonic.elf > symbol.txt

sonic.o: 
	$(AS) $(ASFLAGS) sonic.asm -o $@

sonic.elf: sonic.o
	$(LD) -o $@ $(LDFLAGS) sonic.o

sonic.bin: sonic.elf
	$(OBJC) -O binary $< temp.bin
	dd if=temp.bin of=$@ bs=8K conv=sync
	#wine fixheadr.exe sonic.bin

clean:
	rm -f sonic.o sonic.elf temp.bin symbol.txt
