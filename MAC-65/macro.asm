10       .MACRO PUSHXY 
20       TXA 
30       PHA 
40       TYA 
50       PHA 
60       .ENDM 
0100     .OPT OBJ
0102     *=  $9000
0200     LDX #1
0201     LDY #2
0202      PUSHXY  
0203     BRK 
