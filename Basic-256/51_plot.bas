rem Práce s grafikou na úrovni jednotlivých pixelů
clg

for y=0 to 250
    for x=0 to 250
        color rgb(x, 255, y)
        plot x, y
    next x
next y
