unsigned int numeric_value(unsigned int x, unsigned int y) {
  switch (x) {
  case 0:
    y++;
    break;
  case 1:
    y += 2;
    break;
  case 2:
    y -= 2;
    break;
  case 3:
    y--;
    break;
  }
  return y;
}
