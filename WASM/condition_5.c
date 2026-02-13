float bar(float x);
float baz(float x);

float foo(float x) {
    return x < 42 ? bar(x) : baz(x);
}
