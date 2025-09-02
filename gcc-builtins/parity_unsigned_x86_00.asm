parity_char:
        push    rbp
        mov     rbp, rsp
        mov     eax, edi
        mov     BYTE PTR [rbp-4], al
        movzx   eax, BYTE PTR [rbp-4]
        mov     edx, eax
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   al
        movzx   eax, al
        pop     rbp
        ret

parity_int:
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-4], edi
        mov     eax, DWORD PTR [rbp-4]
        mov     edx, eax
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   al
        movzx   eax, al
        pop     rbp
        ret

parity_long:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        mov     rax, QWORD PTR [rbp-8]
        mov     rdx, rax
        shr     rdx, 32
        xor     eax, edx
        mov     edx, eax
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   al
        movzx   eax, al
        pop     rbp
        ret

parity_long_long:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        mov     rax, QWORD PTR [rbp-8]
        mov     rdx, rax
        shr     rdx, 32
        xor     eax, edx
        mov     edx, eax
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   al
        movzx   eax, al
        pop     rbp
        ret
