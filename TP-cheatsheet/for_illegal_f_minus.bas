1 ------------------------------
2 REM FOR-NEXT statement with
3 REM illegal start and stop
4 REM values.
5 REM
6 REM Usage of "*F -" option
7 REM that affects FOR-LOOP
8 REM behaviour.
9 ------------------------------
10 *F -
20 FOR I=10 TO 0
30   PRINT I
40 NEXT I
998 REM finito
999 STOP
