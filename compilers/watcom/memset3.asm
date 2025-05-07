Module: c:\memset.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE32 00000012 bytes
0000                          memset_:
0000    51                        push        ecx 
0001    89 C1                     mov         ecx,eax 
0003                          L$1:
0003    4B                        dec         ebx 
0004    83 FB FF                  cmp         ebx,0xffffffff 
0007    74 05                     je          L$2 
0009    88 10                     mov         byte ptr [eax],dl 
000B    40                        inc         eax 
000C    EB F5                     jmp         L$1 
000E                          L$2:
000E    89 C8                     mov         eax,ecx 
0010    59                        pop         ecx 
0011    C3                        ret         

Routine Size: 18 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST DWORD USE32 00000000 bytes

Segment: CONST2 DWORD USE32 00000000 bytes

Segment: _DATA DWORD USE32 00000000 bytes

