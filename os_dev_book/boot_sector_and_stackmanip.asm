;
; a simple boot sector program that demonstrates the stack
;
mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine

mov bp, 0x8000 ; set the base of the stack a little above where BIOS lodds
mov sp, bp     ; our boot sector - so it won't overwrite us

push 'A' ; pushed as 16 bit per character (0x00 prepended)
push 'B'
push 'C'

pop bx              ; we can only pop 16-bits so pop to bx
mov al, bl          ; then copy bl (8bit char) to al
int 0x10            ; trigger interrupt - print (al)

pop bx              ; pop the next value
mov al, bl          ; copy 8bit char to al
int 0x10            ; trigger interruprt - print (al)

mov al, [0x7ffe]    ; to prove our stack grows downwards from bp,
                    ; fetch the char at 0x8000 - 0x2 (16 bits)
int 0x10            ; trigger interrupt - print (al)

jmp $               ; forever jump

; pad and magic BIOS number

times 510-($-$$) db 0
dw 0xaa55
