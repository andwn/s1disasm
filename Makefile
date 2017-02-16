GENDEV?=/opt/toolchains/gen/
GENGCC_BIN=$(GENDEV)/m68k-elf/bin
GENBIN=$(GENDEV)/bin

AS = $(GENGCC_BIN)/m68k-elf-as
LD = $(GENGCC_BIN)/m68k-elf-ld
OBJC = $(GENGCC_BIN)/m68k-elf-objcopy 

AFLAGS = -m68000 --register-prefix-optional --bitwise-or
LFLAGS = -T md.ld -nostdlib

all: sonic.bin

sonic.o: 
	$(AS) $(AFLAGS) sonic.asm -o $@

sonic.elf: sonic.o
	$(LD) -o $@ $(LFLAGS) sonic.o

sonic.bin: sonic.elf
	$(OBJC) -O binary $< temp.bin
	dd if=temp.bin of=$@ bs=8K conv=sync

clean:
	rm -f sonic.o sonic.elf temp.bin
