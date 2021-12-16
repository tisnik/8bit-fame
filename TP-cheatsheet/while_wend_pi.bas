1 ------------------------------
2 REM WHILE-WEND program looping
3 REM construct
4 ------------------------------
10 N=1
20 WHILE N<=2000
25   EXEC COMPUTE_PI
30   PRINT N,PI
35   N=N*2
40 WEND 
998 REM finito
999 STOP
1000 ------------------------------
1001 REM Pi computation subroutine
1002 PROC COMPUTE_PI
1010   PI=4
1015   J=3
1020   WHILE J<=N+2
1030     PI=PI*(J-1)/J*(J+1)/J
1040     J=J+2
1050   WEND 
1060 ENDPROC 
