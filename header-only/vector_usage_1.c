#include <stdio.h>
#include "vec.h"

typedef char* Name;

vec_define(Name, Names);
vec_define_free_simple(Name, Names);
vec_define_print(Name, Names, printf("%s", a));

int main() {
    Names names;
    Names_init(&names);

    Name p1 = {"Alice"};
    Name p2 = {"Bob"};
    Name p3 = {"Charlie"};

    Names_push(&names, p1);
    Names_push(&names, p2);
    Names_push(&names, p3);

    Names_print(names);
    printf("\n\n");

    Name p = Names_at(names, 1);
    printf("Element at index 1: \"%s\"\n", p);

    Names_clear(&names);
    return 0;
}
