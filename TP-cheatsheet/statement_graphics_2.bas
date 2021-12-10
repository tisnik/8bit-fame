1 ------------------------------
2 REM Basic usage of GRAPHICS
3 REM command to select raster
4 REM mode 320x192x2 colors
5 REM without text area
6 ------------------------------
10 GRAPHICS 8+16
11 COLOR 1
12 PLOT 0,0
13 DRAWTO 319,191
14 IF STRIG(0)=1 THEN GOTO 14
998 REM finito
999 STOP 
