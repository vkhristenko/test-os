;
; a boot sector that prints a string using our function
;
[org 0x7c00]                        ; tell the asm where this code will be loaded

mov bx, HELLO_MSG                   ; use bx as a parameter to our function
call print_string                   ; so we can specify the address of a string

mov bx, GOODBYE_MSG                 ; one more time
call print_string

jmp $

%include "my_print_function.asm"

; data
HELLO_MSG:
    db 'Hello, World!', 0           ; zero at the end !!!

GOODBYE_MSG:
    db 'Goodbye!',0                 ; zero at the end !!!

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55
