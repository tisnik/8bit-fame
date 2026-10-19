#include <stdint.h>
#include <peekpoke.h>

void main(void) {
    __asm__("lda #33");
    __asm__("ldy #40*5");
clear:
    __asm__("dey");
    __asm__("sta (88), y");
    __asm__("bne %g", clear);
        
    while (1) {
    }
}
