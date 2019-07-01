#include <stdint.h>

uint32_t i = 0x12345678;

int add(int i, int j) { return i + j; }
int sub(int i, int j) { return i - j; }
int mul(int i, int j) { return i * j; }
int div(int i, int j) { return i / j; }

int mod(int i, int j) { return i % j; }
int neg(int i) { return -i; }
int andd(int i, int j) { return i & j; }
int orr(int i, int j) { return i | j; }
int xorr(int i, int j) { return i ^ j; }
int nott(int i) { return ~i; }
int shl(int i) { return i << 8; }
int shr(int j) { return j >> 8; }
int divby2(int j) { return j / 2; }

char equal1(int i, int j) { return i == j; }
int equal2(int i, int j) { return i == j; }
char greater(int i, int j) { return i > j; }
char less(int i, int j) { return i > j; }
char greater_equal(int i, int j) { return i>=j; }
char less_equal(int i, int j) { return i <= j; }
int logical_and(int i, int j) { return i && j; }
int inc_suf(int i) { return i++; }
int inc_pref(int i) { return ++i; }
int dec_suf(int i) { return i--; }
int dec_pref(int i) { return --i; }

int main() {
    int j = i;
    int k = 0xabcdef;

    return 0;
}
