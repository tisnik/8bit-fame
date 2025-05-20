        .file   "fill_a.c"
        .intel_syntax noprefix
        .section .text
        .p2align 4
        .globl  _fill_array
_fill_array:
LFB0:
        .cfi_startproc
        mov     ecx, DWORD PTR [esp+8]
        mov     edx, DWORD PTR [esp+12]
        test    ecx, ecx
        jle     L1
        mov     eax, DWORD PTR [esp+4]
        lea     ecx, [eax+ecx*4]
        .p2align 4,,7
        .p2align 3
L3:
        mov     DWORD PTR [eax], edx
        add     eax, 4
        cmp     ecx, eax
        jne     L3
L1:
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
