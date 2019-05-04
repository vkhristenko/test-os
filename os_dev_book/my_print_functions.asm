;
; print 16bit hex number
; assume: 
;   1) argument value is passed in dx reg
;   2) HEX_OUT is predefined
;
; algorithm:
;   X3X2X1X0 will be stored as X1X0X3X2
;   X3: shift by 4 bits to -> 
;       and w/ 0x0
;
print_hex_16bit:
    ; save the state of regs on stack 
    pusha

    ;
    ; fill in the template HEX_OUT
    ;

    ; X3
    mov bx, dx
    shr bx, 12                   ; shift to get X3
    and bx, 0x000f              ; we are little endian
    call choose_one_of          ; will set bh to the value used for printing
    mov [HEX_OUT + 2], bh       ; set the X3 to the HEX_OUT string

    ; X2 
    mov bx, dx
    shr bx, 8
    and bx, 0x000f
    call choose_one_of
    mov [HEX_OUT + 3], bh

    ; x1
    mov bx, dx
    shr bx, 4
    and bx, 0x000f
    call choose_one_of
    mov [HEX_OUT + 4], bh

    ; x0 
    mov bx, dx
    and bx, 0x000f
    call choose_one_of
    mov [HEX_OUT + 5], bh

    ; print the string that sits @HEX_OUT
    mov bx, HEX_OUT
    call print_string

    popa 
    ret

; template
HEX_OUT: db '0x0000',0

; use bl reg byte
choose_one_of:
    cmp bl, 0
    je choose_one_of_0
    cmp bl, 1
    je choose_one_of_1
    cmp bl, 2
    je choose_one_of_2
    cmp bl, 3
    je choose_one_of_3
    cmp bl, 4
    je choose_one_of_4
    cmp bl, 5
    je choose_one_of_5
    cmp bl, 6
    je choose_one_of_6
    cmp bl, 7
    je choose_one_of_7
    cmp bl, 8
    je choose_one_of_8
    cmp bl, 9
    je choose_one_of_9
    cmp bl, 0xa
    je choose_one_of_a
    cmp bl, 0xb
    je choose_one_of_b
    cmp bl, 0xc
    je choose_one_of_c
    cmp bl, 0xd
    je choose_one_of_d
    cmp bl, 0xe
    je choose_one_of_e
    cmp bl, 0xf
    je choose_one_of_f

    ; this is the base case if something went wrong
    mov bh, 'X'
    ret

choose_one_of_0:
    mov bh, '0'
    ret

choose_one_of_1:
    mov bh, '1'
    ret

choose_one_of_2:
    mov bh, '2'
    ret

choose_one_of_3:
    mov bh, '3'
    ret

choose_one_of_4:
    mov bh, '4'
    ret

choose_one_of_5:
    mov bh, '5'
    ret

choose_one_of_6:
    mov bh, '6'
    ret

choose_one_of_7:
    mov bh, '7'
    ret

choose_one_of_8:
    mov bh, '8'
    ret
    
choose_one_of_9:
    mov bh, '9'
    ret

choose_one_of_a:
    mov bh, 'a'
    ret

choose_one_of_b:
    mov bh, 'b'
    ret

choose_one_of_c:
    mov bh, 'c'
    ret

choose_one_of_d:
    mov bh, 'd'
    ret

choose_one_of_e:
    mov bh, 'e'
    ret

choose_one_of_f:
    mov bh, 'f'
    ret

;
; print a string
; bx contains the address of the string to print
;
print_string:
    ; save the state on stack
    pusha

    call print_string_whileloop  ; call routine to loop over all of the chars

    ; clean up
    popa
    ret

;
; while loop over all chars.
;
print_string_whileloop:
    mov cx, [bx]                ; copy a word pointed to by bx into cx
    cmp cl, 0                   ; compare with 0
    je print_string_loopstop    ; jump to finish "print_string" function
    mov al, cl                  ; if not equal to 0, populate al with cl
    call print_string_print_char; print this char
    cmp ch, 0                   ; compare with 0
    je print_string_loopstop    ; jump to finish "print_string" function
    mov al, ch                  ; if not equal to 0 populate al with ch
    call print_string_print_char; call print char subroutine
    add bx, 2                   ; increment bx by 2 -> go to the next word
    jmp print_string_whileloop  ; next iteration

;
; will execute return for `print_string_whileloop`
; and jump back to `print_string`
;
print_string_loopstop:
    ret

print_string_print_char:
    mov ah, 0x0e                    ; int 10/ah = 0x0e -> BIOS teletype 
    int 0x10                        ; trigger interrupt
    ret
