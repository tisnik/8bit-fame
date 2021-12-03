1 ------------------------------
2 REM GRAPHICS command
3 REM for GTIA graphics modes
4 ------------------------------
10 REM GRAPHICS MODE #9
11 REM 80 x 192 pixels
12 REM 16 levels of the same color
13 REM 4 bits per pixel
14 REM 7680 bytes video RAM
15 MODE=9
16 EXEC SHOW_MODE
20 REM GRAPHICS MODE #10
21 REM 80 x 192 pixels
22 REM 9 colors (limited by color registers)
23 REM 4 bits per pixel
24 REM 7680 bytes video RAM
25 MODE=10
26 EXEC SHOW_MODE
30 REM GRAPHICS MODE #11
31 REM 80 x 192 pixels
32 REM 16 colors on same level
33 REM 4 bits per pixel
34 REM 7680 bytes video RAM
35 MODE=11
36 EXEC SHOW_MODE
998 REM finito
999 STOP 
1000 ------------------------------
1001 PROC SHOW_MODE
1002   GRAPHICS MODE+16
1003   FOR I=0 TO 79
1004     COLOR I
1005     PLOT I,0
1006     DRAWTO I,192
1007   NEXT I
1010   PAUSE 200
1099 ENDPROC 
