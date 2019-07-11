#include <stdio.h>

int i = 10;

void test_func() {}

int add(int a, int b) {
    return a + b;
}

int add1000() {
    int total = 0;

    for (int i=0; i<1000; i++)
        total += i;

    printf("done adding\n");

    return total;
}

void d(int d) {}
void c(int c) { d(0); }
void b(int b) { c(1); }
void a(int a) { b(2); }

int main() {
    printf("hello world!\n");
    add(1,2);

    add1000();

    a(3);

    return 0;
}
