1 REM *****************************
2 REM Test zazizeni G1:
3 REM Operace OPEN a CLOSE
4 REM 
5 REM Uprava pro Atari BASIC
6 REM
7 REM *****************************
8 REM
9 REM
10 DIM A$(100)
20 REM INIT ADDRESS OF G_DEVICE V.1.1
30 INIT=39176
40 INPUT A$
50 A=USR(INIT)
60 OPEN #2,8,0,"G1:"
70 INPUT A$
80 CLOSE #2
90 END 
