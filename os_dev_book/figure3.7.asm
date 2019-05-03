;
; a simple boot sector program that demonstrates segment offsetting
;
mov ah, 0x0e                        ; int 10/ah = 0eh -> scrolling teletype 
                                    ; bios routine
mov al, [the_secret]
int 0x10                            ; does this print an X?

mov bx, 0x7c0                       ; can't set ds directly, so set bx
mov ds, bx                          ; then copy bx to ds
mov al, [the_secret]
int 0x10                            ; does this print an X

mov al, [es:the_secret]             ; tell the cpu to use the es (not ds) segment
int 0x10                            ; does this print an X

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10                            ; does this print an X?

jmp $                               ; jump forever

the_secret:
    db "X"

; padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
