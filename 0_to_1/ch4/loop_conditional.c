#include <stdio.h>

void test() {
    int i=0;
    while (i<10) {
        int j = i;
        i = ++j;
    }
}

void test1(int argc) {
    int i = 0;

    if (argc)
        i = 1;
    else 
        i = 0;
}

void test2(int argc) {
    int i = argc ? 0 : 5;
}

int main() {
    for (int i=0; i<10; i++) {}

    return 0;
}
