#include <stdio.h>
#include <stdlib.h>

#include "ceval.h"

int main(void) {
    double a = 3;
    double b = 20;
    double c = 14;

    static char expression[] = "(%f-%f)*(%f+%f)+%f*(%f-%f+%f)";
    char buffer[200];

    snprintf(buffer, sizeof(buffer), expression, a, b, c, b, b, c, a, b);
    double result = ceval_result(buffer);
    printf("Result=%f\n", result);
    return 0;
}

