1 ------------------------------
2 REM GRAPHICS command
3 REM for text modes
4 ------------------------------
10 REM text mode #0
11 REM 40x24 characters
12 REM 2 colors
13 REM 960 video memory used
15 MODE=0
16 EXEC SHOW_MODE
20 REM text mode #1
21 REM 20x24 characters
22 REM 5 colors
23 REM 480 video memory used
25 MODE=1
26 EXEC SHOW_MODE
30 REM text mode #2
31 REM 20x12 characters
32 REM 5 colors
33 REM 240 video memory used
35 MODE=2
36 EXEC SHOW_MODE
40 REM text mode #12
41 REM 40x24 characters
42 REM 5 colors
43 REM 960 video memory used
45 MODE=12
46 EXEC SHOW_MODE
50 REM text mode #13
51 REM 40x12 characters
52 REM 5 colors
53 REM 480 video memory used
55 MODE=13
56 EXEC SHOW_MODE
999 STOP 
1000 ------------------------------
1010 PROC SHOW_MODE
1020   GRAPHICS MODE
1025   TRAP 1110
1030   FOR I=0 TO 255
1040     IF I<>125
1050       PRINT #6;CHR$(I);
1060     ELSE 
1070       PRINT #6;"_";
1080     ENDIF 
1090   NEXT I
1100   PRINT #6:REM NEXT LINE
1110   PRINT "TEXT MODE ";MODE
1120   PRINT "WAIT ... ";
1130   FOR I=10 TO 0 STEP -1
1140     PAUSE 20
1150     PRINT I;" ";
1160   NEXT I
1999 ENDPROC 
