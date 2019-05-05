#include "kernel/util.h"

void memory_copy(char* src, char* dst, int no_bytes) {
    int i = 0;
    for (; i<no_bytes; i++)
        *(dst+i) = *(src+i);
}
