jmp [0x1234]
add eax, ecx
add eax, ebx
add eax, [0x1234]

jmp [eax*2 + ebx]
jmp [eax*4 + ebx]
jmp [eax*8 + ebx]
jmp [eax*4 + 0x1234]

mov eax, 0x1234
