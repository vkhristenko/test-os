#include <stdio.h>
#include <stdint.h>

uint32_t x = 0xfffu;
static uint32_t x_statis = 0xfffu;
char *str = "ABCDEF";

void my_function() {}

__attribute__((weak)) int add(int a, int b) {
    printf("warning function is not implemented\n");
    return 0;
}

static void my_function_1() {}

int main() {
    printf("hello world\n");

    int c = add(1, 2);
    printf("c = %d\n", c);

    return 0;
}
