find_max:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-24], rdi
        mov     DWORD PTR [rbp-28], esi
        mov     DWORD PTR [rbp-4], 0
        mov     rax, QWORD PTR [rbp-24]
        mov     QWORD PTR [rbp-16], rax
        mov     DWORD PTR [rbp-8], 0
        jmp     .L2
.L4:
        mov     rax, QWORD PTR [rbp-16]
        mov     eax, DWORD PTR [rax]
        cmp     DWORD PTR [rbp-4], eax
        jnb     .L3
        mov     rax, QWORD PTR [rbp-16]
        mov     eax, DWORD PTR [rax]
        mov     DWORD PTR [rbp-4], eax
.L3:
        add     QWORD PTR [rbp-16], 4
        add     DWORD PTR [rbp-8], 1
.L2:
        mov     eax, DWORD PTR [rbp-8]
        cmp     eax, DWORD PTR [rbp-28]
        jb      .L4
        mov     eax, DWORD PTR [rbp-4]
        pop     rbp
        ret
