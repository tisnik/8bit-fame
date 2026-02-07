#include <stdlib.h>

#include "ceval.h"

int main(void) {
    static char expression[] = "sin(deg2rad(45))";
    ceval_tree(expression);
    return 0;
}

