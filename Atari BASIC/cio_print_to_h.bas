10 REM Zapis textovych dat
11 REM na disk namapovany emulatorem.
20 REM
21 REM Pro jistotu zavreme kanal
22 REM pred jeho pouzitim
22 CLOSE #4
30 REM Otevreme kanal pro zapis
31 OPEN #4, 8, 0, "H:test.txt"
40 REM Provedeni zapisu
41 PRINT #4; "Hello Atari!"
50 REM Zavreme kanal
51 CLOSE #4
