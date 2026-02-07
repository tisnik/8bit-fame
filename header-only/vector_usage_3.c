#include <stdio.h>
#include "vec.h"

typedef struct Person {
    char name[50];
    int age;
} Person;

vec_define(Person, People);
vec_define_free_simple(Person, People);
vec_define_print(Person, People, printf("%s:%d", a.name, a.age));

int main() {
    People people;
    People_init(&people);

    Person p1 = {"Alice", 30};
    Person p2 = {"Bob", 25};
    Person p3 = {"Charlie", 35};

    People_push(&people, p1);
    People_push(&people, p2);
    People_push(&people, p3);

    People_print(people);

    Person p = People_at(people, 1);
    printf("Element at index 1: { name: \"%s\", age: %d }\n", p.name, p.age);

    Person updated = {"Bob Jr.", 26};
    People_set(&people, 1, updated);
    printf("Modified element at index 1: { name: \"%s\", age: %d }\n",
           People_at(people, 1).name, People_at(people, 1).age);

    Person popped = People_pop(&people);
    printf("Popped: { name: \"%s\", age: %d }\n", popped.name, popped.age);

    People_clear(&people);
    return 0;
}
