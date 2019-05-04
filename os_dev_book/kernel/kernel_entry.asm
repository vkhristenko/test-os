; ensures that we jump straight into the kernel's entry function
[bits 32]                   ; we are in protected mode by now, so use 32-bit insts
[extern main]               ; declare that we will be referencing the external symbol
                            ; 'main', so the linker can substitue the final address

call main                   ; invoke main() in our C kernel
jmp $
