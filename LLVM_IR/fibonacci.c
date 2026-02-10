long fibonacciIter(int n) {
  if (n <= 1) {
    return n;
  }
  long result = 0;
  long n1 = 0;
  long n2 = 1;
  for (n--; n > 0; n--) {
    result = n1 + n2;
    n1 = n2;
    n2 = result;
  }
  return result;
}
