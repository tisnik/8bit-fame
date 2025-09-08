#define LENGTH 32

void fp16_delta(_Float16 values[LENGTH], _Float16 delta) {
    int i;
    for (i=0; i<LENGTH; i++) {
        values[i] += delta;
    }
}

