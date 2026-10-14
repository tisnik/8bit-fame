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

' bitmapa hrace
DATA PMdata()  byte = 24, 60, 126, 219, 255, 36, 90, 165

' horizontalni pozice hrace na obrazovce
pmhpos 0, 120

' kopie bitmapy hrace
move adr(PMdata), P0Mem+60, 8

do
loop

