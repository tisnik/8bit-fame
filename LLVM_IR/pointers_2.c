void swap(void *a, void *b) {
    int c = *(int*)a;
    *(int*)a = *(int*)b;
    *(int*)b = c;
}
