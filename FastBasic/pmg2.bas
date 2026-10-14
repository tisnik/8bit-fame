' textovy rezim
graphics 0

' povoleni zobrazeni spritu
pmgraphics 2

' adresa bloku pro hrace 1
P0Mem = pmadr(0)

' vymazani pameti hrace
mset P0Mem, 128, 0

' nastavení barvy hrace
setcolor -4, 1, 15

' bitmapa hrace i se dvema "mazacimi" radky
DATA PMdata()  byte = 0, 24, 60, 126, 219, 255, 36, 90, 165, 0

y = 60
x = 120

do
    ' horizontalni pozice hrace na obrazovce
    pmhpos 0, x

    ' kopie bitmapy hrace
    move adr(PMdata), P0Mem+y, 10

    if stick(0) = 7 then x=x+1
    if stick(0) = 11 then x=x-1
    if stick(0) = 14 then y=y-1
    if stick(0) = 13 then y=y+1

    ' poseckejme
    pause

loop

