unsigned int sum(unsigned int *array, int size) {
  unsigned int s = 0;
  unsigned int *p = array;
  int i;

  for (i = 0; i < size; i++) {
    s += *p++;
  }
  return s;
}
