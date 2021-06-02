1 ------------------------------
2 REM ABS function plot (graph)
3 REM in graphics mode 8
4 ------------------------------
10 EXEC SET_GRAPHICS
20 EXEC DRAW_AXIS
40 REM PLOT FUNCTION
50 FOR X=0 TO 319
60   Y=79-ABS(X-160)
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
2040   PLOT 160,0:DRAWTO 160,159
2050   PLOT 0,80:DRAWTO 319,80
2060   TEXT 0,82,"-160"
2070   TEXT 290,82,"160"
2080   TEXT 162,0,"80"
2090   TEXT 162,150,"-80"
2100   TEXT 162,82,"0,0"
2200 ENDPROC 
2300 ------------------------------
