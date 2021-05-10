# Turbo-BASIC XL cheatsheet



## Functions

## Loops

Four types of loops are supported by Turbo-BASIC XL:

* `FOR-NEXT` (taken from Atari BASIC with one bug fix)
* `DO-LOOP`
* `REPEAT-UNTIL`
* `WHILE-WEND`

### `FOR-NEXT`

This variant of loop construct was taken from Atari BASIC, including the bug mentioned below. Because Turbo-BASIC XL is designed to be as compatible with Atari BASIC as possible, the buggy behaviour can be switched on or turn off.

* Basic usage of this loop:

```basic
10 FOR I=0 TO 10
20   PRINT I
30 NEXT I

```

* Default step value is set to 1, but it can be specified explicitly if needed:

```basic
10 FOR I=0 TO 10 STEP 2
20   PRINT I
30 NEXT I

```

* Counting downward

```basic
10 FOR I=10 TO 0 STEP -2
20   PRINT I
30 NEXT I

```

* Improper usage (revealing bug in Atari BASIC)

```basic
10 FOR I=10 TO 0
20   PRINT I
30 NEXT I

```

```basic
10 N=1
20 FOR I=1 TO 10
25   EXEC COMPUTE_PI
30   PRINT I,N,PI
35   N=N*2
40 NEXT I
999 END 
1000 ------------------------------
1001 REM SUBRUTINA PRO VYPOCET PI
1002 PROC COMPUTE_PI
1010   PI=4
1020   FOR J=3 TO N+2 STEP 2
1030     PI=PI*(J-1)/J*(J+1)/J
1040   NEXT J
1050 ENDPROC 


```

### `DO-LOOP`

### `REPEAT-UNTIL`

```basic
10 A=0
20 REPEAT 
30   A=A+1
40   PRINT A
50 UNTIL A=10

```

```basic
10 A=1
20 REPEAT 
30   PRINT A
40   A=A*2
50 UNTIL A>1024

```

```basic
10 A=1
20 REPEAT 
30   B=10
40   REPEAT 
50     PRINT A*B;" ";
60     B=B+1
70   UNTIL B>20
80   A=A+1
90   PRINT 
95 UNTIL A>6

```

```basic
10 N=1
20 REPEAT 
25   EXEC COMPUTE_PI
30   PRINT N,PI
35   N=N*2
40 UNTIL N>2000
999 END 
1000 ------------------------------
1001 REM SUBRUTINA PRO VYPOCET PI
1002 PROC COMPUTE_PI
1010   PI=4
1015   J=3
1020   REPEAT 
1030     PI=PI*(J-1)/J*(J+1)/J
1040     J=J+2
1050   UNTIL J>N+2
1060 ENDPROC 

```

### `WHILE-WEND`

