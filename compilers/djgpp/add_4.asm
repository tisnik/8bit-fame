        .file   "add.c"
        .intel_syntax noprefix
        .section .text
        .globl  _add
_add:
LFB0:
        .cfi_startproc
        mov     eax, DWORD PTR [esp+8]
        add     eax, DWORD PTR [esp+4]
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
