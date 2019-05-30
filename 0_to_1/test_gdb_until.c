#include <stdio.h>

int add1000() {
    int total = 0;

    for (int i=0; i<1000; ++i) {
        total += i;
    }

    printf("done adding\n");

    return total;
}

int main() {
    add1000();

    printf("hello world!\n");

    return 0;
}
