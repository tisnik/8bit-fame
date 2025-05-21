Module: c:\add_f.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 00000017 bytes
0000                          add_:
0000    B8 04 00                  mov         ax,0x0004 
0003    E8 00 00                  call        __STK 
0006    55                        push        bp 
0007    89 E5                     mov         bp,sp 
0009    9B D9 46 04               fld         dword ptr 0x4[bp] 
000D    9B D8 46 08               fadd        dword ptr 0x8[bp] 
0011    90                        nop         
0012    9B                        fwait       
0013    5D                        pop         bp 
0014    C2 08 00                  ret         0x0008 

Routine Size: 23 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

