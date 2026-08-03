10 REM Zapis nekolika hodnot
11 REM na disk namapovany emulatorem.
20 REM
21 REM Pro jistotu zavreme kanal
22 REM pred jeho pouzitim
22 XIO 12, #4, 0, 0, ""
30 REM Otevreme kanal pro zapis
31 XIO 3, #4, 8, 0, "H:test.txt"
40 REM Provedeni zapisu jednoho znaku
41 XIO 9, #4, 8, 0, "Hello, Atari!"
50 REM Zavreme kanal
51 XIO 12, #4, 0, 0, ""
