ca65 V2.18 - Ubuntu 2.18-1
Main file   : memset5.asm
Current file: memset5.asm

000000r 1               ;
000000r 1               ; File generated by cc65 v 2.18 - Ubuntu 2.18-1
000000r 1               ;
000000r 1               	.fopt		compiler,"cc65 v 2.18 - Ubuntu 2.18-1"
000000r 1               	.setcpu		"6502"
000000r 1               	.smart		on
000000r 1               	.autoimport	on
000000r 1               	.case		on
000000r 1               	.debuginfo	off
000000r 1               	.importzp	sp, sreg, regsave, regbank
000000r 1               	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
000000r 1               	.macpack	longbranch
000000r 2               .macro  jeq     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                       bne     *+5
000000r 2                       jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               beq     Target
000000r 2                       .else
000000r 2                               bne     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jne     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               beq     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bne     Target
000000r 2                       .else
000000r 2                               beq     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jmi     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               bpl     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bmi     Target
000000r 2                       .else
000000r 2                               bpl     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jpl     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               bmi     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bpl     Target
000000r 2                       .else
000000r 2                               bmi     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jcs     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               bcc     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bcs     Target
000000r 2                       .else
000000r 2                               bcc     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jcc     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               bcs     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bcc     Target
000000r 2                       .else
000000r 2                               bcs     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jvs     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               bvc     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bvs     Target
000000r 2                       .else
000000r 2                               bvc     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               .macro  jvc     Target
000000r 2                       .if     .match(Target, 0)
000000r 2                               bvs     *+5
000000r 2                               jmp     Target
000000r 2                       .elseif .def(Target) .and .const((*-2)-(Target)) .and ((*+2)-(Target) <= 127)
000000r 2                               bvc     Target
000000r 2                       .else
000000r 2                               bvs     *+5
000000r 2                               jmp     Target
000000r 2                       .endif
000000r 2               .endmacro
000000r 2               
000000r 1               	.forceimport	__STARTUP__
000000r 1               	.export		_memset8
000000r 1               	.export		_main
000000r 1               
000000r 1               ; ---------------------------------------------------------------
000000r 1               ; void __near__ memset8 (__near__ unsigned char *, const unsigned char, unsigned char)
000000r 1               ; ---------------------------------------------------------------
000000r 1               
000000r 1               .segment	"CODE"
000000r 1               
000000r 1               .proc	_memset8: near
000000r 1               
000000r 1               .segment	"CODE"
000000r 1               
000000r 1               ;
000000r 1               ; {
000000r 1               ;
000000r 1  20 rr rr     	jsr     pusha
000003r 1               ;
000003r 1               ; *dest++ = c;
000003r 1               ;
000003r 1  A0 03        L0002:	ldy     #$03
000005r 1  20 rr rr     	jsr     ldaxysp
000008r 1  85 rr        	sta     regsave
00000Ar 1  86 rr        	stx     regsave+1
00000Cr 1  20 rr rr     	jsr     incax1
00000Fr 1  A0 02        	ldy     #$02
000011r 1  20 rr rr     	jsr     staxysp
000014r 1  A0 01        	ldy     #$01
000016r 1  B1 rr        	lda     (sp),y
000018r 1  88           	dey
000019r 1  91 rr        	sta     (regsave),y
00001Br 1               ;
00001Br 1               ; n--;
00001Br 1               ;
00001Br 1  B1 rr        	lda     (sp),y
00001Dr 1  38           	sec
00001Er 1  E9 01        	sbc     #$01
000020r 1  91 rr        	sta     (sp),y
000022r 1               ;
000022r 1               ; } while (n > 0);
000022r 1               ;
000022r 1  B1 rr        	lda     (sp),y
000024r 1  D0 DD        	bne     L0002
000026r 1               ;
000026r 1               ; }
000026r 1               ;
000026r 1  4C rr rr     	jmp     incsp4
000029r 1               
000029r 1               .endproc
000029r 1               
000029r 1               ; ---------------------------------------------------------------
000029r 1               ; int __near__ main (void)
000029r 1               ; ---------------------------------------------------------------
000029r 1               
000029r 1               .segment	"CODE"
000029r 1               
000029r 1               .proc	_main: near
000029r 1               
000029r 1               .segment	"BSS"
000000r 1               
000000r 1               L000A:
000000r 1  00 00        	.res	2,$00
000002r 1               L000C:
000002r 1  00           	.res	1,$00
000003r 1               L000E:
000003r 1  00           	.res	1,$00
000004r 1               
000004r 1               .segment	"CODE"
000029r 1               
000029r 1               ;
000029r 1               ; uint8_t *dest = (uint8_t *) 0x0600;
000029r 1               ;
000029r 1  A2 06        	ldx     #$06
00002Br 1  A9 00        	lda     #$00
00002Dr 1  8D rr rr     	sta     L000A
000030r 1  8E rr rr     	stx     L000A+1
000033r 1               ;
000033r 1               ; uint8_t bytes = 0xff;
000033r 1               ;
000033r 1  A9 FF        	lda     #$FF
000035r 1  8D rr rr     	sta     L000C
000038r 1               ;
000038r 1               ; uint8_t fill = 0x00;
000038r 1               ;
000038r 1  A9 00        	lda     #$00
00003Ar 1  8D rr rr     	sta     L000E
00003Dr 1               ;
00003Dr 1               ; memset8(dest, fill, bytes);
00003Dr 1               ;
00003Dr 1  AD rr rr     	lda     L000A
000040r 1  AE rr rr     	ldx     L000A+1
000043r 1  20 rr rr     	jsr     pushax
000046r 1  AD rr rr     	lda     L000E
000049r 1  20 rr rr     	jsr     pusha
00004Cr 1  AD rr rr     	lda     L000C
00004Fr 1  20 rr rr     	jsr     _memset8
000052r 1               ;
000052r 1               ; return 0;
000052r 1               ;
000052r 1  A2 00        	ldx     #$00
000054r 1  8A           	txa
000055r 1               ;
000055r 1               ; }
000055r 1               ;
000055r 1  60           	rts
000056r 1               
000056r 1               .endproc
000056r 1               
000056r 1               