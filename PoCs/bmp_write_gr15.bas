1 REM *****************************
2 REM Procedure to store content of
3 REM graphics memory in graphics
4 REM mode GR.15+16 (160x192x2bpp)
5 REM into semi-standard BMP file.
6 REM *****************************
7 REM
8 REM
9 REM
10 DIM FILENAME$(20)
20 FILENAME$="H:TEST.BMP"
30 GRAPHICS 15+16
40 COLOR 1
45 PLOT 0,0
50 DRAWTO 159,191
55 COLOR 2
60 CIRCLE 20,20,10
65 COLOR 3
70 PLOT 10,0:DRAWTO 0,0:DRAWTO 0,10
80 EXEC WRITE_BMP
999 STOP 
10000 ------------------------------
10010 REM Store video RAM
10020 REM in graphics mode #15 into
10030 REM BMP file.
10035 REM
10040 REM Filename is to be provided
10050 REM via FILENAME$ variable.
10055 REM (Example: "H:TEST.BMP")
10060 ------------------------------
10070 PROC WRITE_BMP
10075   OPEN #1,8,0,FILENAME$
10079   REM write BMP header (38 bytes in total)
10080   RESTORE 10502
10085   DIM B$(3)
10090   FOR I=0 TO 37
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
10503 REM file size=7718 bytes
10504 DATA $26,$1E,$00,$00
10505 REM reserved
10506 DATA $00,$00,$00,$00
10507 REM pixel array offset=38
10508 DATA $26,$00,$00,$00
10509 REM bitmap header size=12 bytes
10510 DATA $0C,$00,$00,$00
10511 REM bitmap width in pixels
10512 DATA $A0,$00:REM 160 pixels
10513 REM bitmap height in pixels
10514 DATA $C0,$00:REM 192 pixels
10515 REM number of color planes
10516 DATA $01,$00:REM 1 clr.plane
10517 REM bits per pixel
10518 DATA $02,$00:REM 2 BPP
10519 REM first color in palette
10520 DATA $00,$00,$00
10521 REM second color in palette
10522 DATA $FF,$00,$FF
10523 REM third color in palette
10524 DATA $FF,$FF,$00
10525 REM fourth color in palette
10526 DATA $FF,$FF,$FF
10527 REM end of BMP file header
