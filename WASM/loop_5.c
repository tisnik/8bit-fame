void print(double);

void nested_loops(void) {
    double x, y;
    for (y = 1; y <= 10; y++) {
        for (x = 1; x <= 10; x++) {
            print(x * y);
        }
    }
}
