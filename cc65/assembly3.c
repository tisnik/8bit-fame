void main(void)
{
    register unsigned char a;
    register unsigned char b;
    register unsigned char c;


    __asm__ ("lda %v", a);
    __asm__ ("clc");
    __asm__ ("adc %v", b);
    __asm__ ("sta %v", c);
}
