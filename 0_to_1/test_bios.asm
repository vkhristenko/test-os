; store sector content in the buffer 10ff:0000
mov dx, 0x10ff
mov es, dx
xor bx, bx
mov al, 2           ; read 2 sectors
mov ch, 0           ; read track 0
mov cl, 2           ; read 2nd sector
mov dh, 0           ; head number
mov dl, 0           ; driver number .drive 0 is floppy drive
mov ah, 0x02        ; read floppy sector function
int 0x13            ; call bios - read the sector
