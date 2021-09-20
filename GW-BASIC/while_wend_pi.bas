1 REM *****************************
2 REM Výpočet hodnoty konstanty PI
3 REM postavený na smyčce
4 REM typu WHILE-WEND.
5 REM 
6 REM Uprava pro GW-BASIC
7 REM *****************************
8 REM
9 REM
10 N=1
20 WHILE N<=2000
25   GOSUB 1000: REM COMPUTE_PI
30   PRINT N,PI
35   N=N*2
40 WEND 
999 END 
1000 REM
1001 REM SUBRUTINA PRO VYPOCET PI
1010   PI=4
1015   J=3
1020   WHILE J<=N+2
1030     PI=PI*(J-1)/J*(J+1)/J
1040     J=J+2
1050   WEND 
1060 RETURN
