10 ------------------------------
11 REM * Player-missile graphics  *
12 REM * example #5               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - dtto for player 1      *
18 REM *                          *
19 REM * - set player 0 color     *
20 REM *                          *
21 REM * - dtto for player 1      *
22 REM *                          *
23 REM * - set player 0 shape     *
24 REM *   across all scanlines   *
25 REM *                          *
26 REM * - dtto for player 1      *
27 REM *                          *
28 REM * - turn off PMG DMA       *
29 REM *   for players and also   *
30 REM *   missiles               *
31 ------------------------------
32 REM 
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
1021   REM horizontal position
1022   REM of player 1
1023   HPOSP1=53249
1024   REM 
1025   REM color of player 0
1026   REM and missille 0
1027   PCOLR0=704
1028   REM 
1029   REM color of player 1
1030   REM and missile 1
1031   PCOLR1=705
1032   REM 
1033   REM graphics shape for player 0
1034   REM (bypass ANTIC)
1035   GRAFP0=53261
1036   REM 
1037   REM graphics shape for player 1
1038   REM (bypass ANTIC again)
1039   GRAFP1=53262
1040   REM 
1041   REM turn on/off players
1042   REM and missiles
1043   GRACTL=53277
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
3020   POKE HPOSP1,160:REM horizontal position
3030   POKE PCOLR0,88:REM color for player 0
3040   POKE PCOLR1,42:REM color for player 1
3050   POKE GRAFP0,255:REM graphics shape
3060   POKE GRAFP1,128+32+8+2:REM graphics shape
3070   POKE GRACTL,0:REM turn off DMA
3099 ENDPROC 
