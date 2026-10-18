' vymazani casovace
poke 18,0
poke 19,0
poke 20,0

' textovy rezim
graphics 0

' povoleni zobrazeni spritu
pmgraphics 1

' adresa bloku pro hrace 1
P0Mem = pmadr(0)

' vymazani pameti hrace
mset P0Mem, 256, 0

' nastavení barvy hrace
setcolor -4, 1, 15

' horizontalni pozice hrace na obrazovce
pmhpos 0, 120

' bitmapa hrace i se dvema "mazacimi" radky
DATA PMdata()  byte = 0, 24, 24, 60, 60, 126, 126, 219, 219, 255, 255, 36, 36, 90, 90, 165, 165, 0

for y=0 to 255
    ' kopie bitmapy hrace
    move adr(PMdata), P0Mem+y, 18
next y

' ------------------------------
' precteni casovace
' (platne pro pal)
' ------------------------------
t%=peek(19)*256+peek(20)
t%=t%/50
print "finished in ";t%;" seconds"

do
loop

