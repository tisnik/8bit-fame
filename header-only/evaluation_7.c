#include <stdlib.h>

#include "ceval.h"

int main(void) {
    static char expression[] = "(3-20)*(14+20)+20*(14-3+20)";
    ceval_tree(expression);
    return 0;
}

