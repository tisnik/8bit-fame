        .file   "FILL_A.c"
        .intel_syntax noprefix
        .section .text
        .globl  _fill_array
_fill_array:
LFB0:
        .cfi_startproc
        mov     edx, DWORD PTR [esp+4]
        mov     ecx, DWORD PTR [esp+12]
        xor     eax, eax
L2:
        cmp     eax, DWORD PTR [esp+8]
        jge     L5
        mov     DWORD PTR [edx+eax*4], ecx
        inc     eax
        jmp     L2
L5:
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
