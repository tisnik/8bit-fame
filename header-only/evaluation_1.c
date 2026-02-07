#include <stdio.h>

#include "ceval.h"

int main(void) {
    static char expression[] = "1+2*3";
    double result = ceval_result(expression);
    printf("Result=%f\n", result);
    return 0;
}

