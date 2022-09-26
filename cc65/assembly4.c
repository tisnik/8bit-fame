unsigned char a;
unsigned char b;
unsigned char c;

void main(void)
{
    __asm__ ("lda %v", a);
    __asm__ ("clc");
    __asm__ ("adc %v", b);
    __asm__ ("sta %v", c);
}
