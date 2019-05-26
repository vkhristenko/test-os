#include <stdio.h>

static int global_static_var = 0;

static void local_func() {}


__attribute__((weak)) int add(int a, int b) {
    printf("warning: function is not implemented.\n");
    return 0;
}

__attribute__((constructor(102))) static void init1() {
    printf("%s\n", __FUNCTION__);
}

__attribute__((constructor(101))) static void init2() {
    printf("%s\n", __FUNCTION__);
}

__attribute__((destructor)) static void deinit1() {
    printf("%s\n", __FUNCTION__);
}

static void init3() {
    printf("%s\n", __FUNCTION__);
}

static void deinit3() {
    printf("%s\n", __FUNCTION__);
}

static void preinit1() {
    printf("%s\n", __FUNCTION__);
}

typedef void (*preinit_func)();
typedef void (*init3_func)();
__attribute__((section(".preinit_array"))) preinit_func preinit_arr[1] = {preinit1};
__attribute__((section(".init_array"))) init3_func init_arr[1] = {init3};
__attribute__((section(".fini_array"))) init3_func fini_arr[1] = {deinit3};

int main() {
    static int local_static_var = 0;

    printf("hello world\n");

    printf("add(1, 2) is %d\n", add(1,2));
    return 0;
}
