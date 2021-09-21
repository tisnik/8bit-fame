1 ------------------------------
2 REM COS function plot (graph)
3 REM in graphics mode 8
4 ------------------------------
10 DEG 
20 EXEC SET_GRAPHICS
30 EXEC DRAW_AXIS
40 REM PLOT FUNCTION
50 FOR X=0 TO 319
60   Y=79-70*COS((X-160)*90/80)
70   IF Y<0 OR Y>159 THEN GOTO 90
80   PLOT X,Y
90 NEXT X
100 DIM FILENAME$(10)
110 FILENAME$="H:COS.BMP"
120 EXEC WRITE_BMP
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
10000 ------------------------------
10010 REM Store video RAM
10020 REM in graphics mode 8 into
10030 REM BMP file.
10035 REM 
10040 REM Filename is to be provided
10050 REM via FILENAME$ variable.
10060 ------------------------------
10070 PROC WRITE_BMP
10075   OPEN #1,8,0,FILENAME$
10079   REM write BMP header (32 bytes)
10080   RESTORE 10502
10085   DIM B$(3)
10090   FOR I=0 TO 31
10095     READ B$
10100     B=DEC(B$(2,3))
10110     PUT #1,B
10120   NEXT I
10129   REM write scanlines from last to first
10130   SCANLINE_START=DPEEK(88)
10135   SCANLINE_END=SCANLINE_START+40*191
10140   FOR I=SCANLINE_END TO SCANLINE_START STEP -40
10145     FOR J=0 TO 39
10150       PUT #1,PEEK(I+J)
10155     NEXT J
10160   NEXT I
10165   CLOSE #1
10200 ENDPROC 
10499 ------------------------------
10500 REM BMP file header
10501 REM magic number "BM"
10502 DATA $42,$4D
10503 REM file size=7712 bytes
10504 DATA $20,$1E,$00,$00
10505 REM reserved
10506 DATA $00,$00,$00,$00
10507 REM pixel array offset=32
10508 DATA $20,$00,$00,$00
10509 REM bitmap header size=12 bytes
10510 DATA $0C,$00,$00,$00
10511 REM bitmap width in pixels
10512 DATA $40,$01:REM 320 pixels
10513 REM bitmap height in pixels
10514 DATA $C0,$00:REM 192 pixels
10515 REM number of color planes
10516 DATA $01,$00:REM 1 clr.plane
10517 REM bits per pixel
10518 DATA $01,$00:REM 1 BPP
10519 REM first color in palette
10520 DATA $00,$00,$00
10521 REM second color in palette
10522 DATA $FF,$FF,$FF
10523 REM end of bmp header
