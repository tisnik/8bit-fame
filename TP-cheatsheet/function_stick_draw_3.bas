1 ------------------------------
2 REM Usage of codes of eight
3 REM directions returned by
4 REM STICK function to draw.
5 REM
6 REM Updated Boolean
7 REM expressions are used to
8 REM move player.
9 ------------------------------
10 REM GRAPHICS SETUP
15 GRAPHICS 4
20 COLOR 1
30 REM PLAYER SETUP
35 X=39
40 Y=19
50 REM MAIN LOOP
60 PLOT X,Y
69 REM PLAYER MOVE
70 S=STICK(0)
75 X=X+(S=7 OR S=5 OR S=6)-(S=11 OR S=9 OR S=10)
80 Y=Y+(S=13 OR S=5 OR S=9)-(S=14 OR S=6 OR S=10)
84 REM LIMITS
85 IF X<0 THEN X=0
86 IF X>79 THEN X=79
87 IF Y<0 THEN Y=0
88 IF Y>39 THEN Y=39
90 GOTO 60
998 REM finito
999 STOP 
