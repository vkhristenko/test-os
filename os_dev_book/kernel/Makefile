.PHONY: clean

all: os_image

# run qemu 
test-qemu: os_image
	qemu-system-i386 --fda os_image

# automatically expand to a list of existing files that match the patterns
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO make sources dep on all header files

# create a list of object files to build
OBJ = ${C_SOURCES:.c=.o}

# this is the actual disk image that the computer loads,
# which is the combination of our compiled bootsector and kernel
os_image: boot/boot_sector.bin kernel.bin
	cat $^ > os_image

# build the kernel binary 
# - the kernel entry
# - compiled c kernel
kernel.bin : kernel/kernel_entry.o ${OBJ}
	ld -o kernel.bin -m elf_i386 -Ttext 0x1000 $^ --oformat binary

# generic rule for compiling c code to an object file
# TODO: header deps
%.o : %.c
	gcc -m32 -I "./" -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

# assemble the boot sector to raw machine code
#   the -I options tells nasm where to find our useful assembly
#   routines that we include in boot_sector.asm
%.bin : %.asm
	nasm $< -f bin -I 'boot/' -o $@

clean:
	rm -rf *.o *.bin *.dis os_image *.map
	rm -rf kernel/*.o boot/*.bin drivers/*.o

# disassemble our c kernel - might be useful for debugging
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
