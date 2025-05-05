        ifndef  ??version
?debug  macro
        endm
publicdll macro name
        public  name
        endm
$comm   macro   name,dist,size,count
        comm    dist name:BYTE:count*size
        endm
        else
$comm   macro   name,dist,size,count
        comm    dist name[size]:BYTE:count
        endm
        endif
        ?debug  S "find_max.c"
        ?debug  C E93B64A25A0A66696E645F6D61782E63
        ?debug  C E9001097161B433A5C424F524C414E44435C494E434C5544455C73+
        ?debug  C 7464696F2E68
_TEXT   segment byte public 'CODE'
_TEXT   ends
DGROUP  group   _DATA,_BSS
        assume  cs:_TEXT,ds:DGROUP
_DATA   segment word public 'DATA'
d@      label   byte
d@w     label   word
_DATA   ends
_BSS    segment word public 'BSS'
b@      label   byte
b@w     label   word
_BSS    ends
_TEXT   segment byte public 'CODE'
   ;    
   ;    uint find_max(uint *array, uint length) {
   ;    
        assume  cs:_TEXT
find_max        proc    near
        push    bp
        mov     bp,sp
        push    si
        push    di
   ;    
   ;        uint max = 0;
   ;    
        xor     di,di
   ;    
   ;        uint i;
   ;        uint *item = array;
   ;    
        mov     si,word ptr [bp+4]
   ;    
   ;    
   ;        for (i=0; i<length; i++) {
   ;    
        xor     dx,dx
        jmp     short @1@146
@1@50:
   ;    
   ;            if (max < *item) {
   ;    
        cmp     word ptr [si],di
        jbe     short @1@98
   ;    
   ;                max = *item;
   ;    
        mov     di,word ptr [si]
@1@98:
   ;    
   ;            }
   ;            item++;
   ;    
        inc     si
        inc     si
        inc     dx
@1@146:
        mov     ax,dx
        cmp     ax,word ptr [bp+6]
        jb      short @1@50
   ;    
   ;        }
   ;        return max;
   ;    
        mov     ax,di
        jmp     short @1@194
@1@194:
   ;    
   ;    }
   ;    
        pop     di
        pop     si
        pop     bp
        ret     
find_max        endp
_TEXT   ends
_DATA   segment word public 'DATA'
        db      5
        db      0
        db      6
        db      0
        db      7
        db      0
        db      8
        db      0
        db      9
        db      0
        db      0
        db      0
        db      1
        db      0
        db      2
        db      0
        db      3
        db      0
        db      4
        db      0
_DATA   ends
_TEXT   segment byte public 'CODE'
   ;    
   ;    int main(void) {
   ;    
        assume  cs:_TEXT
main    proc    near
        push    bp
        mov     bp,sp
        sub     sp,22
        push    ss
        lea     ax,word ptr [bp-22]
        push    ax
        push    ds
        mov     ax,offset DGROUP:d@w+0
        push    ax
        mov     cx,20
        call    near ptr N_SCOPY@
   ;    
   ;    #define LENGTH 10
   ;    
   ;        uint array[LENGTH] = {5, 6, 7, 8, 9, 0, 1, 2, 3, 4};
   ;        uint max = find_max(array, LENGTH);
   ;    
        mov     ax,10
        push    ax
        lea     ax,word ptr [bp-22]
        push    ax
        call    near ptr find_max
        pop     cx
        pop     cx
        mov     word ptr [bp-2],ax
   ;    
   ;        printf("%d\n", max);
   ;    
        push    word ptr [bp-2]
        mov     ax,offset DGROUP:s@
        push    ax
        call    near ptr printf
        pop     cx
        pop     cx
   ;    
   ;        return 0;
   ;    
        xor     ax,ax
        jmp     short @2@50
@2@50:
   ;    
   ;    }
   ;    
        mov     sp,bp
        pop     bp
        ret     
main    endp
        ?debug  C E9
_TEXT   ends
_DATA   segment word public 'DATA'
s@      label   byte
        db      '%d'
        db      10
        db      0
_DATA   ends
_TEXT   segment byte public 'CODE'
_TEXT   ends
        extrn   printf:near
        public  find_max
        public  main
        extrn   N_SCOPY@:far
        end
