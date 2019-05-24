void foo(int* __restrict__ a)
{
    int i; int idx = 0;
    for (i = 0; i < 100; i++) {
        idx = 3 * i;
        a[idx] = idx;
    }
}
