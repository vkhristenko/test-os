#include <stdio.h>

int main() {
    asm("int 3");
    printf("hello world\n");
    return 0;
}
