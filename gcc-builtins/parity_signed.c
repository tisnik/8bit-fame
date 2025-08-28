int parity_char(signed char x) {
    return __builtin_parity(x);
}

int parity_int(signed int x) {
    return __builtin_parity(x);
}

int parity_long(signed long x) {
    return __builtin_parityl(x);
}

int parity_long_long(signed long long x) {
    return __builtin_parityll(x);
}
