#include <stdio.h>
#include <stdint.h>

struct bit_field {
    int data1:8;
    int data2:8;
    int data3:8;
    int data4:8;
};

struct bit_field_test {
    int data1:8;
};

struct bit_field_test bf_test = {
    .data1 = 0x1234,
};

struct bit_field2 {
    int data1:8;
    int data2:8;
    int data3:8;
    int data4:8;
    char data5:4;
};

struct bit_field2_test {
    int data1:8;
    int data2:32;
};

struct bit_field2_test bf2_test = {
    .data1 = 0x34,
    .data2 = 0x9abcdef0
};

struct normal_struct {
    int data1;
    int data2;
    int data3;
    int data4;
};

struct normal_struct ns = {
    .data1 = 0x12345678,
    .data2 = 0x9abcdef0,
    .data3 = 0x12345678,
    .data4 = 0x9abcdef0,
};

int i = 0x12345678;

struct bit_field bf = {
    .data1 = 0x12,
    .data2 = 0x34,
    .data3 = 0x56,
    .data4 = 0x78,
};

struct bit_field2 bf2 = {
    .data1 = 0x12,
    .data2 = 0x34,
    .data3 = 0x56,
    .data4 = 0x78,
    .data5 = 0xf
};

int main(int argc, char *argv[]) {
    printf("size of bit_field = %lu\n", sizeof(struct bit_field));
    printf("size of bit_field2 = %lu\n", sizeof(struct bit_field2));

    return 0;
}
