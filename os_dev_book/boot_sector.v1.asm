[org 0x7c00]
;
; a simple boot sector program that demonstrates addressing
;

mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine

; first attempt
mov al, the_secret
int 0x10 ; does this print an X?

; second attempt
mov al, [the_secret]
int 0x10 ; does this print an X

; third attempt 
; this guy does not work if there is [org 0x7c00] upfront.
; the_secret points to 0x7c00 + offset of the label
; check with objdump -D -M intel -b binary -m i8086
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10 ; does this print an X?

; fourth attempt
mov al, [0x7c1d]
int 0x10 ; does this print an X?

jmp $

the_secret:
    db "XYZ"

; pad and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
