#include <peekpoke.h>

#define COLOR2 0x02C6

void main(void) {
    POKE(COLOR2, 0x42);

    while (1) {
    }
}
