void d(int d) {}
void c(int c) { d(0); }
void b(int b) { c(1); }
void a(int a) { b(2); }

int main() {
    a(3);
    return 0;
}
