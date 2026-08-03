10 REM Precteni retezce ze zarizeni
20 REM
21 REM Pro jistotu zavreme kanal
22 REM pred jeho pouzitim
22 CLOSE #4
30 REM Otevreme kanal pro cteni
31 OPEN #4, 4, 0, "H:test.txt"
40 REM Provedeni cteni
41 DIM A$(100)
42 INPUT #4, A$
50 REM Zavreme kanal
51 CLOSE #4
60 REM Co jsme nacetli?
61 PRINT A$
