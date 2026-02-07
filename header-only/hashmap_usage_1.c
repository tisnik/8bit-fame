#include <stdio.h>

#include "hashmap.h"

int main(void) {
    struct hashmap_s hashmap;
    hashmap_create(10, &hashmap);
    
    int x = 0;
    int y = 1000;

    hashmap_put(&hashmap, "root", strlen("root"), &x);
    hashmap_put(&hashmap, "user", strlen("user"), &y);

    int *id= hashmap_get(&hashmap, "root", strlen("root"));
    if (id != NULL)
        printf("%d\n", *id);
    else
        printf("not found\n");

    id = hashmap_get(&hashmap, "user", strlen("user"));
    if (id != NULL)
        printf("%d\n", *id);
    else
        printf("not found\n");

    id = hashmap_get(&hashmap, "other", strlen("other"));
    if (id != NULL)
        printf("%d\n", *id);
    else
        printf("not found\n");

    hashmap_destroy(&hashmap);
}

