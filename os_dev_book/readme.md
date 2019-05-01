# OS Dev book notes

## browsing binaries
- hexdump
- od with `od -t x1 -A n <binary>`

## QEMU
- Boot Sector start up from a floppy 
```
qemu-system-x86_64 --fda question4.bin 
```

## Assembler CLI options
- assemble raw binary `nasm boot sect.asm -f bin -o boot sect.bin`

## Question 5: print 16 hex

