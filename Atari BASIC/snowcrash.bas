1 REM *****************************
2 REM Vyplneni obrazovky nahodnym
3 REM vzorem v rezimu GRAPHICS 8
4 REM 
5 REM Uprava pro Atari BASIC
6 REM
7 REM *****************************
8 REM
9 REM
10 GRAPHICS 8
20 START=PEEK(88)+256*PEEK(89)
30 FINAL=START+320*160/8
40 FOR I=START TO FINAL
49 REM 17BITOVY POLY CITAC = RND
50 POKE I,PEEK(53770)
60 NEXT I
998 REM finito
999 STOP
