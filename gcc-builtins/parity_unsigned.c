int parity_char(unsigned char x) {
    return __builtin_parity(x);
}

int parity_int(unsigned int x) {
    return __builtin_parity(x);
}

int parity_long(unsigned long x) {
    return __builtin_parityl(x);
}

int parity_long_long(unsigned long long x) {
    return __builtin_parityll(x);
}
