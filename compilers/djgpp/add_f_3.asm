        .file   "add_f.c"
        .intel_syntax noprefix
        .section .text
        .p2align 4
        .globl  _add
_add:
LFB0:
        .cfi_startproc
        fld     DWORD PTR [esp+8]
        fadd    DWORD PTR [esp+4]
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
