        .file   "memset.c"
        .intel_syntax noprefix
        .section .text
        .p2align 4
        .globl  _memset
_memset:
LFB0:
        .cfi_startproc
        push    edi
        .cfi_def_cfa_offset 8
        .cfi_offset 7, -8
        push    ebx
        .cfi_def_cfa_offset 12
        .cfi_offset 3, -12
        mov     edx, DWORD PTR [esp+20]
        test    edx, edx
        je      L12
        xor     ebx, ebx
        mov     edi, DWORD PTR [esp+12]
        mov     bl, BYTE PTR [esp+16]
        cmp     edx, 4
        jnb     L22
L3:
        and     edx, 3
        je      L12
        xor     eax, eax
L6:
        mov     BYTE PTR [edi+eax], bl
        inc     eax
        cmp     eax, edx
        jb      L6
L12:
        mov     eax, DWORD PTR [esp+12]
        pop     ebx
        .cfi_remember_state
        .cfi_restore 3
        .cfi_def_cfa_offset 8
        pop     edi
        .cfi_restore 7
        .cfi_def_cfa_offset 4
        ret
        .p2align 4,,7
        .p2align 3
L22:
        .cfi_restore_state
        xor     eax, eax
        mov     al, bl
        mov     ah, al
        mov     ecx, eax
        sal     ecx, 16
        or      eax, ecx
        test    edi, 1
        jne     L23
L4:
        test    edi, 2
        jne     L24
L5:
        mov     ecx, edx
        shr     ecx, 2
        rep stosd
        jmp     L3
L23:
        mov     BYTE PTR [edi], al
        dec     edx
        mov     ecx, DWORD PTR [esp+12]
        lea     edi, [ecx+1]
        jmp     L4
L24:
        mov     WORD PTR [edi], ax
        sub     edx, 2
        add     edi, 2
        jmp     L5
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
