10 ------------------------------
11 REM * Player-missile graphics  *
12 REM * example #4               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - set player 0 color     *
18 REM *                          *
19 REM * - set player 0 shape     *
20 REM *   across all scanlines   *
21 REM *                          *
22 REM * - turn off PMG DMA       *
23 REM *   for players and also   *
24 REM *   missiles               *
25 REM *                          *
26 REM * - changes player 0 width *
27 REM *   to 1x, 2x, and 4x    . *
28 REM *   horizontal size        *
29 ------------------------------
30 REM 
100 EXEC INIT_PMG_REGISTERS
110 EXEC INIT_TEXT_MODE
120 EXEC DISPLAY_PMG
998 REM finito
999 STOP
1000 ------------------------------
1001 PROC INIT_PMG_REGISTERS
1002   REM *** control registers ***
1003   REM *** mapped into memory ***
1010   REM 
1011   REM horizontal position
1012   REM of player 0
1013   HPOSP0=53248
1020   REM 
1021   REM color of player 0
1022   REM and missille 0
1023   PCOLR0=704
1030   REM 
1031   REM size of player 0
1032   SIZEP0=53256
1033   REM 
1040   REM graphics shape for player 0
1041   REM (bypass ANTIC)
1042   GRAFP0=53261
1050   REM 
1051   REM turn on/off players
1052   REM and missiles
1053   GRACTL=53277
1099 ENDPROC 
2000 ------------------------------
2001 PROC INIT_TEXT_MODE
2002   REM *** initialize text mode ***
2003   REM 
2010   GRAPHICS 0
2099 ENDPROC 
3000 ------------------------------
3001 PROC DISPLAY_PMG
3002   REM *** setup PMG ***
3003   REM *** and display player 0 ***
3004   REM 
3010   POKE HPOSP0,128:REM horizontal position
3020   POKE PCOLR0,88:REM color
3030   POKE SIZEP0,0:REM horizontal size
3040   POKE GRAFP0,255:REM graphics shape
3050   POKE GRACTL,0:REM turn off DMA
3060   PAUSE 50
3070   POKE SIZEP0,1:REM double size
3080   PAUSE 50
3090   POKE SIZEP0,3:REM quadruple size
3099 ENDPROC 
