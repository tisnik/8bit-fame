org 100h
  START:
            mov ax,0a000h
            mov es,ax
            mov ax,4f02h
            mov bx,101h
            int 10h        ; sets 640x480 256 color mode
            mov ax,4f06h
            mov bx,0
            mov cx,1280    ; sets virtual scanline width to 1280 px. Notice that you do not have to define height, but DX returns the maximum possible height.
            int 10h


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
            cmp word[loop2],1279
            jne @L2
            cmp word[loop1],959
            jne @L1

            xor ax,ax   ;wait for keypress
            int 16h
            mov ax,4f07h  ;this block sets lower left page 2
            xor bx,bx
            mov bl,00h
            mov cx,0
            mov dx,480
            int 10h

            xor ax,ax   ;wait for keypress
            int 16h
            mov ax,4f07h  ;this block sets lower right page 3
            xor bx,bx
            mov bl,00h
            mov cx,640
            mov dx,480
            int 10h

            xor ax,ax   ;wait for keypress
            int 16h
            mov ax,4f07h  ;this block sets upper right page 4
            xor bx,bx
            mov bl,00h
            mov cx,640
            mov dx,0
            int 10h

            xor ax,ax  ;wait for keypress
            int 16h
            mov ax,4f07h  ;this block sets back original upper left page 1
            xor bx,bx
            mov bl,00h
            mov cx,0
            mov dx,0
            int 10h

            xor ax,ax
            int 16h
            mov ax,3
            int 10h
            mov ax,4c00h
	    INT 21h

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
            mov ax,1280
            mul word [loop1]
            mov di,ax
            add di,word [loop2]
            adc dx,0
            pop cx
            cmp dx,cx
            je @NOPAGING
            push bx
            mov ax,4f05h   ;Window number=dx
            mov bx,00h     ;bh=function(0) bl=window(0)
            int 10h
            pop bx

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
  lp   :DD 0.0025
  lp2  :DD 0.0025
  bout :DD 4
  maxi :DW 10
  color:DB -2
