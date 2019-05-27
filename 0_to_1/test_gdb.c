#include <stdio.h>

static void some_func() {
    printf("%s\n", __FUNCTION__);
}

int i = 10;

int main() {
    printf("hello world!\n");
    return 0;
}
