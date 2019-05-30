#include <stdio.h>

static void some_func() {
    printf("%s\n", __FUNCTION__);
}

int i = 10;

int main() {
    printf("hello world!\n");
    some_func();
    return 0;
}
