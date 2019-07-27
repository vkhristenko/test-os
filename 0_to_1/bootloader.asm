; ****************************
; bootloader.asm
; a simple bootloader
; ****************************
org 0x7c00
bits 16
start: jmp boot

;; constant and variable definitions
msg db "Welcome to my operating system", 0x0a, 0x0d, 0x0

boot:
    cli         ; no interrupts
    cld         ; all that we need to init

    mov ax, 0x50

    ;; set the buffer
    mov es, ax
    xor bx, bx

    mov al, 2   ; read 2 sectors
    mov ch, 0   ; track number 0
    mov cl, 2   ; sector to read
    mov dh, 0   ; head number
    mov dl, 0   ; drive number

    mov ah, 0x02    ; read sectors from disk routine
    int 0x13        ; call the bios routine
    jmp 0x50:0x0    ; jump and exectute the sector

    hlt             ; halt the system

; we have to be 512 bytes. clear the rest of the bytes with 0
times 510 - ($-$$) db 0
dw 0xaa55       ; boot signature
