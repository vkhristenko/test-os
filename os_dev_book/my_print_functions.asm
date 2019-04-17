;
; print 16bit hex number
;
print_hex_16bits:
    ; save the state of regs on stack 
    pusha

    mov bx, HEX_OUT

    popa 
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
