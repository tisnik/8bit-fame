10 REM Zapis nekolika hodnot
11 REM na disk namapovany emulatorem.
20 REM
21 REM Pro jistotu zavreme kanal
22 REM pred jeho pouzitim
22 CLOSE #4
30 REM Otevreme kanal pro zapis
31 OPEN #4, 8, 0, "H:test.txt"
40 REM Provedeni zapisu
41 FOR I=0 TO 100
42 PUT #4, I
43 NEXT I
50 REM Zavreme kanal
51 CLOSE #4
