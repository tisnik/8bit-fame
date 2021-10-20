rem Načtení a zobrazení spritu
rem Přesun spritu

clg

color black

for i = 0 to 200 step 10
    line 50, 50+i, 250, 50+i
    line 50+i, 50, 50+i, 250
next i

spritedim 1

spriteload 0, "gnome-globe.png"
spriteshow 0

for i = 0 to 250
    pause 0.01
    spritemove 0, 1, 1
next i