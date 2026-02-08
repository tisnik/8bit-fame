void foo(void);
void bar(void);
void baz(void);
void bzz(void);

void numeric_value(int x) {
    switch (x) {
        case 0:
            foo();
            break;
        case 1:
            bar();
            break;
        case 2:
            baz();
            break;
        default:
            bzz();
            break;
    }
}

