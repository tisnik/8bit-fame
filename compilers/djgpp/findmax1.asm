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
        mov     ebp, esp
        .cfi_def_cfa_register 5
        sub     esp, 16
        mov     DWORD PTR [ebp-4], 0
        mov     eax, DWORD PTR [ebp+8]
        mov     DWORD PTR [ebp-12], eax
        mov     DWORD PTR [ebp-8], 0
        jmp     L2
L4:
        mov     eax, DWORD PTR [ebp-12]
        mov     eax, DWORD PTR [eax]
        cmp     DWORD PTR [ebp-4], eax
        jnb     L3
        mov     eax, DWORD PTR [ebp-12]
        mov     eax, DWORD PTR [eax]
        mov     DWORD PTR [ebp-4], eax
L3:
        add     DWORD PTR [ebp-12], 4
        inc     DWORD PTR [ebp-8]
L2:
        mov     eax, DWORD PTR [ebp-8]
        cmp     eax, DWORD PTR [ebp+12]
        jb      L4
        mov     eax, DWORD PTR [ebp-4]
        leave
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
        .section .text
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
        push    ebx
        push    ecx
        .cfi_escape 0xf,0x3,0x75,0x70,0x6
        .cfi_escape 0x10,0x7,0x2,0x75,0x7c
        .cfi_escape 0x10,0x6,0x2,0x75,0x78
        .cfi_escape 0x10,0x3,0x2,0x75,0x74
        sub     esp, 56
        lea     eax, [ebp-68]
        mov     ebx, OFFSET FLAT:LC0
        mov     edx, 10
        mov     edi, eax
        mov     esi, ebx
        mov     ecx, edx
        rep movsd
        push    10
        lea     eax, [ebp-68]
        push    eax
        call    _find_max
        add     esp, 8
        mov     DWORD PTR [ebp-28], eax
        sub     esp, 8
        push    DWORD PTR [ebp-28]
        push    OFFSET FLAT:LC1
        call    _printf
        add     esp, 16
        mov     eax, 0
        lea     esp, [ebp-16]
        pop     ecx
        .cfi_restore 1
        .cfi_def_cfa 1, 0
        pop     ebx
        .cfi_restore 3
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
