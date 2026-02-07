#include <stdio.h>
#include "vec.h"

typedef char* Name;

vec_define(Name, Names);
vec_define_free_simple(Name, Names);
vec_define_print(Name, Names, printf("%s", a));

int main() {
    Names names;
    Names_init(&names);
    printf("Initial size=%d and capacity=%d\n", names.size, names.capacity);

    Name p1 = {"Alice"};
    Name p2 = {"Bob"};
    Name p3 = {"Charlie"};

    Names_push(&names, p1);
    Names_push(&names, p2);
    Names_push(&names, p3);

    printf("Actual size=%d and capacity=%d\n", names.size, names.capacity);

    Names_print(names);
    printf("\n\n");

    int i;
    for (i=0; i<names.size; i++) {
        Name p = Names_at(names, i);
        printf("Element at index %d: \"%s\"\n", i, p);
    }

    Names_clear(&names);
    return 0;
}
