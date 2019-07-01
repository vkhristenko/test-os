#include <stdint.h>

uint8_t a8[2] = { 0x12, 0x34 };
uint16_t a16[2] = { 0x1234, 0x5678 };
uint16_t a16_3values[3] = { 0x1234, 0x5678, 0x9abc };
uint32_t a32[2] = { 0x12345678, 0x9abcdef0 };
uint64_t a64[2] = { 0x123456789abcdef0, 0x123456789abcdef0 };

uint8_t a8_2[2][2] = {
    {0x12, 0x34},
    {0x56, 0x78}
};

uint8_t a8_3[2][2][2] = {
    {
        {0x12, 0x34},
        {0x56, 0x78}
    },
    {
        {0x9a, 0xbc},
        {0xde, 0xff}
    }
};

int main() {
    return 0;
}
