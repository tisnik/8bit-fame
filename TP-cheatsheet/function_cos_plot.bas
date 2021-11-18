1 ------------------------------
2 REM COS function plot
4 REM in DEG mode
5 ------------------------------
10 DEG 
20 EXEC SET_GRAPHICS
30 EXEC DRAW_AXIS
40 REM PLOT FUNCTION
50 FOR X=0 TO 319
60   Y=79-70*COS((X-160)*90/80)
70   IF Y<0 OR Y>159 THEN GOTO 90
80   PLOT X,Y
90 NEXT X
998 REM finito
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
2040   PLOT 160,0:DRAWTO 160,159
2050   PLOT 0,80:DRAWTO 319,80
2060   TEXT 0,82,"-90"
2070   TEXT 300,82,"90"
2080   TEXT 162,5,"1"
2090   TEXT 162,145,"-1"
2100   TEXT 162,82,"0,0"
2200 ENDPROC 
2300 ------------------------------
