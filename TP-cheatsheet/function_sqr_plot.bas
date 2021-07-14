1 ------------------------------
2 REM SQR function plot
5 ------------------------------
20 EXEC SET_GRAPHICS
30 EXEC DRAW_AXIS
40 REM PLOT FUNCTION
50 FOR X=0 TO 319
60   Y=160-16*SQR(X/319*100)
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
2050   PLOT 0,159:DRAWTO 319,159
2060   TEXT 2,4,"10"
2070   TEXT 2,148,"0"
2080   TEXT 295,148,"100"
2200 ENDPROC 
2300 ------------------------------
