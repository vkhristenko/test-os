;
; a boot sector that prints a 16 hex using our printing functions
;
[org 0x7c00]                                    ; tell the asm where this code will 
                                                ; be loaded in memory

mov dx, 0x1fb6
call print_hex_16bit
                                                
jmp $

%include "my_print_functions.asm"

; padding and magic bios number
times 510-($-$$) db 0 
dw 0xaa55
