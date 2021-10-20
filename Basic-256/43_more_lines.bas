rem Základy práce s grafickým výstupem
rem
rem Smazání grafické plochy
rem Příkaz pro vykreslení úsečky

clg

color black

for i = 0 to 200 step 10
    line 50, 50+i, 50+i, 250
next i