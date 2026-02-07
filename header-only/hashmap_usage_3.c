#include <stdio.h>

#include "hashmap.h"

static int iterate(void* const context, void* const value) {
    int *x = value;
    printf("%d\n", *x);
    return 1;
}

int main(void) {
    struct hashmap_s hashmap;
    hashmap_create(10, &hashmap);
    
    int x = 0;
    int y = 1000;

    hashmap_put(&hashmap, "root", strlen("root"), &x);
    hashmap_put(&hashmap, "user", strlen("user"), &y);

    int a = 1, b = 2, c = 3;
    hashmap_put(&hashmap, "foo", strlen("foo"), &a);
    hashmap_put(&hashmap, "bar", strlen("bar"), &b);
    hashmap_put(&hashmap, "baz", strlen("baz"), &c);

    int* value;
    hashmap_iterate(&hashmap, iterate, &value);
    hashmap_destroy(&hashmap);
}

