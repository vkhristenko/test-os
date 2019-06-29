main:
    jmp main
    jmp main2
    jmp main

main2:
    jmp 0x1234
    jmp 0x0001

jmp [0x1234]
jmp [eax]
jmp far [eax]
jmp 0x5678:0x1234
