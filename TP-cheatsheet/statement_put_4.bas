1 ------------------------------
2 REM Store screen in graphics
3 REM mode 0 into the file via
4 REM CIO operations
5 ------------------------------
10 SCREEN_BEGIN=DPEEK(88)
11 SCREEN_END=SCREEN_BEGIN+40*24-1
12 CLOSE #1
20 OPEN #1,8,0,"H:SCREEN.TXT"
21 FOR I=SCREEN_BEGIN TO SCREEN_END
22   PUT #1,PEEK(I)
23 NEXT I
30 CLOSE #1
999 END 
