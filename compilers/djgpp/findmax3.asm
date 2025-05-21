        .file   "find_max.c"
        .intel_syntax noprefix
        .section .text
        .globl  _find_max
_find_max:
LFB0:
        .cfi_startproc
        push    ebp
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        xor     eax, eax
        mov     ebp, esp
        .cfi_def_cfa_register 5
        xor     edx, edx
L2:
        cmp     eax, DWORD PTR [ebp+12]
        je      L7
        mov     ecx, DWORD PTR [ebp+8]
        mov     ecx, DWORD PTR [ecx+eax*4]
        cmp     edx, ecx
        jnb     L3
        mov     edx, ecx
L3:
        inc     eax
        jmp     L2
L7:
        mov     eax, edx
        pop     ebp
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE0:
LC1:
        .ascii "%d\12\0"
        .section .data
        .p2align 4
LC0:
        .long   5
        .long   6
        .long   7
        .long   8
        .long   9
        .long   0
        .long   1
        .long   2
        .long   3
        .long   4
        .section        .text.startup,"x"
        .globl  _main
_main:
LFB1:
        .cfi_startproc
        lea     ecx, [esp+4]
        .cfi_def_cfa 1, 0
        and     esp, -16
        push    DWORD PTR [ecx-4]
        push    ebp
        .cfi_escape 0x10,0x5,0x2,0x75,0
        mov     ebp, esp
        push    edi
        push    esi
        .cfi_escape 0x10,0x7,0x2,0x75,0x7c
        .cfi_escape 0x10,0x6,0x2,0x75,0x78
        mov     esi, OFFSET FLAT:LC0
        push    ecx
        .cfi_escape 0xf,0x3,0x75,0x74,0x6
        lea     edi, [ebp-64]
        sub     esp, 68
        mov     ecx, 10
        rep movsd
        lea     eax, [ebp-64]
        push    10
        push    eax
        call    _find_max
        pop     edx
        pop     ecx
        push    eax
        push    OFFSET FLAT:LC1
        call    _printf
        lea     esp, [ebp-12]
        xor     eax, eax
        pop     ecx
        .cfi_restore 1
        .cfi_def_cfa 1, 0
        pop     esi
        .cfi_restore 6
        pop     edi
        .cfi_restore 7
        pop     ebp
        .cfi_restore 5
        lea     esp, [ecx-4]
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE1:
        .ident  "GCC: (GNU) 9.3.0"
