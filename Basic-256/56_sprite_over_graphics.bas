rem Načtení a zobrazení spritu
rem Změna pozice spritu

clg

color black

for i = 0 to 200 step 10
    line 50, 50+i, 250, 50+i
    line 50+i, 50, 50+i, 250
next i

spritedim 1

spriteload 0, "gnome-globe.png"
spriteplace 0, 150, 150
spriteshow 0