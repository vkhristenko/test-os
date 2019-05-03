mov ah, 0x02                ; bios read sector function

mov dl, 0                   ; read drive 0 (i.e. first floppy drive)
mov ch, 3                   ; select cylinder 3
mov dh, 1                   ; select the track on 2dn side of floppy
                            ; disk, since this count has a base of 0
mov cl, 4                   ; select the 4th sector on the track - not
                            ; the 5th, since this has a base of 1
mov al, 5                   ; read 5 sectors from the start point

; lastly, set the address that we would like bios to read the sectors to,
; which bios expects to find in es:bx
; (i.e. segment es with offset bx)
mov bx, 0xa000              ; indirectly set es to 0xa000
mov es, bx
mov bx, 0x1234              ; set bx to 0x1234

; in our case, data will be read to 0xa000:0x1234,
; which the cpu will translate to physical address 0xa1234

int 0x13                    ; now issue the bios interrupt to do the actual read

jc disk_error               ; jc is another jumping instruction, that jumps
                            ; only if the carry flag was set

; this jumps if what bios reported as the number of sectors
; actually read in al is not equal to the number we expected
cmp al, <no. sectors expected>
jne disk_error

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; global variables
DISK_ERROR_MSG: db "Disk read error!",0
