typedef _Float16 float16x16 __attribute__((vector_size(32)));

float16x16 add(float16x16 x, float16x16 y)
{
    return x+y;
}
