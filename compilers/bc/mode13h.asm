        ifndef  ??version
?debug  macro
        endm
publicdll macro name
        public  name
        endm
        endif
        ?debug  V 300h
        ?debug  S "MODE13H.C"
        ?debug  C E90A72C15A094D4F44453133482E43
        ?debug  C E900186B1719433A5C424F524C414E44435C494E434C5544455C44+
        ?debug  C 4F532E48
        ?debug  C E900186B171B433A5C424F524C414E44435C494E434C5544455C5F+
        ?debug  C 444546532E48
        ?debug  C E900186B171B433A5C424F524C414E44435C494E434C5544455C53+
        ?debug  C 5444494F2E48
        ?debug  C E900186B171B433A5C424F524C414E44435C494E434C5544455C5F+
        ?debug  C 4E554C4C2E48
MODE13H_TEXT    segment byte public 'CODE'
MODE13H_TEXT    ends
DGROUP  group   _DATA,_BSS
        assume  cs:MODE13H_TEXT,ds:DGROUP
_DATA   segment word public 'DATA'
d@      label   byte
d@w     label   word
_DATA   ends
_BSS    segment word public 'BSS'
b@      label   byte
b@w     label   word
_BSS    ends
MODE13H_TEXT    segment byte public 'CODE'
        ?debug  C E801094D4F44453133482E430A72C15A
   ;    
   ;    int main(void) {
   ;    
        ?debug  L 4
        assume  cs:MODE13H_TEXT
_main   proc    far
        ?debug  B
        push    bp
        mov     bp,sp
        sub     sp,6
        ?debug  B
   ;    
   ;        unsigned char far *ptr = (unsigned char*)MK_FP(0xa000, 0000);
   ;    
        ?debug  L 5
        mov     word ptr [bp-2],40960
        mov     word ptr [bp-4],0
   ;    
   ;        unsigned int i;
   ;        printf("%p\n", ptr);
   ;    
        ?debug  L 7
        push    word ptr [bp-2]
        push    word ptr [bp-4]
        push    ds
        mov     ax,offset DGROUP:s@
        push    ax
        call    far ptr _printf
        add     sp,8
   ;    
   ;        getch();
   ;    
        ?debug  L 8
        call    far ptr _getch
   ;    
   ;    
   ;        asm {
   ;            mov ah, 00h
   ;    
        ?debug  L 11
        mov      ah, 00h
   ;    
   ;            mov al, 13h
   ;    
        ?debug  L 12
        mov      al, 13h
   ;    
   ;            int 10h
   ;    
        ?debug  L 13
        int      10h
   ;    
   ;        }
   ;    
   ;        for (i=0; i<(unsigned)(320*200); i++) {
   ;    
        ?debug  L 16
        mov     word ptr [bp-6],0
@1@170:
   ;    
   ;            *ptr++ = i;
   ;    
        ?debug  L 17
        les     bx,dword ptr [bp-4]
        mov     al,byte ptr [bp-6]
        mov     byte ptr es:[bx],al
        inc     word ptr [bp-4]
        ?debug  L 16
        inc     word ptr [bp-6]
        cmp     word ptr [bp-6],64000
        jb      short @1@170
   ;    
   ;        }
   ;        getch();
   ;    
        ?debug  L 19
        call    far ptr _getch
   ;    
   ;        return 0;
   ;    
        ?debug  L 20
        xor     ax,ax
   ;    
   ;    }
   ;    
        ?debug  L 21
        mov     sp,bp
        pop     bp
        ret     
        ?debug  C E318000400160800
        ?debug  C E601690A02FAFF00037074721802FCFF00
        ?debug  E
        ?debug  E
_main   endp
        ?debug  C E9
        ?debug  C FA00000000
MODE13H_TEXT    ends
_DATA   segment word public 'DATA'
s@      label   byte
        db      '%p'
        db      10
        db      0
_DATA   ends
MODE13H_TEXT    segment byte public 'CODE'
MODE13H_TEXT    ends
        extrn   _getch:far
        public  _main
        extrn   _printf:far
_s@     equ     s@
        ?debug  C EA010C
        ?debug  C E31900000023040400
        ?debug  C EB065F67657463681900
        ?debug  C E31A00000023040400
        ?debug  C EC055F6D61696E1A1800
        ?debug  C E31B00000023040401
        ?debug  C EB075F7072696E74661B00
        ?debug  C E60666706F735F740606000673697A655F740A06+
        ?debug  C 00
        end
