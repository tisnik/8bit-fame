rotate_right_8bit:
        push    rbp
        mov     rbp, rsp
        mov     edx, edi
        mov     eax, esi
        mov     BYTE PTR [rbp-20], dl
        mov     BYTE PTR [rbp-24], al
        movzx   edx, BYTE PTR [rbp-20]
        movzx   eax, BYTE PTR [rbp-24]
        movzx   eax, al
        and     eax, 7
        mov     ecx, eax
        ror     dl, cl
        mov     eax, edx
        mov     BYTE PTR [rbp-1], al
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        ret

rotate_right_16bit:
        push    rbp
        mov     rbp, rsp
        mov     edx, edi
        mov     eax, esi
        mov     WORD PTR [rbp-20], dx
        mov     WORD PTR [rbp-24], ax
        movzx   edx, WORD PTR [rbp-20]
        movzx   eax, WORD PTR [rbp-24]
        movzx   eax, ax
        and     eax, 15
        mov     ecx, eax
        ror     dx, cl
        mov     eax, edx
        mov     WORD PTR [rbp-2], ax
        movzx   eax, WORD PTR [rbp-2]
        pop     rbp
        ret

rotate_right_32bit:
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-20], edi
        mov     DWORD PTR [rbp-24], esi
        mov     edx, DWORD PTR [rbp-20]
        mov     eax, DWORD PTR [rbp-24]
        and     eax, 31
        mov     ecx, eax
        ror     edx, cl
        mov     eax, edx
        mov     DWORD PTR [rbp-4], eax
        mov     eax, DWORD PTR [rbp-4]
        pop     rbp
        ret

rotate_right_64bit:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-24], rdi
        mov     QWORD PTR [rbp-32], rsi
        mov     rdx, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rbp-32]
        and     eax, 63
        mov     ecx, eax
        ror     rdx, cl
        mov     rax, rdx
        mov     QWORD PTR [rbp-8], rax
        mov     rax, QWORD PTR [rbp-8]
        pop     rbp
        ret
