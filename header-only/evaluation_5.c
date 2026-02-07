#include <stdio.h>
#include <stdlib.h>

#include "ceval.h"

int main(void) {
    static char expression[] = "sin(deg2rad(45))";
    double result = ceval_result(expression);
    printf("Result=%f\n", result);
    return 0;
}

