#include <stdio.h>

#include "hashmap.h"

int main(void) {
    struct hashmap_s hashmap;
    hashmap_create(2, &hashmap);
    
    int x = 0;
    int y = 1000;

    printf("Capacity: %d\n", hashmap_capacity(&hashmap));

    hashmap_put(&hashmap, "root", strlen("root"), &x);
    hashmap_put(&hashmap, "user", strlen("user"), &y);
    hashmap_put(&hashmap, "foo", strlen("foo"), &y);
    hashmap_put(&hashmap, "bar", strlen("bar"), &y);
    hashmap_put(&hashmap, "baz", strlen("baz"), &y);

    printf("Capacity: %d\n", hashmap_capacity(&hashmap));

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

    hashmap_remove(&hashmap, "foo", strlen("foo"));
    hashmap_remove(&hashmap, "bar", strlen("bar"));
    hashmap_remove(&hashmap, "baz", strlen("baz"));
    hashmap_remove(&hashmap, "root", strlen("root"));
    hashmap_remove(&hashmap, "user", strlen("user"));
    printf("Capacity: %d\n", hashmap_capacity(&hashmap));

    hashmap_destroy(&hashmap);
}


