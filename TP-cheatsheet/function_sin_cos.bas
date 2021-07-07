1 ------------------------------
2 REM SIN and COS functions can
3 REM be used to plot circle
4 REM (which is very slow)
5 ------------------------------
10 DEG 
20 GRAPHICS 8
30 COLOR 1
40 PLOT 0,0:DRAWTO 0,159
50 PLOT 0,80:DRAWTO 319,80
60 FOR X=0 TO 319
70   Y=79-60*SIN(X*360/320)
75   PLOT X,Y
80   Y=79-60*COS(X*360/320)
85   PLOT X,Y
90 NEXT X
999 STOP
