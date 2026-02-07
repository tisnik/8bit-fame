#include <stdlib.h>

#include "ceval.h"

int main(void) {
    static char expression[] = "1+2*3";
    ceval_tree(expression);
    return 0;
}

