1 ------------------------------
2 REM PI computation based on
3 REM usage of FOR-NEXT loops
4 ------------------------------
10 N=1
20 FOR I=1 TO 10
25   EXEC COMPUTE_PI
30   PRINT I,N,PI
35   N=N*2
40 NEXT I
998 REM finito
999 STOP
1000 ------------------------------
1001 REM SUBRUTINA PRO VYPOCET PI
1002 PROC COMPUTE_PI
1010   PI=4
1020   FOR J=3 TO N+2 STEP 2
1030     PI=PI*(J-1)/J*(J+1)/J
1040   NEXT J
1050 ENDPROC 
