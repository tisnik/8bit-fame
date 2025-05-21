Module: c:\add_f.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 00000011 bytes
0000                          add_:
0000    55                        push        bp 
0001    89 E5                     mov         bp,sp 
0003    9B D9 46 04               fld         dword ptr 0x4[bp] 
0007    9B D8 46 08               fadd        dword ptr 0x8[bp] 
000B    90                        nop         
000C    9B                        fwait       
000D    5D                        pop         bp 
000E    C2 08 00                  ret         0x0008 

Routine Size: 17 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

