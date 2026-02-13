int bar(int x);
int baz(int x);

int foo(int x) {
    return x < 42 ? bar(x) : baz(x);
}
