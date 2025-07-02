;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

section .text

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy


main:
        mov     ax, 13h            ; graficky rezim 320x200x256
        int     10h

        push    0xa000
        pop     ES                 ; segment obrazove pameti karty VGA

            fld dword [initb]
            fstp dword [b]
            mov word[loop1],0
            jmp @A1
    @L1:
            inc word [loop1]
    @A1:
            fld dword[b]
            fadd dword[lp]
            fstp dword[b]
            fld dword[inita]
            fstp dword[a]
            mov word[loop2],0
            jmp @A2

    @L2:
            inc word [loop2]

    @A2:
            fld dword[a]
            fadd dword[lp2]
            fstp dword[a]
            call iterate

            cmp bx,word [maxi]
            jae @NOPUT
            call putpixel

   @NOPUT:
            cmp word[loop2],320
            jne @L2
            cmp word[loop1],200
            jne @L1

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu

iterate:
            fld dword [a]
            fld dword [b]
            fild dword [bout]
            xor bx,bx
            fldz
            fldz
            fldz
            fldz
    @ITER:
            fmul st0,st3
            fadd st0,st0
            fadd st0,st5
            fincstp
            fsub st0,st1
            fadd st0,st5
            fst  st2
            fmul st0,st0
            inc  bx
            fst  st6
            fdecstp
            fst  st2
            fmul st2,st0
            fdecstp
            fadd st0,st3
            fcomp st5
            fnstsw ax
            and ah,41h
            jz @OK
            cmp bx,word [maxi]
            jb @ITER
    @OK:
            finit
            ret

putpixel:
            push dx
            mov ax,320
            mul word [loop1]
            mov di,ax
            add di,word [loop2]
            adc dx,0
            pop cx
            cmp dx,cx

   @NOPAGING:
            add bl,byte [color]
            mov es:[di],bl
            ret

  b    :DD 0
  a    :DD 0
  loop1:DW 0
  loop2:DW 0
  initb:DD -1.2
  inita:DD -2.4
  lp   :DD 0.012
  lp2  :DD 0.012
  bout :DD 4
  maxi :DW 100
  color:DB -2
