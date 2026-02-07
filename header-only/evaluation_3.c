#include <stdio.h>
#include <stdlib.h>

#include "ceval.h"

int main(void) {
    static char expression[] = "(3-20)*(14+20)+20*(14-3+20)";
    double result = ceval_result(expression);
    printf("Result=%f\n", result);
    return 0;
}

