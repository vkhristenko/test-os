;
; a simple boot sector that prints a message to the screen using bios routines
;
mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype bios routine

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10 
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $ ; jump to the current address

; pad and magic BIOS number
times 510-($-$$) db 0

dw 0xaa55 ; the last 2 bytes form the magic number for BIOS
