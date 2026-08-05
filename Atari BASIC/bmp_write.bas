1 REM *****************************
2 REM Procedure to store content of
3 REM graphics memory in graphics
4 REM mode GR.8+16 (320x192x1bpp)
5 REM into semi-standard BMP file.
6 REM *****************************
7 REM
8 REM
9 REM
10 DIM FILENAME$(20)
20 FILENAME$="H:TEST.BMP"
30 GRAPHICS 8+16
40 COLOR 1
45 PLOT 0,0
50 DRAWTO 319,191
60 PLOT 10,0:DRAWTO 0,0:DRAWTO 0,10
80 GOSUB 10000: REM Write BMP
999 STOP 
10000 REM ------------------------------
10010 REM Store video RAM
10020 REM in graphics mode #8 into
10030 REM BMP file.
10035 REM
10040 REM Filename is to be provided
10050 REM via FILENAME$ variable.
10055 REM (Example: "H:TEST.BMP")
10060 REM ------------------------------
10075   PRINT "Writing raster image into file ";FILENAME$
10080   OPEN #1,8,0,FILENAME$
10085   REM write BMP header (32 bytes)
10090   RESTORE 10502
10100   FOR I=0 TO 31
10105     READ B
10115     PUT #1,B
10120   NEXT I
10125   REM write scanlines from last to first
10130   SCANSTART=PEEK(88)+256*PEEK(89)
10135   SCANEND=SCANSTART+40*191
10150   FOR I=SCANEND TO SCANSTART STEP -40
10160     REM ATARI BASIC HAVE TO USE PUT
10165     FOR J=0 TO 39
10170       PUT #1,PEEK(I+J)
10175     NEXT J
10190   NEXT I
10195   CLOSE #1
10200 RETURN
10499 REM ------------------------------
10500 REM BMP file header
10501 REM magic number "BM"
10502 DATA 66, 77
10503 REM file size=7712 bytes
10504 DATA 32, 30, 0, 0
10505 REM reserved
10506 DATA 0, 0, 0, 0
10507 REM pixel array offset=32
10508 DATA 32, 0, 0, 0
10509 REM bitmap header size=12 bytes
10510 DATA 12, 0, 0, 0
10511 REM bitmap width in pixels
10512 DATA 64, 1
10513 REM bitmap height in pixels
10514 DATA 192, 0
10515 REM number of color planes
10516 DATA 1, 0
10517 REM bits per pixel
10518 DATA 1, 0
10519 REM first color in palette
10520 DATA 0, 0, 0
10521 REM second color in palette
10522 DATA 255, 255, 255
10523 REM end of BMP file header
