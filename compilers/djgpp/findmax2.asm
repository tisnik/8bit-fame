        .file   "find_max.c"
        .intel_syntax noprefix
        .section .text
        .p2align 4
        .globl  _find_max
_find_max:
LFB0:
        .cfi_startproc
        push    esi
        .cfi_def_cfa_offset 8
        .cfi_offset 6, -8
        push    ebx
        .cfi_def_cfa_offset 12
        .cfi_offset 3, -12
        mov     ebx, DWORD PTR [esp+16]
        mov     esi, DWORD PTR [esp+12]
        test    ebx, ebx
        je      L5
        xor     eax, eax
        xor     ecx, ecx
        .p2align 4,,7
        .p2align 3
L4:
        mov     edx, DWORD PTR [esi+eax*4]
        cmp     ecx, edx
        jnb     L3
        mov     ecx, edx
L3:
        inc     eax
        cmp     ebx, eax
        jne     L4
        pop     ebx
        .cfi_remember_state
        .cfi_restore 3
        .cfi_def_cfa_offset 8
        mov     eax, ecx
        pop     esi
        .cfi_restore 6
        .cfi_def_cfa_offset 4
        ret
        .p2align 4,,7
        .p2align 3
L5:
        .cfi_restore_state
        xor     ecx, ecx
        pop     ebx
        .cfi_restore 3
        .cfi_def_cfa_offset 8
        mov     eax, ecx
        pop     esi
        .cfi_restore 6
        .cfi_def_cfa_offset 4
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
        .p2align 4
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
        sub     esp, 60
        mov     ecx, 10
        rep movsd
        mov     eax, DWORD PTR [ebp-60]
        mov     edx, DWORD PTR [ebp-64]
        cmp     edx, eax
        jnb     L10
        mov     edx, eax
L10:
        mov     eax, DWORD PTR [ebp-56]
        cmp     eax, edx
        jnb     L11
        mov     eax, edx
L11:
        mov     edx, DWORD PTR [ebp-52]
        cmp     edx, eax
        jnb     L12
        mov     edx, eax
L12:
        mov     eax, DWORD PTR [ebp-48]
        cmp     eax, edx
        jnb     L13
        mov     eax, edx
L13:
        mov     edx, DWORD PTR [ebp-44]
        cmp     edx, eax
        jnb     L14
        mov     edx, eax
L14:
        mov     eax, DWORD PTR [ebp-40]
        cmp     eax, edx
        jnb     L15
        mov     eax, edx
L15:
        mov     edx, DWORD PTR [ebp-36]
        cmp     edx, eax
        jnb     L16
        mov     edx, eax
L16:
        mov     eax, DWORD PTR [ebp-32]
        cmp     eax, edx
        jnb     L17
        mov     eax, edx
L17:
        push    edx
        push    edx
        mov     edx, DWORD PTR [ebp-28]
        cmp     edx, eax
        jnb     L18
        mov     edx, eax
L18:
        push    edx
        push    OFFSET FLAT:LC1
        call    _printf
        add     esp, 16
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
