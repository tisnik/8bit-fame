PAGE 1    
                                                                 



                10       .MACRO PUSHXY 
                20       TXA 
                30       PHA 
                40       TYA 
                50       PHA 
                60       .ENDM 
0000            0100     .OPT OBJ
0000            0102     *=  $9000
9000 A201       0200     LDX #1
9002 A002       0201     LDY #2
                0202      PUSHXY  
9004 8A        M         TXA 
9005 48        M         PHA 
9006 98        M         TYA 
9007 48        M         PHA 
               M         .ENDM 
9008 00         0203     BRK 

ASSEMBLY ERRORS: 0   33988 BYTES FREE
PAGE 2    
SYMBOLS                                                          




%173A PUSHXY        
