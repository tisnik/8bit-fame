typedef _Float16 float16x8 __attribute__((vector_size(16)));

float16x8 add_delta(float16x8 x, _Float16 delta)
{
    return x+delta;
}
