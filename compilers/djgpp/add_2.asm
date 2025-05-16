        .file   "add.c"
        .intel_syntax noprefix
        .section .text
        .p2align 4
        .globl  _add
_add:
LFB0:
        .cfi_startproc
        mov     eax, DWORD PTR [esp+8]
        mov     edx, DWORD PTR [esp+4]
        add     eax, edx
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
