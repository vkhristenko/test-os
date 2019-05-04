;
; a simple boot sector program that loops forever
;

loop:
    jmp loop

mov ax, the_secret
jmp the_secret
mov cx, 0x09

the_secret:
    mov dx, 0x08

times 510-($-$$) db 0

dw 0xaa55 ; the last 2 bytes form the magic number for BIOS
