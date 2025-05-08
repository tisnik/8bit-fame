memset:
        push    rbp
        mov     rbp, rsp
        push    rbx
        mov     QWORD PTR [rbp-16], rdi
        mov     ecx, esi
        mov     eax, edx
        mov     rbx, QWORD PTR [rbp-16]
        jmp     .L2
.L3:
        mov     rdx, rbx
        lea     rbx, [rdx+1]
        mov     esi, ecx
        mov     BYTE PTR [rdx], sil
.L2:
        mov     edx, eax
        lea     eax, [rdx-1]
        test    edx, edx
        jne     .L3
        mov     rax, QWORD PTR [rbp-16]
        mov     rbx, QWORD PTR [rbp-8]
        leave
        ret
