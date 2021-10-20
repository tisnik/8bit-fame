rem Základy práce s grafickým výstupem
rem
rem Smazání grafické plochy
rem Příkaz pro vykreslení úsečky
rem Změna šířky vykreslovaných úseček

clg

color black

for i = 0 to 200 step 20
    penwidth i/10
    line 50, 50+i, 250, 50+i
next i