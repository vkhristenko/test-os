#include <stdio.h>

int add(int a, int b) {
    int local = 0x12345;

    return a + b;
}

int main() {
    add(1, 2);

    return 0;
}
