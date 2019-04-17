mov bx, 0

cmp bx, 4                           ; compare bx content with 4
jle then_block                      ; if bx <= 4 jump to then_block
cmp bx, 40                          ; compare bx with 40
jl else_if_then_block               ; if bx < 40 jump to else if then block
mov al, 'C'                         ; else block if others are false
jmp the_end                         ; make sure we skip then and else if blocks

then_block:
    mov al, 'A'                     ; do the operation
    jmp the_end                     ; jump to the_end label to avoid else if then

else_if_then_block:
    mov al, 'B'

the_end:                            ; label to jump to after the control structures

mov ah, 0x0e                        ; int 10/ah = 0x0e -> BIOS teletype 
int 0x10                            ; trigger interrupt

jmp $                               ; infinite loop
                                    ; same as 
                                    ; infinite_loop:
                                    ;   jmp infinite_loop

; padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
