; a boot sector that enters 32-bit protected mode
[org 0x7c00]

mov bp, 0x9000                  ; set up the stack
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm               ; Note that we never return from here!!!

jmp $

%include "my_print_functions.asm"
%include "define_gdt.asm"
%include "printing_pm.asm"
%include "switch_to_pm.asm"

[bits 32]                       ; instruct assembler to use 32 bit instrucdtions

; this is where we arrive after switching t oand initializing protected mode
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm        ; use 32-bit print routine

    jmp $                       ; hang...

; global variables
MSG_REAL_MODE: db ">>> Started in 16-bit Real Mode!",0
MSG_PROT_MODE: db ">>> Successfully landed in 32-bit Protected Mode!",0

; bootsector padding and bios magic
times 510-($-$$) db 0
dw 0xaa55
