.PHONY: clean

all: os_image

# run qemu 
run: os_image
	qemu-system-i386 --fda os_image

# this is the actual disk image that the computer loads,
# which is the combination of our compiled bootsector and kernel
os_image: boot_sector.bin kernel.bin
	cat $^ > os_image

# build the kernel binary 
# - the kernel entry
# - compiled c kernel
kernel.bin : kernel_entry.o kernel.o
	ld -o kernel.bin -m elf_i386 -Ttext 0x1000 $^ --oformat binary

# build the kernel object file
kernel.o: kernel.c
	gcc -ffreestanding -m32 -c $< -o $@

# build the kernel entry object file
kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

# assemble the boot sector to raw machine code
#   the -I options tells nasm where to find our useful assembly
#   routines that we include in boot_sector.asm
boot_sector.bin: boot_sector.asm
	nasm $< -f bin -I "./" -o $@

clean:
	rm -rf *.o *.bin *.dis os_image *.map

# disassemble our c kernel - might be useful for debugging
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
