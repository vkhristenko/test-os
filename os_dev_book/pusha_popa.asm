some_function:
    pusha                               ; push all register values to the stack
    mov bx, 10
    add bx, 20
    mov ah, 0x0e
    int 0x10                            ; print the character in al
    popa
    ret
