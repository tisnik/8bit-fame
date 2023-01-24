1 ------------------------------
2 REM 
3 REM Hypocycloid drawn as
4 REM parametric curve.
5 REM 
6 REM This source code has been
7 REM prepared for TurboBASIC XL
8 REM 
9 ------------------------------
10 DEG 
20 EXEC SET_GRAPHICS
30 EXEC DRAW_AXIS
40 EXEC PLOT_CURVE
50 EXEC SAVE_IMAGE
999 STOP 
1000 ------------------------------
1010 REM SET GRAPHICS MODE
1020 ------------------------------
1030 PROC SET_GRAPHICS
1040   GRAPHICS 8+16
1050   COLOR 1
1060 ENDPROC 
2000 ------------------------------
2010 REM DRAW AXIS
2020 ------------------------------
2030 PROC DRAW_AXIS
2040   PLOT 160,0:DRAWTO 160,191
2050   PLOT 0,96:DRAWTO 319,96
2060 ENDPROC 
3000 ------------------------------
3010 REM PLOT CURVE
3020 ------------------------------
3030 PROC PLOT_CURVE
3040   ORIGIN_X=160
3050   ORIGIN_Y=96
3055   A=2
3060   B=7
3065   R=6
3070   FOR T=0 TO 14*360 STEP 1
3080     X=ORIGIN_X+R*((A-B)*COS(T)+B*COS((A/B-1)*T))
3090     Y=ORIGIN_Y-R*((A-B)*SIN(T)-B*SIN((A/B-1)*T))
3100     IF X>0 AND Y>0 THEN PLOT X,Y
3110   NEXT T
3120 ENDPROC 
4000 ------------------------------
4010 REM SAVE_IMAGE
4020 ------------------------------
4030 PROC SAVE_IMAGE
4040   DIM FILENAME$(20)
4050   FILENAME$="H:HYPOCYCLOID2.BMP"
4060   EXEC WRITE_BMP
4070 ENDPROC 
10000 ------------------------------
10010 REM Store video RAM
10020 REM in graphics mode #8 into
10030 REM BMP file.
10035 REM
10040 REM Filename is to be provided
10050 REM via FILENAME$ variable.
10055 REM (Example: "H:TEST.BMP")
10060 ------------------------------
10070 PROC WRITE_BMP
10075   PRINT "Writing raster image into file ";FILENAME$
10080   OPEN #1,8,0,FILENAME$
10085   REM write BMP header (32 bytes)
10090   RESTORE 10502
10095   DIM B$(3)
10100   FOR I=0 TO 31
10105     READ B$
10110     B=DEC(B$(2,3))
10115     PUT #1,B
10120   NEXT I
10125   REM write scanlines from last to first
10130   SCANLINE_START=DPEEK(88)
10135   SCANLINE_END=SCANLINE_START+40*191
10140   PERCENT=0
10145   PERCENT_DELTA=100/191
10150   FOR I=SCANLINE_END TO SCANLINE_START STEP -40
10155     BPUT #1,I,40
10160     REM ATARI BASIC HAVE TO USE PUT
10165     REM FOR J=0 TO 39
10170     REM   PUT #1,PEEK(I+J)
10175     REM NEXT J
10180     PERCENT=PERCENT+PERCENT_DELTA
10185     PRINT TRUNC(PERCENT);"%  ";
10190   NEXT I
10195   CLOSE #1
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
10523 REM end of BMP file header
