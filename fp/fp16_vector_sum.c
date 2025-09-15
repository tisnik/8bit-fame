typedef _Float16 float16x8 __attribute__((vector_size(16)));


_Float16 sum1(float16x8 x)
{
    _Float16 sum = 0.0;
    int i;
    for (i=0; i<8; i++) {
        sum += x[i];
    }
    return sum;
}

_Float16 sum2(float16x8 x)
{
    return x[0] + x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7];
}


