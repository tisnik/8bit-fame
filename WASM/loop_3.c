int loop(int start) {
    int i;
    int s = start;
    for (i = 0; i < 10; i++) {
        s *= 42;
    }
    return s;
}
