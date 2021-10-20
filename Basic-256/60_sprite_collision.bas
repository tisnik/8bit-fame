rem Načtení a zobrazení spritu
rem Kolize spritů

clg

color black

for i = 0 to 200 step 10
    line 50, 50+i, 250, 50+i
    line 50+i, 50, 50+i, 250
next i

spritedim 2

spriteload 0, "gnome-globe.png"
spriteshow 0

spriteload 1, "gnome-globe.png"
spriteshow 1
spritemove 1, 150, 150

for i = 0 to 250
    pause 0.01
    spritemove 0, 1, 1
    if spritecollide(0, 1) then
        print "Collision"
    endif
next i