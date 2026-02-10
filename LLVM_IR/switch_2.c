unsigned int numeric_value(unsigned int x, unsigned int y) {
  switch (x) {
  case 42:
    y++;
    break;
  case 100:
    y += 2;
    break;
  case 6502:
    y -= 2;
    break;
  case 8080:
    y--;
    break;
  }
  return y;
}
