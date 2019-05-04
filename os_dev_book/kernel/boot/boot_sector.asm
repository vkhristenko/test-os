; a boot sector that boots a c kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000                    ; this is the memory offset to which 
                                            ; we will load our kernel

mov [BOOT_DRIVE], dl                        ; BIOS stores our boot drive in DL,
                                            ; so it's best to remember this for later

mov bp, 0x9000                              ; set up the stack
mov sp, bp

mov bx, MSG_REAL_MODE                       ; announce that we are starting
call print_string                           ; booting from 16-bit real mode

call load_kernel                            ; load our kernel

call switch_to_pm                           ; switch to protected mode,
                                            ; from which we will not return

jmp $

; includes
%include "print/print_string.asm"
%include "disk/disk_load.asm"
%include "pm/gdt.asm"
%include "pm/print_string.asm"
%include "pm/switch_to_pm.asm"

[bits 16]

; load kernel
load_kernel:
    mov bx, MSG_LOAD_KERNEL                 ; printing a msg 
    call print_string

    ; set up parameters for our disk_load routine, so that 
    ; we load the first 15 sectors (excluding the boot sector) from the boot disk 
    ; (i.e our kernel code) to address KERNEL_OFFSET
    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret

[bits 32]
; this is where we arrive after switching to and initializing protected mode
BEGIN_PM:
    mov ebx, MSG_PROT_MODE                  ; use our 32-bit print routine to
    call print_string_pm                    ; announce we are in protected mode

    call KERNEL_OFFSET                      ; now jump to tthe addrss of our loaded 
                                            ; kernel code, assume the brace position
                                            ; and cross you fingers. here we go!

    jmp $                                            

; global variables
BOOT_DRIVE: db 0
MSG_REAL_MODE: db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL: db "Loading kernel into memory", 0

; bootsector padding
times 510-($-$$) db 0
dw 0xaa55
