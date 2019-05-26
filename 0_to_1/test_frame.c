#include <stdint.h>

int __attribute__((regparm(0))) add(int a, int b) {
    int i = a + b;

    return i;
}

int main() {
    add(1, 2);

    return 0;
}
