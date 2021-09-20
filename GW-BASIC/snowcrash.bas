1 REM *****************************
2 REM Vyplneni obrazovky nahodnym
3 REM vzorem v rezimu SCREEN 9
4 REM 
5 REM Uprava pro GW-BASIC
6 REM
7 REM *****************************
8 REM
9 REM
10 SCREEN 9
20 DEF SEG = &hA000
30 FINAL=640*350/8
40 FOR I=0 TO FINAL
50 POKE I,255*RND(1)
60 NEXT I
999 END
