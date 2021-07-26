1 ------------------------------
2 REM GRAPHICS command
3 REM for ANTIC graphics modes
4 ------------------------------
10 REM graphics mode #3
11 REM 40 x 24 pixels
12 REM 4 colors
13 REM 2 bits per pixel
14 REM 240 bytes video RAM
15 MODE=3
16 EXEC SHOW_MODE
20 REM graphics mode #4
21 REM 80 x 48 pixels
22 REM 2 colors
24 REM 1 bit per pixel
25 REM 480 bytes video RAM
25 MODE=4
26 EXEC SHOW_MODE
30 REM graphics mode #5
31 REM 80 x 48 pixels
32 REM 4 colors
33 REM 2 bits per pixel
33 REM 960 bytes video RAM
35 MODE=5
36 EXEC SHOW_MODE
40 REM graphics mode #6
41 REM 160 x 96 pixels
42 REM 2 colors
43 REM 1 bit per pixel
44 REM 1920 bytes video RAM
45 MODE=6
46 EXEC SHOW_MODE
50 REM graphics mode #7
51 REM 160 x 96 pixels
52 REM 2 colors
53 REM 1 bit per pixel
54 REM 1920 bytes video RAM
55 MODE=7
56 EXEC SHOW_MODE
60 REM graphics mode #8
61 REM 320 x 192 pixels
62 REM 2 colors
63 REM 1 bit per pixel
64 REM 7680 bytes video RAM
65 MODE=8
66 EXEC SHOW_MODE
70 REM graphics mode #14
71 REM 160 x 192 pixels
72 REM 2 colors
73 REM 1 bit per pixel
74 REM 3840 bytes video RAM
75 MODE=14
76 EXEC SHOW_MODE
80 REM graphics mode #15
81 REM 160 x 192 pixels
82 REM 4 colors
83 REM 2 bits per pixel
84 REM 7680 bytes video RAM
85 MODE=15
86 EXEC SHOW_MODE
999 STOP 
1000 ------------------------------
1001 PROC SHOW_MODE
1002   GRAPHICS MODE
1003   FOR I=0 TO 3
1004     COLOR I
1005     PLOT 0,I*4
1006     DRAWTO 39,I*4+5
1007   NEXT I
1010   PRINT "GRAPHICS MODE ";MODE
1011   PRINT "WAIT ... ";
1020   FOR I=10 TO 0 STEP -1
1021     PAUSE 20
1022     PRINT I;" ";
1023   NEXT I
1099 ENDPROC 
