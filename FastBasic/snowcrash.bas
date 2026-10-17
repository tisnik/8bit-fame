' *****************************
' Vyplneni obrazovky v rezimu
' 320x192 nahodnym vzorkem.
'
' Implementace pro Fast BASIC
'
' Upraveno do podoby benchmarku
' *****************************
'
' VYMAZANI CASOVACE
POKE 18,0
POKE 19,0
POKE 20,0

' VLASTNI BENCHMARK
GRAPHICS 8

START=PEEK(88)+256*PEEK(89)
FINAL=START+320/8*160

FOR I=START TO FINAL
' 17BITOVY POLY CITAC = RND
    POKE I,PEEK(53770)
NEXT I

' PRECTENI CASOVACE
' (PLATNE PRO PAL)
T%=PEEK(19)*256+PEEK(20)
T%=T%/50
PRINT "FINISHED IN ";T%;" SECONDS"

DO
LOOP
