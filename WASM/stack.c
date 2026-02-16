int return_constant() {
    return 42;
}

int x(int);

int call_x(int a) {
    return x(a);
}

int first(int a, int b) {
    return a;
}

int second(int a, int b) {
    return b;
}

int try_return(int a) {
    if (a < 0) {
        return 42;
    }
    return 9999;
}
