void positive_case(void);
void negative_case(void);
void finish(void);

void bar(int i) {
  if (i > 0) {
    goto positive;
  }
  positive_case();
  goto end;
positive:
  negative_case();
end:
  finish();
}
