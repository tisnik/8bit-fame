1 ------------------------------
2 REM SIN function plot for DEG
3 REM mode (also negative values)
4 ------------------------------
10 DEG 
20 GRAPHICS 8
30 COLOR 1
40 PLOT 160,0:DRAWTO 160,159
50 PLOT 0,80:DRAWTO 319,80
60 FOR X=0 TO 319
70   Y=79-60*SIN((X-160)*360/320)
80   PLOT X,Y
90 NEXT X
998 REM finito
999 STOP 
