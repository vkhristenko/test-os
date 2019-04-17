;
; 
;
cmp ax, 4               ; compare the value in ax to 4
                        ; the result of cmp is stored in cpu's special flags reg
je then_block           ; jump to then_block if they were equal
mov bx, 45              ; otherwise, execute this code
jmp the_end             ; important: jump over the 'then' block,
                        ; so we do not also execute that code

; jump instructions based on cmp x, y
; je target
; jne target
; jl target
; jle target
; jg target
; jge target

then_block:
    mov bx, 23

the_end:

cmp [ah], 0
