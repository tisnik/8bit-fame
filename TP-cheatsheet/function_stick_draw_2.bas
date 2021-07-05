1 ------------------------------
2 REM Usage of codes of eight
3 REM directions returned by
4 REM STICK function to draw.
5 REM
6 REM Boolean expressions are
7 REM used to move player.
8 ------------------------------
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
75 X=X+(S=7)-(S=11)+(S=5)+(S=6)-(S=9)-(S=10)
80 Y=Y+(S=13)-(S=14)+(S=5)+(S=9)-(S=6)-(S=10)
84 REM LIMITS
85 IF X<0 THEN X=0
86 IF X>79 THEN X=79
87 IF Y<0 THEN Y=0
88 IF Y>39 THEN Y=39
90 GOTO 60
999 STOP 
