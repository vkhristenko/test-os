; load DH sectors to ES:BX from drive DL
disk_load:
    push dx                     ; store DX on stack so later we can recall
                                ; how many sectors were requested to be read,
                                ; even if it is altered in the meantime
    mov ah, 0x02                ; BIOS read sector function
    mov al, dh                  ; read DH sectors
    mov ch, 0x00                ; select cylinder 0
    mov dh, 0x00                ; select head 0
    mov cl, 0x02                ; start reading from second sector 
                                ; (i.e. after the boot sector)
    int 0x13                    ; BIOS interrupt

    jc disk_error               ; jump if error (i.e. carry flag set)

    pop dx                      ; restore DX from the stack
    cmp dh, al                  ; if AL (sectors read) != DH (sectors expected)
    jne disk_error              ; display error msg
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; variables
DISK_ERROR_MSG: db "Disk read error!", 0
