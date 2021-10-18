rem Procházení prvky pole
rem S využitím smyčky FOR-EACH

dim a(10)

for i = 0 to a[?]-1
    a[i] = 1/(i+1)
next i

for each item in a
    print item
next item
