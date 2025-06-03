	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "larger.c"
	?debug	C E96A8FBE5A086C61726765722E63
	?debug	C E900186B171B433A5C424F524C414E44435C494E434C5544455C73+
	?debug	C 7464696F2E68
	?debug	C E900186B171B433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 646566732E68
	?debug	C E900186B171B433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 6E756C6C2E68
LARGER_TEXT	segment byte public 'CODE'
LARGER_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:LARGER_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
LARGER_TEXT	segment byte public 'CODE'
   ;	
   ;	uint* larger_value(uint *x, uint *y) {
   ;	
	assume	cs:LARGER_TEXT
_larger_value	proc	far
	push	bp
	mov	bp,sp
   ;	
   ;	    if (*x > *y) {
   ;	
	les	bx,dword ptr [bp+6]
	mov	ax,word ptr es:[bx]
	les	bx,dword ptr [bp+10]
	cmp	ax,word ptr es:[bx]
	jbe	short @1@86
   ;	
   ;	        return x;
   ;	
	mov	dx,word ptr [bp+8]
	mov	ax,word ptr [bp+6]
	pop	bp
	ret	
@1@86:
   ;	
   ;	    } else {
   ;	        return y;
   ;	
	mov	dx,word ptr [bp+12]
	mov	ax,word ptr [bp+10]
   ;	
   ;	    }
   ;	}
   ;	
	pop	bp
	ret	
_larger_value	endp
   ;	
   ;	int main(void) {
   ;	
	assume	cs:LARGER_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
   ;	
   ;	    uint a = 1;
   ;	
	mov	word ptr [bp-2],1
   ;	
   ;	    uint b = 2;
   ;	
	mov	word ptr [bp-4],2
   ;	
   ;	
   ;	    printf("%d\n", *larger_value(&a, &b));
   ;	
	push	ss
	lea	ax,word ptr [bp-4]
	push	ax
	push	ss
	lea	ax,word ptr [bp-2]
	push	ax
	push	cs
	call	near ptr _larger_value
	add	sp,8
	mov	bx,ax
	mov	es,dx
	push	word ptr es:[bx]
	push	ds
	mov	ax,offset DGROUP:s@
	push	ax
	call	far ptr _printf
	add	sp,6
   ;	
   ;	    printf("%d\n", *larger_value(&b, &a));
   ;	
	push	ss
	lea	ax,word ptr [bp-2]
	push	ax
	push	ss
	lea	ax,word ptr [bp-4]
	push	ax
	push	cs
	call	near ptr _larger_value
	add	sp,8
	mov	bx,ax
	mov	es,dx
	push	word ptr es:[bx]
	push	ds
	mov	ax,offset DGROUP:s@+4
	push	ax
	call	far ptr _printf
	add	sp,6
   ;	
   ;	
   ;	    return 0;
   ;	
	xor	ax,ax
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_main	endp
	?debug	C E9
	?debug	C FA00000000
LARGER_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
	db	'%d'
	db	10
	db	0
	db	'%d'
	db	10
	db	0
_DATA	ends
LARGER_TEXT	segment byte public 'CODE'
LARGER_TEXT	ends
	public	_main
	public	_larger_value
	extrn	_printf:far
_s@	equ	s@
	end
