void main(void)
{
    register unsigned char a;

    __asm__ ("lda #1");
    __asm__ ("clc");
    __asm__ ("adc #2");
    __asm__ ("sta %v", a);
}
