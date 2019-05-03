; read some sectors from the boot disk using our disk read function
[org 0x7c00]

mov [BOOT_DRIVE], dl                    ; BIOS stores our boot drive in DL
                                        ; so it's best to remember that

mov bp, 0x8000                          ; here we set our stack safely out of the way
mov sp, bp

mov bx, 0x9000                          ; load 5 sectors to 0x0000(ES):0x9000(BX)
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load                    

mov dx, [0x9000]                        ; print out the first loaded word, which
call print_hex_16bit                    ; we expect to be 0xdada, stored
                                        ; at address 0x9000

mov dx, [0x9000 + 512]                  ; also, print the first word from the 2nd
call print_hex_16bit                    ; loaded sector: should be 0xface

jmp $

%include "my_print_functions.asm"
%include "disk_load.asm"

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55

; we know that BIOS will load only the first 512-byte sector from the disk,
; so if we purposely add a few more sectors to our code by repeating some familiar 
; numbers, we can prove that we actuallyed loaded those additional 2 sectors from the
; disk we booted from
times 256 dw 0xdada
times 256 dw 0xface
