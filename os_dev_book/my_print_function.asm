my_print_function:
    pusha                           ; push all register values onto the stack
    mov ah, 0x0e                    ; int 10/ah = 0x0e -> BIOS teletype 
    int 0x10                        ; trigger interrupt
    popa
    ret                             ; pops off the return address of the stack
                                    ; jumps to that instruction
