CC	:= gcc
CFLAGS	:= -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc -fno-stack-protector  -c
LDFLAGS := -m $(shell $(LD) -V | grep elf_i386 2>/dev/null)
LDFLAGS	+= -nostdlib

.PHONY : all
all : BIN SIGN MakeIMG	

MakeIMG:
	objdump -S boot > boot.asm
	objcopy -S -O binary boot boot.out
	./sign boot.out bootblock
	dd if=/dev/zero of=floppy.img count=10000
	dd if=bootblock of=floppy.img conv=notrunc

BIN : boot.S
	$(CC) $(CFLAGS) -o boot.o $^
	ld $(LDFLAGS) -N -e start -Ttext 0x7C00 boot.o -o boot

# need add boot sign to binary file
SIGN: sign.c
	$(CC) $^ -o sign

qemu:
	qemu-system-i386 -serial mon:stdio -hda floppy.img

clean:
	rm  -f boot.o boot boot.out floppy.img sign


