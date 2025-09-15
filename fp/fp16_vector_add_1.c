typedef _Float16 float16x8 __attribute__((vector_size(16)));

float16x8 add(float16x8 x, float16x8 y)
{
    return x+y;
}
