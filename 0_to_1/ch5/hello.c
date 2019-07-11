#include <stdio.h>
#include <stdint.h>

uint32_t x = 0xfffu;
static uint32_t x_statis = 0xfffu;
char *str = "ABCDEF";

void my_function() {}

__attribute__((weak)) int add(int a, int b) {
    printf("warning function is not implemented\n");
    return 0;
}

__attribute__((constructor(102))) static void init1() {
    printf("%s\n", __FUNCTION__);
}

__attribute__((constructor(101))) static void init2() {
    printf("%s\n", __FUNCTION__);
}

static void another_init1() {
    printf("%s\n", __FUNCTION__);
}

static void another_init2() {
    printf("%s\n", __FUNCTION__);
}

void preinit1() {
    printf("%s\n", __FUNCTION__);
}

void preinit2() {
    printf("%s\n", __FUNCTION__);
}

typedef void (*preinit)();
typedef void (*init)();

__attribute__((section(".init_array"), aligned(sizeof(void*)))) init init_arr[2] = {another_init1, another_init2};
__attribute__((section(".preinit_array"), aligned(sizeof(void*)))) preinit preinit_arr[2] = {preinit1, preinit2};

static void my_function_1() {}

__attribute__((destructor)) static void destructor1() {
    printf("%s\n", __FUNCTION__);
}

__attribute__((destructor)) static void destructor2() {
    printf("%s\n", __FUNCTION__);
}

void deinit1() {
    printf("%s\n", __FUNCTION__);
}

void deinit2() {
    printf("%s\n", __FUNCTION__); 
}

__attribute__((section(".fini_array"), aligned(sizeof(void*)))) init fini_arr[2] = {deinit1, deinit2};

void func1() {
    printf("%s\n", __FUNCTION__);
}
typedef void (*func_type)();
__attribute__((section(".some_section"), aligned(sizeof(void*)))) func_type func_arr[1] = {func1};

int main() {
    printf("hello world\n");

    int c = add(1, 2);
    printf("c = %d\n", c);

    return 0;
}
