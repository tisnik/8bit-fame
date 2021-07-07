1 ------------------------------
2 REM LOG function plot
5 ------------------------------
20 EXEC SET_GRAPHICS
30 EXEC DRAW_AXIS
40 REM PLOT FUNCTION
50 FOR X=0 TO 319
55   TRAP 90:REM IGNORE -INF ETC.
60   Y=79-20*LOG(X/319*10)
70   IF Y<0 OR Y>159 THEN GOTO 90
80   PLOT X,Y
90 NEXT X
999 STOP 
1000 ------------------------------
1010 REM SET GRAPHICS MODE
1020 ------------------------------
1030 PROC SET_GRAPHICS
1040   GRAPHICS 8
1050   COLOR 1
1060 ENDPROC 
2000 ------------------------------
2010 REM DRAW AXIS
2020 ------------------------------
2030 PROC DRAW_AXIS
2040   PLOT 0,0:DRAWTO 0,159
2050   PLOT 0,80:DRAWTO 319,80
2060   X=2.7182/10*319
2065   TEXT X,82,"e"
2070   TEXT 300,82,"10"
2080   TEXT 2,5,"4"
2090   TEXT 2,145,"-4"
2100   TEXT 2,82,"0,0"
2200 ENDPROC 
2300 ------------------------------
