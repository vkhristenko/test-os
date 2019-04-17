mov bx, 0

;mov bp, 0x8000                      ; set the address of the stack's base pointer
                                    ; we assign stack a bit above where our
                                    ; boot sector gets loaded
;mov sp, bp                          ; top of the stack: stack pointer

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
call my_print_function              ; call the 'print_function' routine
                                    ; push return address (next instruction) 
                                    ; on to the stack
                                    ; jmp to the label

mov al, 'B'                          ; lower byte copy to al
call my_print_function                 ; print 
mov al, 'C'                         
call my_print_function

jmp $                               ; infinite loop
                                    ; same as 
                                    ; infinite_loop:
                                    ;   jmp infinite_loop

%include "my_print_function.asm" 

; padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
