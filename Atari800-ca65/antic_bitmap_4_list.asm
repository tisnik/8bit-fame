ca65 V2.18 - Fedora 2.19-12.fc42
Main file   : antic_bitmap_4.asm
Current file: antic_bitmap_4.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Grafický režim 160x192 se dvěma barvami.
000000r 1               ;
000000r 1               ; Tento zdrojový kód byl použit v článku:
000000r 1               ;
000000r 1               ; Praktické použití grafických režimů nabízených čipem ANTIC
000000r 1               ; https://www.root.cz/clanky/prakticke-pouziti-grafickych-rezimu-nabizenych-cipem-antic/
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               .include "atari.inc"
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Atari System Equates
000000r 2               ; by Freddy Offenga, Christian Groessler, and Christian Krueger
000000r 2               ;
000000r 2               ; References:
000000r 2               ; - Atari 400/800 OS rev.B source code, Atari 1979
000000r 2               ; - Atari OS manual - XL addendum
000000r 2               ; - Atari XL/XE rev.2 source code, Atari 1984
000000r 2               ; - Mapping the Atari - revised edition, Ian Chadwick 1985
000000r 2               ; - SpartaDOS-X User Guide  (Aug-8-2016)
000000r 2               ;
000000r 2               ; ##old##       old OS rev.B label - moved or deleted
000000r 2               ; ##1200xl##    new label introduced in 1200XL OS (rev.10/11)
000000r 2               ; ##rev2##      new label introduced in XL/XE OS rev.2
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Configuration Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               MAXDEV  = 33            ;offset to last possible entry of HATABS
000000r 2               IOCBSZ  = 16            ;length of IOCB
000000r 2               
000000r 2               SEIOCB  = 0*IOCBSZ      ;##rev2## screen editor IOCB index
000000r 2               MAXIOC  = 8*IOCBSZ      ;first invalid IOCB index
000000r 2               
000000r 2               DSCTSZ  = 128           ;##rev2## disk sector size
000000r 2               
000000r 2               LEDGE   = 2             ;left edge
000000r 2               REDGE   = 39            ;right edge
000000r 2               
000000r 2               INIML   = $0700         ;##rev2## initial MEMLO
000000r 2               
000000r 2               ICSORG  = $CC00         ;##rev2## international character set origin
000000r 2               DCSORG  = $E000         ;##rev2## domestic character set origin
000000r 2               
000000r 2               ; IOCB Command Code Equates
000000r 2               
000000r 2               OPEN    = $03           ;open
000000r 2               GETREC  = $05           ;get record
000000r 2               GETCHR  = $07           ;get character(s)
000000r 2               PUTREC  = $09           ;put record
000000r 2               PUTCHR  = $0B           ;put character(s)
000000r 2               CLOSE   = $0C           ;close
000000r 2               STATIS  = $0D           ;status
000000r 2               SPECIL  = $0E           ;special
000000r 2               
000000r 2               ; DOS IOCB command codes
000000r 2               
000000r 2               RENAME  = $20           ;rename disk file
000000r 2               DELETE  = $21           ;delete disk file
000000r 2               LOCKFL  = $23           ;lock file (set to read-only)
000000r 2               UNLOCK  = $24           ;unlock file
000000r 2               POINT   = $25           ;point sector
000000r 2               NOTE    = $26           ;note sector
000000r 2               GETFL   = $27           ;get file length
000000r 2               CHDIR_MYDOS     = $29   ;change directory (MyDOS)
000000r 2               MKDIR   = $2A           ;make directory (MyDOS/SpartaDOS)
000000r 2               RMDIR   = $2B           ;remove directory (SpartaDOS)
000000r 2               CHDIR_SPDOS     = $2C   ;change directory (SpartaDOS)
000000r 2               FORMAT  = $FE           ;format
000000r 2               
000000r 2               GETCWD  = $30           ;get current directory (MyDOS/SpartaDOS)
000000r 2               
000000r 2               ; Special Entry Command Equates
000000r 2               ; DOS Commands
000000r 2               ; Command line table, Index values for (DOSVEC),Y -- COMTAB
000000r 2               ; Compatible with OS/A+, DOS XL and SpartaDOS
000000r 2               
000000r 2               COMTAB  = 0             ;DOS entry jump vector
000000r 2               ZCRNAME = 3             ;file name crunch routine jump vector
000000r 2               BUFOFF  = 10            ;next parameter buffer offset
000000r 2               COMFNAM = 33            ;destination buffer for crunch routine
000000r 2               LBUF    = 63            ;command line input buffer
000000r 2               
000000r 2               ; Screen IOCB Commands
000000r 2               
000000r 2               DRAWLN  = $11           ;draw line
000000r 2               FILLIN  = $12           ;draw line with right fill
000000r 2               
000000r 2               ; ICAX1 Auxiliary Byte 1 Equates
000000r 2               
000000r 2               APPEND  = $01           ;open write append (D:)
000000r 2               DIRECT  = $02           ;open for directory access (D:)
000000r 2               OPNIN   = $04           ;open for input (all devices)
000000r 2               OPNOT   = $08           ;open for output (all devices)
000000r 2               MXDMOD  = $10           ;open for mixed mode (E:, S:)
000000r 2               INSCLR  = $20           ;open for input without clearing screen
000000r 2               
000000r 2               ; Device Code Equates
000000r 2               
000000r 2               CASSET  = 'C'           ;cassette
000000r 2               DISK    = 'D'           ;disk
000000r 2               SCREDT  = 'E'           ;screen editor
000000r 2               KBD     = 'K'           ;keyboard
000000r 2               PRINTR  = 'P'           ;printer
000000r 2               DISPLY  = 'S'           ;screen display
000000r 2               
000000r 2               ; SIO Command Code Equates
000000r 2               
000000r 2               SIO_FORMAT   = $21      ;format disk (default density)
000000r 2               SIO_FORMATS  = $22      ;1050: format medium density
000000r 2               SIO_CONFIG   = $44      ;configure drive
000000r 2               SIO_CONFIGSF = $4B      ;slow/fast configure drive??
000000r 2               SIO_RDPERCOM = $4E      ;read PERCOM block (XF551)
000000r 2               SIO_WRPERCOM = $4F      ;write PERCOM block (XF551)
000000r 2               SIO_WRITE    = $50      ;write sector
000000r 2               SIO_READ     = $52      ;read sector
000000r 2               SIO_STAT     = $53      ;get status information
000000r 2               SIO_VERIFY   = $56      ;verify sector
000000r 2               SIO_WRITEV   = $57      ;write sector with verify
000000r 2               SIO_WRITETRK = $60      ;write track (Speedy)
000000r 2               SIO_READTRK  = $62      ;read track (Speedy)
000000r 2               
000000r 2               ; SIO Status Code (DSTATS)
000000r 2               ; Input: data direction
000000r 2               ;     Bit #7 - W (write operation)
000000r 2               ;         #6 - R (read operation)
000000r 2               ; Output: status code
000000r 2               ;     $01 (001) -- OPERATION COMPLETE (NO ERRORS)
000000r 2               ;     $8A (138) -- DEVICE TIMEOUT (DOESN'T RESPOND)
000000r 2               ;     $8B (139) -- DEVICE NAK
000000r 2               ;     $8C (140) -- SERIAL BUS INPUT FRAMING ERROR
000000r 2               ;     $8E (142) -- SERIAL BUS DATA FRAME OVERRUN ERROR
000000r 2               ;     $8F (143) -- SERIAL BUS DATA FRAME CHECKSUM ERROR
000000r 2               ;     $90 (144) -- DEVICE DONE ERROR
000000r 2               
000000r 2               ; Character and Key Code Equates
000000r 2               
000000r 2               CLS     = $7D           ;##rev2## clear screen
000000r 2               EOL     = $9B           ;end of line (RETURN)
000000r 2               
000000r 2               HELP    = $11           ;##1200xl## key code for HELP
000000r 2               CNTLF1  = $83           ;##1200xl## key code for CTRL-F1
000000r 2               CNTLF2  = $84           ;##1200xl## key code for CTRL-F2
000000r 2               CNTLF3  = $93           ;##1200xl## key code for CTRL-F3
000000r 2               CNTLF4  = $94           ;##1200xl## key code for CTRL-F4
000000r 2               CNTL1   = $9F           ;##1200xl## key code for CTRL-1
000000r 2               
000000r 2               ; Status Code Equates
000000r 2               
000000r 2               SUCCES  = 1             ;($01) succesful operation
000000r 2               
000000r 2               BRKABT  = 128           ;($80) BREAK key abort
000000r 2               PRVOPN  = 129           ;($81) IOCB already open error
000000r 2               NONDEV  = 130           ;($82) nonexistent device error
000000r 2               WRONLY  = 131           ;($83) IOCB opened for write only error
000000r 2               NVALID  = 132           ;($84) invalid command error
000000r 2               NOTOPN  = 133           ;($85) device/file not open error
000000r 2               BADIOC  = 134           ;($86) invalid IOCB index error
000000r 2               RDONLY  = 135           ;($87) IOCB opened for read only error
000000r 2               EOFERR  = 136           ;($88) end of file error
000000r 2               TRNRCD  = 137           ;($89) truncated record error
000000r 2               TIMOUT  = 138           ;($8A) peripheral device timeout error
000000r 2               DNACK   = 139           ;($8B) device does not acknowledge command
000000r 2               FRMERR  = 140           ;($8C) serial bus framing error
000000r 2               CRSROR  = 141           ;($8D) cursor overrange error
000000r 2               OVRRUN  = 142           ;($8E) serial bus data overrun error
000000r 2               CHKERR  = 143           ;($8F) serial bus checksum error
000000r 2               DERROR  = 144           ;($90) device done (operation incomplete)
000000r 2               BADMOD  = 145           ;($91) bad screen mode number error
000000r 2               FNCNOT  = 146           ;($92) function not implemented in handler
000000r 2               SCRMEM  = 147           ;($93) insufficient memory for screen mode
000000r 2               
000000r 2               DSKFMT  = 148           ;($94) SpartaDOS: unrecognized disk format
000000r 2               INCVER  = 149           ;($95) SpartaDOS: disk was made with incompat. version
000000r 2               DIRNFD  = 150           ;($96) SpartaDOS: directory not found
000000r 2               FEXIST  = 151           ;($97) SpartaDOS: file exists
000000r 2               NOTBIN  = 152           ;($98) SpartaDOS: file not binary
000000r 2               LSYMND  = 154           ;($9A) SDX: loader symbol not defined
000000r 2               BADPRM  = 156           ;($9C) SDX: bad parameter
000000r 2               OUTOFM  = 158           ;($9E) SDX: out of memory
000000r 2               INVDEV  = 160           ;($A0) invalid device number
000000r 2               TMOF    = 161           ;($A1) too many open files
000000r 2               DSKFLL  = 162           ;($A2) disk full
000000r 2               FATLIO  = 163           ;($A3) fatal I/O error
000000r 2               FNMSMT  = 164           ;($A4) internal file number mismatch
000000r 2               INVFNM  = 165           ;($A5) invalid file name
000000r 2               PDLERR  = 166           ;($A6) point data length error
000000r 2               EPERM   = 167           ;($A7) permission denied
000000r 2               DINVCM  = 168           ;($A8) command invalid for disk
000000r 2               DIRFLL  = 169           ;($A9) directory full
000000r 2               FNTFND  = 170           ;($AA) file not found
000000r 2               PNTINV  = 171           ;($AB) point invalid
000000r 2               BADDSK  = 173           ;($AD) bad disk
000000r 2               INCFMT  = 176           ;($B0) DOS 3: incompatible file system
000000r 2               XNTBIN  = 180           ;($B4) XDOS: file not binary
000000r 2               
000000r 2               ; DCB Device Bus Equates
000000r 2               
000000r 2               DISKID  = $31           ;##rev2## disk bus ID
000000r 2               PDEVN   = $40           ;##rev2## printer bus ID
000000r 2               CASET   = $60           ;##rev2## cassette bus ID
000000r 2               
000000r 2               ; Bus Command Equates
000000r 2               
000000r 2               FOMAT   = '!'           ;##rev2## format command
000000r 2               PUTSEC  = 'P'           ;##rev2## put sector command
000000r 2               READ    = 'R'           ;##rev2## read command
000000r 2               STATC   = 'S'           ;##rev2## status command
000000r 2               WRITE   = 'W'           ;##rev2## write command
000000r 2               
000000r 2               ; Command Auxiliary Byte Equates
000000r 2               
000000r 2               DOUBLE  = 'D'           ;##rev2## print 20 characters double width
000000r 2               NORMAL  = 'N'           ;##rev2## print 40 characters normally
000000r 2               PLOT    = 'P'           ;##rev2## plot
000000r 2               SIDWAY  = 'S'           ;##rev2## print 16 characters sideways
000000r 2               
000000r 2               ; Bus Response Equates
000000r 2               
000000r 2               ACK     = 'A'           ;##rev2## device acknowledged
000000r 2               COMPLT  = 'C'           ;##rev2## device succesfully completed operation
000000r 2               ERROR   = 'E'           ;##rev2## device incurred error
000000r 2               NACK    = 'N'           ;##rev2## device did not understand
000000r 2               
000000r 2               ; Floating Point Miscellaneous Equates
000000r 2               
000000r 2               FPREC   = 6             ;precision
000000r 2               
000000r 2               FMPREC  = FPREC-1       ;##rev2## length of mantissa
000000r 2               
000000r 2               ; Cassette Record Type Equates
000000r 2               
000000r 2               HDR     = $FB           ;##rev2## header
000000r 2               DTA     = $FC           ;##rev2## data record
000000r 2               DT1     = $FA           ;##rev2## last data record
000000r 2               EOT     = $FE           ;##rev2## end of tape (file)
000000r 2               
000000r 2               TONE1   = 2             ;##rev2## record
000000r 2               TONE2   = 1             ;##rev2## playback
000000r 2               
000000r 2               ; Cassette Timing Equates
000000r 2               
000000r 2               WLEADN  = 1152          ;##rev2## NTSC 19.2 second WRITE file leader
000000r 2               RLEADN  = 576           ;##rev2## NTSC 9.6 second READ file leader
000000r 2               WIRGLN  = 180           ;##rev2## NTSC 3.0 second WRITE IRG
000000r 2               RIRGLN  = 120           ;##rev2## NTSC 2.0 second READ IRG
000000r 2               WSIRGN  = 15            ;##rev2## NTSC 0.25 second WRITE short IRG
000000r 2               RSIRGN  = 10            ;##rev2## NTSC 0.16 second READ short IRG
000000r 2               BEEPNN  = 30            ;##rev2## NTSC 0.5 second beep duration
000000r 2               BEEPFN  = 10            ;##rev2## NTSC 0.16 seconrd beep duration
000000r 2               
000000r 2               WLEADP  = 960           ;##rev2## PAL 19.2 second WRITE file leader
000000r 2               RLEADP  = 480           ;##rev2## PAL 9.6 second READ file leader
000000r 2               WIRGLP  = 150           ;##rev2## PAL 3.0 second WRITE IRG
000000r 2               RIRGLP  = 100           ;##rev2## PAL 2.0 second READ IRG
000000r 2               WSIRGP  = 13            ;##rev2## PAL 0.25 second WRITE short IRG
000000r 2               RSIRGP  = 8             ;##rev2## PAL 0.16 second READ short IRG
000000r 2               BEEPNP  = 25            ;##rev2## PAL 0.5 second beep duration
000000r 2               BEEPFP  = 8             ;##rev2## PAL 0.16 seconrd beep duration
000000r 2               
000000r 2               WIRGHI  = 0             ;##rev2## high WRITE IRG
000000r 2               RIRGHI  = 0             ;##rev2## high READ IRG
000000r 2               
000000r 2               ; Power-up Validation Byte Value Equates
000000r 2               
000000r 2               PUPVL1  = $5C           ;##rev2## power-up validation value 1
000000r 2               PUPVL2  = $93           ;##rev2## power-up validation value 2
000000r 2               PUPVL3  = $25           ;##rev2## power-up validation value 3
000000r 2               
000000r 2               ; Relocating Loader Miscellaneous Equates
000000r 2               
000000r 2               DATAER  = 156           ;##rev2## end of record appears before END
000000r 2               MEMERR  = 157           ;##rev2## memory insufficient for load error
000000r 2               
000000r 2               ; Miscellaneous Equates
000000r 2               
000000r 2               IOCFRE  = $FF           ;IOCB free indication
000000r 2               
000000r 2               B19200  = $0028         ;##rev2## 19200 baud POKEY counter value
000000r 2               B00600  = $05CC         ;##rev2## 600 baud POKEY counter value
000000r 2               
000000r 2               HITONE  = $05           ;##rev2## FSK high freq. POKEY counter value
000000r 2               LOTONE  = $07           ;##rev2## FSK low freq. POKEY counter value
000000r 2               
000000r 2               NCOMLO  = $34           ;##rev2## PIA lower NOT COMMAND line command
000000r 2               NCOMHI  = $3C           ;##rev2## PIA raise NOT COMMAND line command
000000r 2               
000000r 2               MOTRGO  = $34           ;##rev2## PIA cassette motor ON command
000000r 2               MOTRST  = $3C           ;##rev2## PIA cassette motor OFF command
000000r 2               
000000r 2               NODAT   = $00           ;##rev2## SIO immediate operation
000000r 2               GETDAT  = $40           ;##rev2## SIO read data frame
000000r 2               PUTDAT  = $80           ;##rev2## SIO write data frame
000000r 2               
000000r 2               CRETRI  = 13            ;##rev2## number of command frame retries
000000r 2               DRETRI  = 1             ;##rev2## number of device retries
000000r 2               CTIM    = 2             ;##rev2## command frame ACK timeout
000000r 2               
000000r 2               NBUFSZ  = 40            ;##rev2## print normal buffer size
000000r 2               DBUFSZ  = 20            ;##rev2## print double buffer size
000000r 2               SBUFSZ  = 29            ;##rev2## print sideways buffer size
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Page Zero Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               LINZBS  = $00           ;LINBUG RAM (WILL BE REPLACED BY MONITOR RAM)
000000r 2               LNFLG   = $00           ;##1200xl## 1-byte LNBUG flag (0 = not LNBUG)
000000r 2               NGFLAG  = $01           ;##1200xl## 1-byte memory status (0 = failure)
000000r 2               
000000r 2               ; Not Cleared
000000r 2               
000000r 2               CASINI  = $02           ;CASSETTE INIT LOCATION
000000r 2               RAMLO   = $04           ;RAM POINTER FOR MEMORY TEST
000000r 2               TRAMSZ  = $06           ;TEMPORARY REGISTER FOR RAM SIZE
000000r 2               ;TSTDAT = $07           ;##old## RAM TEST DATA REGISTER
000000r 2               CMCMD   = $07           ;##rev2## 1-byte command communications
000000r 2               
000000r 2               ; Cleared upon Coldstart only
000000r 2               
000000r 2               WARMST  = $08           ;WARM START FLAG
000000r 2               BOOTQ   = $09           ;SUCCESSFUL BOOT FLAG
000000r 2               DOSVEC  = $0A           ;DISK SOFTWARE START VECTOR
000000r 2               DOSINI  = $0C           ;DISK SOFTWARE INIT ADDRESS
000000r 2               APPMHI  = $0E           ;APPLICATIONS MEMORY HI LIMIT
000000r 2               
000000r 2               ; Cleared upon Coldstart or Warmstart
000000r 2               
000000r 2               INTZBS  = $10           ;INTERRUPT HANDLER
000000r 2               
000000r 2               POKMSK  = $10           ;SYSTEM MASK FOR POKEY IRQ ENABLE (shadow of IRQEN)
000000r 2               BRKKEY  = $11           ;BREAK KEY FLAG
000000r 2               RTCLOK  = $12           ;REAL TIME CLOCK (IN 16 MSEC UNITS>
000000r 2               BUFADR  = $15           ;INDIRECT BUFFER ADDRESS REGISTER
000000r 2               ICCOMT  = $17           ;COMMAND FOR VECTOR
000000r 2               DSKFMS  = $18           ;DISK FILE MANAGER POINTER
000000r 2               DSKUTL  = $1A           ;DISK UTILITIES POINTER
000000r 2               ABUFPT  = $1C           ;##1200xl## 4-byte ACMI buffer pointer area
000000r 2               
000000r 2               ;PTIMOT = $1C           ;##old## PRINTER TIME OUT REGISTER
000000r 2               ;PBPNT  = $1D           ;##old## PRINT BUFFER POINTER
000000r 2               ;PBUFSZ = $1E           ;##old## PRINT BUFFER SIZE
000000r 2               ;PTEMP  = $1F           ;##old## TEMPORARY REGISTER
000000r 2               
000000r 2               ZIOCB   = $20           ;ZERO PAGE I/O CONTROL BLOCK
000000r 2               IOCBAS  = $20           ;16-byte page zero IOCB
000000r 2               ICHIDZ  = $20           ;HANDLER INDEX NUMBER (FF = IOCB FREE)
000000r 2               ICDNOZ  = $21           ;DEVICE NUMBER (DRIVE NUMBER)
000000r 2               ICCOMZ  = $22           ;COMMAND CODE
000000r 2               ICSTAZ  = $23           ;STATUS OF LAST IOCB ACTION
000000r 2               ICBALZ  = $24           ;BUFFER ADDRESS LOW BYTE
000000r 2               ICBAHZ  = $25           ;1-byte high buffer address
000000r 2               ICPTLZ  = $26           ;PUT BYTE ROUTINE ADDRESS -1
000000r 2               ICPTHZ  = $27           ;1-byte high PUT-BYTE routine address
000000r 2               ICBLLZ  = $28           ;BUFFER LENGTH LOW BYTE
000000r 2               ICBLHZ  = $29           ;1-byte high buffer length
000000r 2               ICAX1Z  = $2A           ;AUXILIARY INFORMATION FIRST BYTE
000000r 2               ICAX2Z  = $2B           ;1-byte second auxiliary information
000000r 2               ICSPRZ  = $2C           ;4-byte spares
000000r 2               
000000r 2               ENTVEC  = $2C           ;##rev2## 2-byte (not used)
000000r 2               ICIDNO  = $2E           ;IOCB NUMBER X 16
000000r 2               CIOCHR  = $2F           ;CHARACTER BYTE FOR CURRENT OPERATION
000000r 2               
000000r 2               STATUS  = $30           ;INTERNAL STATUS STORAGE
000000r 2               CHKSUM  = $31           ;CHECKSUM (SINGLE BYTE SUM WITH CARRY)
000000r 2               BUFRLO  = $32           ;POINTER TO DATA BUFFER (LO BYTE)
000000r 2               BUFRHI  = $33           ;POINTER TO DATA BUFFER (HI BYTE)
000000r 2               BFENLO  = $34           ;NEXT BYTE PAST END OF THE DATA BUFFER LO
000000r 2               BFENHI  = $35           ;NEXT BYTE PAST END OF THE DATA BUFFER HI
000000r 2               ;CRETRY = $36           ;##old## NUMBER OF COMMAND FRAME RETRIES
000000r 2               ;DRETRY = $37           ;##old## NUMBER OF DEVICE RETRIES
000000r 2               LTEMP   = $36           ;##1200xl## 2-byte loader temporary
000000r 2               BUFRFL  = $38           ;DATA BUFFER FULL FLAG
000000r 2               RECVDN  = $39           ;RECEIVE DONE FLAG
000000r 2               XMTDON  = $3A           ;TRANSMISSION DONE FLAG
000000r 2               CHKSNT  = $3B           ;CHECKSUM SENT FLAG
000000r 2               NOCKSM  = $3C           ;NO CHECKSUM FOLLOWS DATA FLAG
000000r 2               BPTR    = $3D           ;1-byte cassette buffer pointer
000000r 2               FTYPE   = $3E           ;1-byte cassette IRG type
000000r 2               FEOF    = $3F           ;1-byte cassette EOF flag (0 = quiet)
000000r 2               FREQ    = $40           ;1-byte cassette beep counter
000000r 2               SOUNDR  = $41           ;NOISY I/0 FLAG. (ZERO IS QUIET)
000000r 2               
000000r 2               CRITIC  = $42           ;DEFINES CRITICAL SECTION (CRITICAL IF NON-Z)
000000r 2               
000000r 2               FMSZPG  = $43           ;DISK FILE MANAGER SYSTEM ZERO PAGE
000000r 2               
000000r 2               ;CKEY   = $4A           ;##old## FLAG SET WHEN GAME START PRESSED
000000r 2               ZCHAIN  = $4A           ;##1200xl## 2-byte handler linkage chain pointer
000000r 2               ;CASSBT = $4B           ;##old## CASSETTE BOOT FLAG
000000r 2               DSTAT   = $4C           ;DISPLAY STATUS
000000r 2               ATRACT  = $4D           ;ATRACT FLAG
000000r 2               DRKMSK  = $4E           ;DARK ATRACT MASK
000000r 2               COLRSH  = $4F           ;ATRACT COLOR SHIFTER (EOR'ED WITH PLAYFIELD
000000r 2               
000000r 2               
000000r 2               TMPCHR  = $50           ;1-byte temporary character
000000r 2               HOLD1   = $51           ;1-byte temporary
000000r 2               LMARGN  = $52           ;left margin (normally 2, cc65 C startup code sets it to 0)
000000r 2               RMARGN  = $53           ;right margin (normally 39 if no XEP80 is used)
000000r 2               ROWCRS  = $54           ;1-byte cursor row
000000r 2               COLCRS  = $55           ;2-byte cursor column
000000r 2               DINDEX  = $57           ;1-byte display mode
000000r 2               SAVMSC  = $58           ;2-byte saved memory scan counter
000000r 2               OLDROW  = $5A           ;1-byte prior row
000000r 2               OLDCOL  = $5B           ;2-byte prior column
000000r 2               OLDCHR  = $5D           ;DATA UNDER CURSOR
000000r 2               OLDADR  = $5E           ;2-byte saved cursor memory address
000000r 2               FKDEF   = $60           ;##1200xl## 2-byte function key definition table
000000r 2               ;NEWROW = $60           ;##old## POINT DRAW GOES TO
000000r 2               ;NEWCOL = $61           ;##old##
000000r 2               PALNTS  = $62           ;##1200xl## 1-byte PAL/NTSC indicator (0 = NTSC)
000000r 2               LOGCOL  = $63           ;POINTS AT COLUMN IN LOGICAL LINE
000000r 2               ADRESS  = $64           ;2-byte temporary address
000000r 2               
000000r 2               MLTTMP  = $66           ;1-byte temporary
000000r 2               OPNTMP  = $66           ;FIRST BYTE IS USED IN OPEN AS TEMP
000000r 2               TOADR   = $66           ;##rev2## 2-byte destination address
000000r 2               
000000r 2               SAVADR  = $68           ;2-byte saved address
000000r 2               FRMADR  = $68           ;##rev2## 2-byte source address
000000r 2               
000000r 2               RAMTOP  = $6A           ;RAM SIZE DEFINED BY POWER ON LOGIC
000000r 2               BUFCNT  = $6B           ;BUFFER COUNT
000000r 2               BUFSTR  = $6C           ;EDITOR GETCH POINTER
000000r 2               BITMSK  = $6E           ;BIT MASK
000000r 2               SHFAMT  = $6F           ;1-byte shift amount for pixel justifucation
000000r 2               ROWAC   = $70           ;2-byte draw working row
000000r 2               COLAC   = $72           ;2-byte draw working column
000000r 2               ENDPT   = $74           ;2-byte end point
000000r 2               DELTAR  = $76           ;1-byte row difference
000000r 2               DELTAC  = $77           ;2-byte column difference
000000r 2               KEYDEF  = $79           ;##1200xl## 2-byte key definition table address
000000r 2               ;ROWINC = $79           ;##old##
000000r 2               ;COLINC = $7A           ;##old##
000000r 2               SWPFLG  = $7B           ;NON-0 1F TXT AND REGULAR RAM IS SWAPPED
000000r 2               HOLDCH  = $7C           ;CH IS MOVED HERE IN KGETCH BEFORE CNTL & SH
000000r 2               INSDAT  = $7D           ;1-byte temporary
000000r 2               COUNTR  = $7E           ;2-byte draw iteration count
000000r 2               
000000r 2               ; Floating Point Package Page Zero Address Equates
000000r 2               
000000r 2               FR0     = $D4           ;6-byte register 0
000000r 2               FR0M    = $D5           ;##rev2## 5-byte register 0 mantissa
000000r 2               QTEMP   = $D9           ;##rev2## 1-byte temporary
000000r 2               
000000r 2               FRE     = $DA           ;6-byte (internal) register E
000000r 2               
000000r 2               FR1     = $E0           ;FP REG1
000000r 2               FR1M    = $E1           ;##rev2## 5-byte register 1 mantissa
000000r 2               
000000r 2               FR2     = $E6           ;6-byte (internal) register 2
000000r 2               
000000r 2               FRX     = $EC           ;1-byte temporary
000000r 2               
000000r 2               EEXP    = $ED           ;VALUE OF E
000000r 2               
000000r 2               FRSIGN  = $EE           ;##rev2## 1-byte floating point sign
000000r 2               NSIGN   = $EE           ;SIGN OF #
000000r 2               
000000r 2               PLYCNT  = $EF           ;##rev2## 1-byte polynomial degree
000000r 2               ESIGN   = $EF           ;SIGN OF EXPONENT
000000r 2               
000000r 2               SGNFLG  = $F0           ;##rev2## 1-byte sign flag
000000r 2               FCHRFLG = $F0           ;1ST CHAR FLAG
000000r 2               
000000r 2               XFMFLG  = $F1           ;##rev2## 1-byte transform flag
000000r 2               DIGRT   = $F1           ;# OF DIGITS RIGHT OF DECIMAL
000000r 2               
000000r 2               CIX     = $F2           ;CURRENT INPUT INDEX
000000r 2               INBUFF  = $F3           ;POINTS TO USER'S LINE INPUT BUFFER
000000r 2               
000000r 2               ZTEMP1  = $F5           ;2-byte temporary
000000r 2               ZTEMP4  = $F7           ;2-byte temporary
000000r 2               ZTEMP3  = $F9           ;2-byte temporary
000000r 2               
000000r 2               ;DEGFLG = $FB           ;##old## same as RADFLG
000000r 2               ;RADFLG = $FB           ;##old## 0=RADIANS, 6=DEGREES
000000r 2               
000000r 2               FLPTR   = $FC           ;2-byte floating point number pointer
000000r 2               FPTR2   = $FE           ;2-byte floating point number pointer
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Page Two Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               INTABS  = $0200         ;INTERRUPT RAM
000000r 2               
000000r 2               VDSLST  = $0200         ;DISPLAY LIST NMI VECTOR
000000r 2               VPRCED  = $0202         ;PROCEED LINE IRQ VECTOR
000000r 2               VINTER  = $0204         ;INTERRUPT LINE IRQ VECTOR
000000r 2               VBREAK  = $0206         ;SOFTWARE BREAK (00) INSTRUCTION IRQ VECTOR
000000r 2               VKEYBD  = $0208         ;POKEY KEYBOARD IRQ VECTOR
000000r 2               VSERIN  = $020A         ;POKEY SERIAL INPUT READY IRQ
000000r 2               VSEROR  = $020C         ;POKEY SERIAL OUTPUT READY IRQ
000000r 2               VSEROC  = $020E         ;POKEY SERIAL OUTPUT COMPLETE IRQ
000000r 2               VTIMR1  = $0210         ;POKEY TIMER 1 IRQ
000000r 2               VTIMR2  = $0212         ;POKEY TIMER 2 IRQ
000000r 2               VTIMR4  = $0214         ;POKEY TIMER 4 IRQ
000000r 2               VIMIRQ  = $0216         ;IMMEDIATE IRQ VECTOR
000000r 2               CDTMV1  = $0218         ;COUNT DOWN TIMER 1
000000r 2               CDTMV2  = $021A         ;COUNT DOWN TIMER 2
000000r 2               CDTMV3  = $021C         ;COUNT DOWN TIMER 3
000000r 2               CDTMV4  = $021E         ;COUNT DOWN TIMER 4
000000r 2               CDTMV5  = $0220         ;COUNT DOWN TIMER 5
000000r 2               VVBLKI  = $0222         ;IMMEDIATE VERTICAL BLANK NMI VECTOR
000000r 2               VVBLKD  = $0224         ;DEFERRED VERTICAL BLANK NMI VECTOR
000000r 2               CDTMA1  = $0226         ;COUNT DOWN TIMER 1 JSR ADDRESS
000000r 2               CDTMA2  = $0228         ;COUNT DOWN TIMER 2 JSR ADDRESS
000000r 2               CDTMF3  = $022A         ;COUNT DOWN TIMER 3 FLAG
000000r 2               SRTIMR  = $022B         ;SOFTWARE REPEAT TIMER
000000r 2               CDTMF4  = $022C         ;COUNT DOWN TIMER 4 FLAG
000000r 2               INTEMP  = $022D         ;IAN'S TEMP
000000r 2               CDTMF5  = $022E         ;COUNT DOWN TIMER FLAG 5
000000r 2               SDMCTL  = $022F         ;SAVE DMACTL REGISTER
000000r 2               SDLSTL  = $0230         ;SAVE DISPLAY LIST LOW BYTE
000000r 2               SDLSTH  = $0231         ;SAVE DISPLAY LIST HI BYTE
000000r 2               SSKCTL  = $0232         ;SKCTL REGISTER RAM
000000r 2               LCOUNT  = $0233         ;##1200xl## 1-byte relocating loader record
000000r 2               LPENH   = $0234         ;LIGHT PEN HORIZONTAL VALUE
000000r 2               LPENV   = $0235         ;LIGHT PEN VERTICAL VALUE
000000r 2               BRKKY   = $0236         ;BREAK KEY VECTOR
000000r 2               ;RELADR = $0238         ;##1200xl## 2-byte relocatable loader address
000000r 2               VPIRQ   = $0238         ;##rev2## 2-byte parallel device IRQ vector
000000r 2               CDEVIC  = $023A         ;COMMAND FRAME BUFFER - DEVICE
000000r 2               CCOMND  = $023B         ;COMMAND
000000r 2               CAUX1   = $023C         ;COMMAND AUX BYTE 1
000000r 2               CAUX2   = $023D         ;COMMAND AUX BYTE 2
000000r 2               
000000r 2               TEMP    = $023E         ;TEMPORARY RAM CELL
000000r 2               
000000r 2               ERRFLG  = $023F         ;ERROR FLAG - ANY DEVICE ERROR EXCEPT TIME OUT
000000r 2               
000000r 2               DFLAGS  = $0240         ;DISK FLAGS FROM SECTOR ONE
000000r 2               DBSECT  = $0241         ;NUMBER OF DISK BOOT SECTORS
000000r 2               BOOTAD  = $0242         ;ADDRESS WHERE DISK BOOT LOADER WILL BE PUT
000000r 2               COLDST  = $0244         ;COLDSTART FLAG (1=IN MIDDLE OF COLDSTART>
000000r 2               RECLEN  = $0245         ;##1200xl## 1-byte relocating loader record length
000000r 2               DSKTIM  = $0246         ;DISK TIME OUT REGISTER
000000r 2               ;LINBUF = $0247         ;##old## CHAR LINE BUFFER
000000r 2               PDVMSK  = $0247         ;##rev2## 1-byte parallel device selection mask
000000r 2               SHPDVS  = $0248         ;##rev2## 1-byte PDVS (parallel device select)
000000r 2               PDIMSK  = $0249         ;##rev2## 1-byte parallel device IRQ selection
000000r 2               RELADR  = $024A         ;##rev2## 2-byte relocating loader relative adr.
000000r 2               PPTMPA  = $024C         ;##rev2## 1-byte parallel device handler temporary
000000r 2               PPTMPX  = $024D         ;##rev2## 1-byte parallel device handler temporary
000000r 2               
000000r 2               CHSALT  = $026B         ;##1200xl## 1-byte character set alternate
000000r 2               VSFLAG  = $026C         ;##1200xl## 1-byte fine vertical scroll count
000000r 2               KEYDIS  = $026D         ;##1200xl## 1-byte keyboard disable
000000r 2               FINE    = $026E         ;##1200xl## 1-byte fine scrolling mode
000000r 2               GPRIOR  = $026F         ;GLOBAL PRIORITY CELL
000000r 2               
000000r 2               PADDL0  = $0270         ;1-byte potentiometer 0
000000r 2               PADDL1  = $0271         ;1-byte potentiometer 1
000000r 2               PADDL2  = $0272         ;1-byte potentiometer 2
000000r 2               PADDL3  = $0273         ;1-byte potentiometer 3
000000r 2               PADDL4  = $0274         ;1-byte potentiometer 4
000000r 2               PADDL5  = $0275         ;1-byte potentiometer 5
000000r 2               PADDL6  = $0276         ;1-byte potentiometer 6
000000r 2               PADDL7  = $0277         ;1-byte potentiometer 7
000000r 2               
000000r 2               STICK0  = $0278         ;1-byte joystick 0
000000r 2               STICK1  = $0279         ;1-byte joystick 1
000000r 2               STICK2  = $027A         ;1-byte joystick 2
000000r 2               STICK3  = $027B         ;1-byte joystick 3
000000r 2               
000000r 2               PTRIG0  = $027C         ;1-byte paddle trigger 0
000000r 2               PTRIG1  = $027D         ;1-byte paddle trigger 1
000000r 2               PTRIG2  = $027E         ;1-byte paddle trigger 2
000000r 2               PTRIG3  = $027F         ;1-byte paddle trigger 3
000000r 2               PTRIG4  = $0280         ;1-byte paddle trigger 4
000000r 2               PTRIG5  = $0281         ;1-byte paddle trigger 5
000000r 2               PTRIG6  = $0281         ;1-byte paddle trigger 6
000000r 2               PTRIG7  = $0283         ;1-byte paddle trigger 7
000000r 2               
000000r 2               STRIG0  = $0284         ;1-byte joystick trigger 0
000000r 2               STRIG1  = $0285         ;1-byte joystick trigger 1
000000r 2               STRIG2  = $0286         ;1-byte joystick trigger 2
000000r 2               STRIG3  = $0287         ;1-byte joystick trigger 3
000000r 2               
000000r 2               ;CSTAT  = $0288         ;##old## cassette status register
000000r 2               HIBYTE  = $0288         ;##1200xl## 1-byte relocating loader high byte
000000r 2               WMODE   = $0289         ;1-byte cassette WRITE mode
000000r 2               BLIM    = $028A         ;1-byte cassette buffer limit
000000r 2               IMASK   = $028B         ;##rev2## (not used)
000000r 2               JVECK   = $028C         ;2-byte jump vector or temporary
000000r 2               NEWADR  = $028E         ;##1200xl## 2-byte relocating address
000000r 2               TXTROW  = $0290         ;TEXT ROWCRS
000000r 2               TXTCOL  = $0291         ;TEXT COLCRS
000000r 2               TINDEX  = $0293         ;TEXT INDEX
000000r 2               TXTMSC  = $0294         ;FOOLS CONVRT INTO NEW MSC
000000r 2               TXTOLD  = $0296         ;OLDROW & OLDCOL FOR TEXT (AND THEN SOME)
000000r 2               ;TMPX1  = $029C         ;##old## 1-byte temporary register
000000r 2               CRETRY  = $029C         ;##1200xl## 1-byte number of command frame retries
000000r 2               HOLD3   = $029D         ;1-byte temporary
000000r 2               SUBTMP  = $029E         ;1-byte temporary
000000r 2               HOLD2   = $029F         ;1-byte (not used)
000000r 2               DMASK   = $02A0         ;1-byte display (pixel location) mask
000000r 2               TMPLBT  = $02A1         ;1-byte (not used)
000000r 2               ESCFLG  = $02A2         ;ESCAPE FLAG
000000r 2               TABMAP  = $02A3         ;15-byte (120 bit) tab stop bit map
000000r 2               LOGMAP  = $02B2         ;LOGICAL LINE START BIT MAP
000000r 2               INVFLG  = $02B6         ;INVERSE VIDEO FLAG (TOGGLED BY ATARI KEY)
000000r 2               FILFLG  = $02B7         ;RIGHT FILL FLAG FOR DRAW
000000r 2               TMPROW  = $02B8         ;1-byte temporary row
000000r 2               TMPCOL  = $02B9         ;2-byte temporary column
000000r 2               SCRFLG  = $02BB         ;SET IF SCROLL OCCURS
000000r 2               HOLD4   = $02BC         ;TEMP CELL USED IN DRAW ONLY
000000r 2               ;HOLD5  = $02BD         ;##old## DITTO
000000r 2               DRETRY  = $02BD         ;##1200xl## 1-byte number of device retries
000000r 2               SHFLOK  = $02BE         ;1-byte shift/control lock flags
000000r 2               BOTSCR  = $02BF         ;BOTTOM OF SCREEN   24 NORM 4 SPLIT
000000r 2               
000000r 2               PCOLR0  = $02C0         ;1-byte player-missile 0 color/luminance
000000r 2               PCOLR1  = $02C1         ;1-byte player-missile 1 color/luminance
000000r 2               PCOLR2  = $02C2         ;1-byte player-missile 2 color/luminance
000000r 2               PCOLR3  = $02C3         ;1-byte player-missile 3 color/luminance
000000r 2               
000000r 2               COLOR0  = $02C4         ;1-byte playfield 0 color/luminance
000000r 2               COLOR1  = $02C5         ;1-byte playfield 1 color/luminance
000000r 2               COLOR2  = $02C6         ;1-byte playfield 2 color/luminance
000000r 2               COLOR3  = $02C7         ;1-byte playfield 3 color/luminance
000000r 2               
000000r 2               COLOR4  = $02C8         ;1-byte background color/luminance
000000r 2               
000000r 2               PARMBL  = $02C9         ;##rev2## 6-byte relocating loader parameter
000000r 2               RUNADR  = $02C9         ;##1200xl## 2-byte run address
000000r 2               HIUSED  = $02CB         ;##1200xl## 2-byte highest non-zero page address
000000r 2               ZHIUSE  = $02CD         ;##1200xl## 2-byte highest zero page address
000000r 2               
000000r 2               OLDPAR  = $02CF         ;##rev2## 6-byte relocating loader parameter
000000r 2               GBYTEA  = $02CF         ;##1200xl## 2-byte GET-BYTE routine address
000000r 2               LOADAD  = $02D1         ;##1200xl## 2-byte non-zero page load address
000000r 2               ZLOADA  = $02D3         ;##1200xl## 2-byte zero page load address
000000r 2               
000000r 2               DSCTLN  = $02D5         ;##1200xl## 2-byte disk sector length
000000r 2               ACMISR  = $02D7         ;##1200xl## 2-byte ACMI interrupt service routine
000000r 2               KRPDEL  = $02D9         ;##1200xl## 1-byte auto-repeat delay
000000r 2               KEYREP  = $02DA         ;##1200xl## 1-byte auto-repeat rate
000000r 2               NOCLIK  = $02DB         ;##1200xl## 1-byte key click disable
000000r 2               HELPFG  = $02DC         ;##1200xl## 1-byte HELP key flag (0 = no HELP)
000000r 2               DMASAV  = $02DD         ;##1200xl## 1-byte SDMCTL save/restore
000000r 2               PBPNT   = $02DE         ;##1200xl## 1-byte printer buffer pointer
000000r 2               PBUFSZ  = $02DF         ;##1200xl## 1-byte printer buffer size
000000r 2               
000000r 2               GLBABS  = $02E0         ;4-byte global variables for non-DOS users
000000r 2               RUNAD   = $02E0         ;##map## 2-byte binary file run address
000000r 2               INITAD  = $02E2         ;##map## 2-byte binary file initialization address
000000r 2               
000000r 2               RAMSIZ  = $02E4         ;RAM SIZE (HI BYTE ONLY)
000000r 2               MEMTOP  = $02E5         ;TOP OF AVAILABLE USER MEMORY
000000r 2               MEMLO   = $02E7         ;BOTTOM OF AVAILABLE USER MEMORY
000000r 2               HNDLOD  = $02E9         ;##1200xl## 1-byte user load flag
000000r 2               DVSTAT  = $02EA         ;STATUS BUFFER
000000r 2               CBAUDL  = $02EE         ;1-byte low cassette baud rate
000000r 2               CBAUDH  = $02EF         ;1-byte high cassette baud rate
000000r 2               CRSINH  = $02F0         ;CURSOR INHIBIT (00 = CURSOR ON)
000000r 2               KEYDEL  = $02F1         ;KEY DELAY
000000r 2               CH1     = $02F2         ;1-byte prior keyboard character
000000r 2               CHACT   = $02F3         ;CHACTL REGISTER RAM
000000r 2               CHBAS   = $02F4         ;CHBAS REGISTER RAM
000000r 2               
000000r 2               NEWROW  = $02F5         ;##1200xl## 1-byte draw destination row
000000r 2               NEWCOL  = $02F6         ;##1200xl## 2-byte draw destination column
000000r 2               ROWINC  = $02F8         ;##1200xl## 1-byte draw row increment
000000r 2               COLINC  = $02F9         ;##1200xl## 1-byte draw column increment
000000r 2               
000000r 2               CHAR    = $02FA         ;1-byte internal character
000000r 2               ATACHR  = $02FB         ;ATASCII CHARACTER
000000r 2               CH      = $02FC         ;GLOBAL VARIABLE FOR KEYBOARD
000000r 2               FILDAT  = $02FD         ;RIGHT FILL DATA <DRAW>
000000r 2               DSPFLG  = $02FE         ;DISPLAY FLAG   DISPLAY CNTLS IF NON-ZERO
000000r 2               SSFLAG  = $02FF         ;START/STOP FLAG FOR PAGING (CNTL 1). CLEARE
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Page Three Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               DCB     = $0300         ;DEVICE CONTROL BLOCK
000000r 2               DDEVIC  = $0300         ;PERIPHERAL UNIT 1 BUS I.D. NUMBER
000000r 2               DUNIT   = $0301         ;UNIT NUMBER
000000r 2               DCOMND  = $0302         ;BUS COMMAND
000000r 2               DSTATS  = $0303         ;COMMAND TYPE/STATUS RETURN
000000r 2               DBUFLO  = $0304         ;1-byte low data buffer address
000000r 2               DBUFHI  = $0305         ;1-byte high data buffer address
000000r 2               DTIMLO  = $0306         ;DEVICE TIME OUT IN 1 SECOND UNITS
000000r 2               DUNUSE  = $0307         ;UNUSED BYTE
000000r 2               DBYTLO  = $0308         ;1-byte low number of bytes to transfer
000000r 2               DBYTHI  = $0309         ;1-byte high number of bytes to transfer
000000r 2               DAUX1   = $030A         ;1-byte first command auxiliary
000000r 2               DAUX2   = $030B         ;1-byte second command auxiliary
000000r 2               
000000r 2               TIMER1  = $030C         ;INITIAL TIMER VALUE
000000r 2               ;ADDCOR = $030E         ;##old## ADDITION CORRECTION
000000r 2               JMPERS  = $030E         ;##1200xl## 1-byte jumper options
000000r 2               CASFLG  = $030F         ;CASSETTE MODE WHEN SET
000000r 2               TIMER2  = $0310         ;2-byte final baud rate timer value
000000r 2               TEMP1   = $0312         ;TEMPORARY STORAGE REGISTER
000000r 2               ;TEMP2  = $0314         ;##old## TEMPORARY STORAGE REGISTER
000000r 2               TEMP2   = $0313         ;##1200xl## 1-byte temporary
000000r 2               PTIMOT  = $0314         ;##1200xl## 1-byte printer timeout
000000r 2               TEMP3   = $0315         ;TEMPORARY STORAGE REGISTER
000000r 2               SAVIO   = $0316         ;SAVE SERIAL IN DATA PORT
000000r 2               TIMFLG  = $0317         ;TIME OUT FLAG FOR BAUD RATE CORRECTION
000000r 2               STACKP  = $0318         ;SIO STACK POINTER SAVE CELL
000000r 2               TSTAT   = $0319         ;TEMPORARY STATUS HOLDER
000000r 2               
000000r 2               HATABS  = $031A         ;35-byte handler address table (was 38 bytes)
000000r 2               PUPBT1  = $033D         ;##1200xl## 1-byte power-up validation byte 1
000000r 2               PUPBT2  = $033E         ;##1200xl## 1-byte power-up validation byte 2
000000r 2               PUPBT3  = $033F         ;##1200xl## 1-byte power-up validation byte 3
000000r 2               
000000r 2               IOCB    = $0340         ;I/O CONTROL BLOCKS
000000r 2               ICHID   = $0340         ;HANDLER INDEX NUMBER (FF=IOCB FREE)
000000r 2               ICDNO   = $0341         ;DEVICE NUMBER (DRIVE NUMBER)
000000r 2               ICCOM   = $0342         ;COMMAND CODE
000000r 2               ICSTA   = $0343         ;STATUS OF LAST IOCB ACTION
000000r 2               ICBAL   = $0344         ;1-byte low buffer address
000000r 2               ICBAH   = $0345         ;1-byte high buffer address
000000r 2               ICPTL   = $0346         ;1-byte low PUT-BYTE routine address - 1
000000r 2               ICPTH   = $0347         ;1-byte high PUT-BYTE routine address - 1
000000r 2               ICBLL   = $0348         ;1-byte low buffer length
000000r 2               ICBLH   = $0349         ;1-byte high buffer length
000000r 2               ICAX1   = $034A         ;1-byte first auxiliary information
000000r 2               ICAX2   = $034B         ;1-byte second auxiliary information
000000r 2               ICAX3   = $034C         ;1-byte third auxiliary information
000000r 2               ICAX4   = $034D         ;1-byte fourth auxiliary information
000000r 2               ICAX5   = $034E         ;1-byte fifth auxiliary information
000000r 2               ICSPR   = $034F         ;SPARE BYTE
000000r 2               
000000r 2               PRNBUF  = $03C0         ;PRINTER BUFFER
000000r 2               SUPERF  = $03E8         ;##1200xl## 1-byte editor super function flag
000000r 2               CKEY    = $03E9         ;##1200xl## 1-byte cassette boot request flag
000000r 2               CASSBT  = $03EA         ;##1200xl## 1-byte cassette boot flag
000000r 2               CARTCK  = $03EB         ;##1200xl## 1-byte cartridge equivalence check
000000r 2               DERRF   = $03EC         ;##rev2## 1-byte screen OPEN error flag
000000r 2               
000000r 2               ; Remainder of Page Three Not Cleared upon Reset
000000r 2               
000000r 2               ACMVAR  = $03ED         ;##1200xl## 11 bytes reserved for ACMI
000000r 2               BASICF  = $03F8         ;##rev2## 1-byte BASIC switch flag
000000r 2               MINTLK  = $03F9         ;##1200xl## 1-byte ACMI module interlock
000000r 2               GINTLK  = $03FA         ;##1200xl## 1-byte cartridge interlock
000000r 2               CHLINK  = $03FB         ;##1200xl## 2-byte loaded handler chain link
000000r 2               CASBUF  = $03FD         ;CASSETTE BUFFER
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Page Four/Five Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               ; USER AREA STARTS HERE AND GOES TO END OF PAGE FIVE
000000r 2               USAREA  = $0480         ;128 bytes reserved for application
000000r 2               
000000r 2               LBPR1   = $057E         ;LBUFF PREFIX 1
000000r 2               LBPR2   = $057F         ;LBUFF PREFIX 2
000000r 2               LBUFF   = $0580         ;128-byte line buffer
000000r 2               
000000r 2               PLYARG  = $05E0         ;6-byte floating point polynomial argument
000000r 2               FPSCR   = $05E6         ;6-byte floating point temporary
000000r 2               FPSCR1  = $05EC         ;6-byte floating point temporary
000000r 2               
000000r 2               ;LBFEND = $05FF         ;##old## END OF LBUFF
000000r 2               
000000r 2               
000000r 2               DOS     = $0700
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; SpartaDOS-X Definitions
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               SDX_FLAG     = DOS              ; 'S' for SpartaDOS
000000r 2               SDX_VERSION  = $0701            ; SD version (e.g. $32 = 3.2, $40 = 4.0)
000000r 2                                               ; address $0702 contains sub-version, e.g.
000000r 2                                               ; 8 in case of SDX 4.48
000000r 2               SDX_KERNEL   = $0703            ; SDX kernel entry point
000000r 2               SDX_BLOCK_IO = $0706            ; block I/O entry point
000000r 2               SDX_MISC     = $0709            ; "misc" entry point
000000r 2               SDX_DEVICE   = $0761
000000r 2               SDX_DATE     = $077B            ; day, month, year (3 bytes)
000000r 2               SDX_TIME     = $077E            ; hour, min, sec (3 bytes)
000000r 2               SDX_DATESET  = $0781
000000r 2               SDX_PATH     = $07A0            ; 64 bytes
000000r 2               SDX_IFSYMBOL = $07EB            ; only valid on SDX 4.40 or newer
000000r 2               SDX_S_LOOKUP = SDX_IFSYMBOL     ; alternative name for SDX_IFSYMBOL
000000r 2               
000000r 2               ; values for SDX_DEVICE
000000r 2               
000000r 2               SDX_CLK_DEV  = $10              ; clock device
000000r 2               
000000r 2               ; clock device functions
000000r 2               
000000r 2               SDX_KD_GETTD = 100              ; get time and date
000000r 2               SDX_KD_SETTD = 101              ; set time and date
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Cartridge Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               CARTCS  = $BFFA         ;##rev2## 2-byte cartridge coldstart address
000000r 2               CART    = $BFFC         ;##rev2## 1-byte cartridge present indicator
000000r 2                                       ;0=Cart Exists
000000r 2               CARTFG  = $BFFD         ;##rev2## 1-byte cartridge flags
000000r 2                                       ;D7  0=Not a Diagnostic Cart
000000r 2                                       ;    1=Is a Diagnostic cart and control is
000000r 2                                       ;      given to cart before any OS is init.
000000r 2                                       ;D2  0=Init but Do not Start Cart
000000r 2                                       ;    1=Init and Start Cart
000000r 2                                       ;D0  0=Do not boot disk
000000r 2                                       ;    1=Boot Disk
000000r 2               CARTAD  = $BFFE         ;##rev2## 2-byte cartridge start vector
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; CTIA/GTIA Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               GTIA    = $D000         ;CTIA/GTIA area
000000r 2               .include "atari_gtia.inc"
000000r 3               ;-------------------------------------------------------------------------
000000r 3               ; CTIA/GTIA Address Equates
000000r 3               ;-------------------------------------------------------------------------
000000r 3               
000000r 3               ; Read/Write Addresses
000000r 3               
000000r 3               CONSOL  = GTIA + $1F         ;console switches and speaker control
000000r 3               
000000r 3               ; Read Addresses
000000r 3               
000000r 3               M0PF    = GTIA + $00         ;missile 0 and playfield collision
000000r 3               M1PF    = GTIA + $01         ;missile 1 and playfield collision
000000r 3               M2PF    = GTIA + $02         ;missile 2 and playfield collision
000000r 3               M3PF    = GTIA + $03         ;missile 3 and playfield collision
000000r 3               
000000r 3               P0PF    = GTIA + $04         ;player 0 and playfield collision
000000r 3               P1PF    = GTIA + $05         ;player 1 and playfield collision
000000r 3               P2PF    = GTIA + $06         ;player 2 and playfield collision
000000r 3               P3PF    = GTIA + $07         ;player 3 and playfield collision
000000r 3               
000000r 3               M0PL    = GTIA + $08         ;missile 0 and player collision
000000r 3               M1PL    = GTIA + $09         ;missile 1 and player collision
000000r 3               M2PL    = GTIA + $0A         ;missile 2 and player collision
000000r 3               M3PL    = GTIA + $0B         ;missile 3 and player collision
000000r 3               
000000r 3               P0PL    = GTIA + $0C         ;player 0 and player collision
000000r 3               P1PL    = GTIA + $0D         ;player 1 and player collision
000000r 3               P2PL    = GTIA + $0E         ;player 2 and player collision
000000r 3               P3PL    = GTIA + $0F         ;player 3 and player collision
000000r 3               
000000r 3               TRIG0   = GTIA + $10         ;joystick trigger 0
000000r 3               TRIG1   = GTIA + $11         ;joystick trigger 1
000000r 3               
000000r 3               TRIG2   = GTIA + $12         ;cartridge interlock
000000r 3               TRIG3   = GTIA + $13         ;ACMI module interlock
000000r 3               
000000r 3               PAL     = GTIA + $14         ;##rev2## PAL/NTSC indicator
000000r 3               
000000r 3               ; Write Addresses
000000r 3               
000000r 3               HPOSP0  = GTIA + $00         ;player 0 horizontal position
000000r 3               HPOSP1  = GTIA + $01         ;player 1 horizontal position
000000r 3               HPOSP2  = GTIA + $02         ;player 2 horizontal position
000000r 3               HPOSP3  = GTIA + $03         ;player 3 horizontal position
000000r 3               
000000r 3               HPOSM0  = GTIA + $04         ;missile 0 horizontal position
000000r 3               HPOSM1  = GTIA + $05         ;missile 1 horizontal position
000000r 3               HPOSM2  = GTIA + $06         ;missile 2 horizontal position
000000r 3               HPOSM3  = GTIA + $07         ;missile 3 horizontal position
000000r 3               
000000r 3               SIZEP0  = GTIA + $08         ;player 0 size
000000r 3               SIZEP1  = GTIA + $09         ;player 1 size
000000r 3               SIZEP2  = GTIA + $0A         ;player 2 size
000000r 3               SIZEP3  = GTIA + $0B         ;player 3 size
000000r 3               
000000r 3               SIZEM   = GTIA + $0C         ;missile sizes
000000r 3               
000000r 3               GRAFP0  = GTIA + $0D         ;player 0 graphics
000000r 3               GRAFP1  = GTIA + $0E         ;player 1 graphics
000000r 3               GRAFP2  = GTIA + $0F         ;player 2 graphics
000000r 3               GRAFP3  = GTIA + $10         ;player 3 graphics
000000r 3               
000000r 3               GRAFM   = GTIA + $11         ;missile graphics
000000r 3               
000000r 3               COLPM0  = GTIA + $12         ;player-missile 0 color/luminance
000000r 3               COLPM1  = GTIA + $13         ;player-missile 1 color/luminance
000000r 3               COLPM2  = GTIA + $14         ;player-missile 2 color/luminance
000000r 3               COLPM3  = GTIA + $15         ;player-missile 3 color/luminance
000000r 3               
000000r 3               COLPF0  = GTIA + $16         ;playfield 0 color/luminance
000000r 3               COLPF1  = GTIA + $17         ;playfield 1 color/luminance
000000r 3               COLPF2  = GTIA + $18         ;playfield 2 color/luminance
000000r 3               COLPF3  = GTIA + $19         ;playfield 3 color/luminance
000000r 3               
000000r 3               COLBK   = GTIA + $1A         ;background color/luminance
000000r 3               
000000r 3               PRIOR   = GTIA + $1B         ;priority select
000000r 3               VDELAY  = GTIA + $1C         ;vertical delay
000000r 3               GRACTL  = GTIA + $1D         ;graphic control
000000r 3               HITCLR  = GTIA + $1E         ;collision clear
000000r 3               
000000r 3               
000000r 3               ; Hue values
000000r 3               
000000r 3               HUE_GREY        = 0
000000r 3               HUE_GOLD        = 1
000000r 3               HUE_GOLDORANGE  = 2
000000r 3               HUE_REDORANGE   = 3
000000r 3               HUE_ORANGE      = 4
000000r 3               HUE_MAGENTA     = 5
000000r 3               HUE_PURPLE      = 6
000000r 3               HUE_BLUE        = 7
000000r 3               HUE_BLUE2       = 8
000000r 3               HUE_CYAN        = 9
000000r 3               HUE_BLUEGREEN   = 10
000000r 3               HUE_BLUEGREEN2  = 11
000000r 3               HUE_GREEN       = 12
000000r 3               HUE_YELLOWGREEN = 13
000000r 3               HUE_YELLOW      = 14
000000r 3               HUE_YELLOWRED   = 15
000000r 3               
000000r 3               ; Color defines, similar to c64 colors (untested)
000000r 3               
000000r 3               GTIA_COLOR_BLACK      = (HUE_GREY << 4)
000000r 3               GTIA_COLOR_WHITE      = (HUE_GREY << 4 | 7 << 1)
000000r 3               GTIA_COLOR_RED        = (HUE_REDORANGE << 4 | 1 << 1)
000000r 3               GTIA_COLOR_CYAN       = (HUE_CYAN << 4 | 3 << 1)
000000r 3               GTIA_COLOR_VIOLET     = (HUE_PURPLE << 4 | 4 << 1)
000000r 3               GTIA_COLOR_GREEN      = (HUE_GREEN << 4 | 2 << 1)
000000r 3               GTIA_COLOR_BLUE       = (HUE_BLUE << 4 | 2 << 1)
000000r 3               GTIA_COLOR_YELLOW     = (HUE_YELLOW << 4 | 7 << 1)
000000r 3               GTIA_COLOR_ORANGE     = (HUE_ORANGE << 4 | 5 << 1)
000000r 3               GTIA_COLOR_BROWN      = (HUE_YELLOW << 4 | 2 << 1)
000000r 3               GTIA_COLOR_LIGHTRED   = (HUE_REDORANGE << 4 | 6 << 1)
000000r 3               GTIA_COLOR_GRAY1      = (HUE_GREY << 4 | 2 << 1)
000000r 3               GTIA_COLOR_GRAY2      = (HUE_GREY << 4 | 3 << 1)
000000r 3               GTIA_COLOR_LIGHTGREEN = (HUE_GREEN << 4 | 6 << 1)
000000r 3               GTIA_COLOR_LIGHTBLUE  = (HUE_BLUE << 4 | 6 << 1)
000000r 3               GTIA_COLOR_GRAY3      = (HUE_GREY << 4 | 5 << 1)
000000r 3               
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; PBI Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               PBI     = $D100         ;##rev2## parallel bus interface area
000000r 2               
000000r 2               ; Read Addresses
000000r 2               
000000r 2               PDVI    = $D1FF         ;##rev2## parallel device IRQ status
000000r 2               
000000r 2               ; Write Addresses
000000r 2               
000000r 2               PDVS    = $D1FF         ;##rev2## parallel device select
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; POKEY Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               POKEY     = $D200         ;POKEY area
000000r 2               .include  "atari_pokey.inc"
000000r 3               ;-------------------------------------------------------------------------
000000r 3               ; POKEY Address Equates
000000r 3               ;-------------------------------------------------------------------------
000000r 3               
000000r 3               ; Read Addresses
000000r 3               
000000r 3               POT0    = POKEY + $00         ;potentiometer 0
000000r 3               POT1    = POKEY + $01         ;potentiometer 1
000000r 3               POT2    = POKEY + $02         ;potentiometer 2
000000r 3               POT3    = POKEY + $03         ;potentiometer 3
000000r 3               POT4    = POKEY + $04         ;potentiometer 4
000000r 3               POT5    = POKEY + $05         ;potentiometer 5
000000r 3               POT6    = POKEY + $06         ;potentiometer 6
000000r 3               POT7    = POKEY + $07         ;potentiometer 7
000000r 3               
000000r 3               ALLPOT  = POKEY + $08         ;potentiometer port status
000000r 3               KBCODE  = POKEY + $09         ;keyboard code
000000r 3               RANDOM  = POKEY + $0A         ;random number generator
000000r 3               SERIN   = POKEY + $0D         ;serial port input
000000r 3               IRQST   = POKEY + $0E         ;IRQ interrupt status
000000r 3               SKSTAT  = POKEY + $0F         ;serial port and keyboard status
000000r 3               
000000r 3               ; Write Addresses
000000r 3               
000000r 3               AUDF1   = POKEY + $00         ;channel 1 audio frequency
000000r 3               AUDC1   = POKEY + $01         ;channel 1 audio control
000000r 3               
000000r 3               AUDF2   = POKEY + $02         ;channel 2 audio frequency
000000r 3               AUDC2   = POKEY + $03         ;channel 2 audio control
000000r 3               
000000r 3               AUDF3   = POKEY + $04         ;channel 3 audio frequency
000000r 3               AUDC3   = POKEY + $05         ;channel 3 audio control
000000r 3               
000000r 3               AUDF4   = POKEY + $06         ;channel 4 audio frequency
000000r 3               AUDC4   = POKEY + $07         ;channel 4 audio control
000000r 3               
000000r 3               AUDCTL  = POKEY + $08         ;audio control
000000r 3               STIMER  = POKEY + $09         ;start timers
000000r 3               SKRES   = POKEY + $0A         ;reset SKSTAT status
000000r 3               POTGO   = POKEY + $0B         ;start potentiometer scan sequence
000000r 3               SEROUT  = POKEY + $0D         ;serial port output
000000r 3               IRQEN   = POKEY + $0E         ;IRQ interrupt enable
000000r 3               SKCTL   = POKEY + $0F         ;serial port and keyboard control
000000r 3               
000000r 2               
000000r 2               ; POKEY KBCODE Values
000000r 2               
000000r 2               KEY_NONE    = $FF
000000r 2               
000000r 2               KEY_0       = $32
000000r 2               KEY_1       = $1F
000000r 2               KEY_2       = $1E
000000r 2               KEY_3       = $1A
000000r 2               KEY_4       = $18
000000r 2               KEY_5       = $1D
000000r 2               KEY_6       = $1B
000000r 2               KEY_7       = $33
000000r 2               KEY_8       = $35
000000r 2               KEY_9       = $30
000000r 2               
000000r 2               KEY_A       = $3F
000000r 2               KEY_B       = $15
000000r 2               KEY_C       = $12
000000r 2               KEY_D       = $3A
000000r 2               KEY_E       = $2A
000000r 2               KEY_F       = $38
000000r 2               KEY_G       = $3D
000000r 2               KEY_H       = $39
000000r 2               KEY_I       = $0D
000000r 2               KEY_J       = $01
000000r 2               KEY_K       = $05
000000r 2               KEY_L       = $00
000000r 2               KEY_M       = $25
000000r 2               KEY_N       = $23
000000r 2               KEY_O       = $08
000000r 2               KEY_P       = $0A
000000r 2               KEY_Q       = $2F
000000r 2               KEY_R       = $28
000000r 2               KEY_S       = $3E
000000r 2               KEY_T       = $2D
000000r 2               KEY_U       = $0B
000000r 2               KEY_V       = $10
000000r 2               KEY_W       = $2E
000000r 2               KEY_X       = $16
000000r 2               KEY_Y       = $2B
000000r 2               KEY_Z       = $17
000000r 2               
000000r 2               KEY_COMMA       = $20
000000r 2               KEY_PERIOD      = $22
000000r 2               KEY_SLASH       = $26
000000r 2               KEY_SEMICOLON   = $02
000000r 2               KEY_PLUS        = $06
000000r 2               KEY_ASTERISK    = $07
000000r 2               KEY_DASH        = $0E
000000r 2               KEY_EQUALS      = $0F
000000r 2               KEY_LESSTHAN    = $36
000000r 2               KEY_GREATERTHAN = $37
000000r 2               
000000r 2               KEY_ESC     = $1C
000000r 2               KEY_TAB     = $2C
000000r 2               KEY_SPACE   = $21
000000r 2               KEY_RETURN  = $0C
000000r 2               KEY_DELETE  = $34
000000r 2               KEY_CAPS    = $3C
000000r 2               KEY_INVERSE = $27
000000r 2               KEY_HELP    = $11
000000r 2               
000000r 2               KEY_F1      = $03
000000r 2               KEY_F2      = $04
000000r 2               KEY_F3      = $13
000000r 2               KEY_F4      = $14
000000r 2               
000000r 2               KEY_SHIFT   = $40
000000r 2               KEY_CTRL    = $80
000000r 2               
000000r 2               ; Composed keys
000000r 2               
000000r 2               KEY_EXCLAMATIONMARK = KEY_1 | KEY_SHIFT
000000r 2               KEY_QUOTE           = KEY_2 | KEY_SHIFT
000000r 2               KEY_HASH            = KEY_3 | KEY_SHIFT
000000r 2               KEY_DOLLAR          = KEY_4 | KEY_SHIFT
000000r 2               KEY_PERCENT         = KEY_5 | KEY_SHIFT
000000r 2               KEY_AMPERSAND       = KEY_6 | KEY_SHIFT
000000r 2               KEY_APOSTROPHE      = KEY_7 | KEY_SHIFT
000000r 2               KEY_AT              = KEY_8 | KEY_SHIFT
000000r 2               KEY_OPENINGPARAN    = KEY_9 | KEY_SHIFT
000000r 2               KEY_CLOSINGPARAN    = KEY_0 | KEY_SHIFT
000000r 2               KEY_UNDERLINE       = KEY_DASH | KEY_SHIFT
000000r 2               KEY_BAR             = KEY_EQUALS | KEY_SHIFT
000000r 2               KEY_COLON           = KEY_SEMICOLON | KEY_SHIFT
000000r 2               KEY_BACKSLASH       = KEY_PLUS | KEY_SHIFT
000000r 2               KEY_CIRCUMFLEX      = KEY_ASTERISK | KEY_SHIFT
000000r 2               KEY_OPENINGBRACKET  = KEY_COMMA | KEY_SHIFT
000000r 2               KEY_CLOSINGBRACKET  = KEY_PERIOD | KEY_SHIFT
000000r 2               KEY_QUESTIONMARK    = KEY_SLASH | KEY_SHIFT
000000r 2               KEY_CLEAR           = KEY_LESSTHAN | KEY_SHIFT
000000r 2               KEY_INSERT          = KEY_GREATERTHAN | KEY_SHIFT
000000r 2               
000000r 2               KEY_UP              = KEY_UNDERLINE | KEY_CTRL
000000r 2               KEY_DOWN            = KEY_EQUALS | KEY_CTRL
000000r 2               KEY_LEFT            = KEY_PLUS | KEY_CTRL
000000r 2               KEY_RIGHT           = KEY_ASTERISK | KEY_CTRL
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; ANTIC Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               ANTIC     = $D400         ;ANTIC area
000000r 2               .include  "atari_antic.inc"
000000r 3               ;-------------------------------------------------------------------------
000000r 3               ; ANTIC Address Equates
000000r 3               ;-------------------------------------------------------------------------
000000r 3               
000000r 3               ; Read Addresses
000000r 3               
000000r 3               VCOUNT  = ANTIC + $0B         ;vertical line counter
000000r 3               PENH    = ANTIC + $0C         ;light pen horizontal position
000000r 3               PENV    = ANTIC + $0D         ;light pen vertical position
000000r 3               NMIST   = ANTIC + $0F         ;NMI interrupt status
000000r 3               
000000r 3               ; Write Addresses
000000r 3               
000000r 3               DMACTL  = ANTIC + $00         ;DMA control
000000r 3               CHACTL  = ANTIC + $01         ;character control
000000r 3               DLISTL  = ANTIC + $02         ;low display list address
000000r 3               DLISTH  = ANTIC + $03         ;high display list address
000000r 3               HSCROL  = ANTIC + $04         ;horizontal scroll
000000r 3               VSCROL  = ANTIC + $05         ;vertical scroll
000000r 3               PMBASE  = ANTIC + $07         ;player-missile base address
000000r 3               CHBASE  = ANTIC + $09         ;character base address
000000r 3               WSYNC   = ANTIC + $0A         ;wait for HBLANK synchronization
000000r 3               NMIEN   = ANTIC + $0E         ;NMI enable
000000r 3               NMIRES  = ANTIC + $0F         ;NMI interrupt reset
000000r 3               
000000r 3               
000000r 3               ;-------------------------------------------------------------------------
000000r 3               ; Antic opcodes
000000r 3               ;-------------------------------------------------------------------------
000000r 3               
000000r 3               ; usage example:
000000r 3               ;
000000r 3               ; ScreenDL:
000000r 3               ; .byte DL_BLK8
000000r 3               ; .byte DL_BLK8
000000r 3               ; .byte DL_CHR40x8x1 | DL_LMS | DL_DLI
000000r 3               ; .word ScreenAlignment
000000r 3               ; .byte DL_BLK1 | DL_DLI
000000r 3               ; .byte DL_MAP320x1x1 | DL_LMS
000000r 3               ; .word Screen
000000r 3               ;
000000r 3               ; .repeat 99
000000r 3               ; .byte DL_MAP320x1x1
000000r 3               ; .endrepeat
000000r 3               ; .byte DL_MAP320x1x1 | DL_LMS
000000r 3               ; .word Screen + 40 * 100       ; 100 lines a 40 byte, 'Screen' has to be aligned correctly!
000000r 3               ; .repeat 92
000000r 3               ; .byte DL_MAP320x1x1
000000r 3               ; .endrepeat
000000r 3               ;
000000r 3               ; .byte DL_JVB
000000r 3               
000000r 3               ; absolute instructions (non mode lines)
000000r 3               
000000r 3               DL_JMP  = 1
000000r 3               DL_JVB  = 65
000000r 3               
000000r 3               ; DL_BLKn display n empty lines (just background)
000000r 3               
000000r 3               DL_BLK1  = 0
000000r 3               DL_BLK2  = 16
000000r 3               DL_BLK3  = 32
000000r 3               DL_BLK4  = 48
000000r 3               DL_BLK5  = 64
000000r 3               DL_BLK6  = 80
000000r 3               DL_BLK7  = 96
000000r 3               DL_BLK8  = 112
000000r 3               
000000r 3               ; absolute instructions (mode lines)
000000r 3               
000000r 3               DL_CHR40x8x1  = 2               ; monochrome, 40 character & 8 scanlines per mode line (GR. 0)
000000r 3               DL_CHR40x10x1 = 3               ; monochrome, 40 character & 10 scanlines per mode line
000000r 3               DL_CHR40x8x4  = 4               ; colour, 40 character & 8 scanlines per mode line (GR. 12)
000000r 3               DL_CHR40x16x4 = 5               ; colour, 40 character & 16 scanlines per mode line (GR. 13)
000000r 3               DL_CHR20x8x2  = 6               ; colour (duochrome per character), 20 character & 8 scanlines per mode line (GR. 1)
000000r 3               DL_CHR20x16x2 = 7               ; colour (duochrome per character), 20 character & 16 scanlines per mode line (GR. 2)
000000r 3               
000000r 3               DL_MAP40x8x4  = 8               ; colour, 40 pixel & 8 scanlines per mode line (GR. 3)
000000r 3               DL_MAP80x4x2  = 9               ; 'duochrome', 80 pixel & 4 scanlines per mode line (GR.4)
000000r 3               DL_MAP80x4x4  = 10              ; colour, 80 pixel & 4 scanlines per mode line (GR.5)
000000r 3               DL_MAP160x2x2 = 11              ; 'duochrome', 160 pixel & 2 scanlines per mode line (GR.6)
000000r 3               DL_MAP160x1x2 = 12              ; 'duochrome', 160 pixel & 1 scanline per mode line (GR.14)
000000r 3               DL_MAP160x2x4 = 13              ; 4 colours, 160 pixel & 2 scanlines per mode line (GR.7)
000000r 3               DL_MAP160x1x4 = 14              ; 4 colours, 160 pixel & 1 scanline per mode line (GR.15)
000000r 3               DL_MAP320x1x1 = 15              ; monochrome, 320 pixel & 1 scanline per mode line (GR.8)
000000r 3               
000000r 3               ; modifiers on mode lines...
000000r 3               
000000r 3               DL_HSCROL = 16
000000r 3               DL_VSCROL = 32
000000r 3               DL_LMS    = 64
000000r 3               
000000r 3               ; general modifier...
000000r 3               
000000r 3               DL_DLI    = 128
000000r 3               
000000r 2               
000000r 2               ; PBI RAM Address Equates
000000r 2               
000000r 2               PBIRAM  = $D600         ;##rev2## parallel bus interface RAM area
000000r 2               
000000r 2               ; Parallel Device Address Equates
000000r 2               
000000r 2               PDID1   = $D803         ;##rev2## parallel device ID 1
000000r 2               PDIDV   = $D805         ;##rev2## parallel device I/O vector
000000r 2               PDIRQV  = $D808         ;##rev2## parallel device IRQ vector
000000r 2               PDID2   = $D80B         ;##rev2## parallel device ID 2
000000r 2               PDVV    = $D80D         ;##rev2## parallel device vector table
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; PIA Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               PIA     = $D300         ;PIA area
000000r 2               
000000r 2               PORTA   = $D300         ;port A direction register or jacks one/two
000000r 2               PORTB   = $D301         ;port B direction register or memory management
000000r 2               
000000r 2               PACTL   = $D302         ;port A control
000000r 2               PBCTL   = $D303         ;port B control
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Floating Point Package Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               AFP     = $D800         ;convert ASCII to floating point
000000r 2               FASC    = $D8E6         ;convert floating point to ASCII
000000r 2               IFP     = $D9AA         ;convert integer to floating point
000000r 2               FPI     = $D9D2         ;convert floating point to integer
000000r 2               ZFR0    = $DA44         ;zero FR0
000000r 2               ZF1     = $DA46         ;zero floating point number
000000r 2               FSUB    = $DA60         ;subtract floating point numbers
000000r 2               FADD    = $DA66         ;add floating point numbers
000000r 2               FMUL    = $DADB         ;multiply floating point numbers
000000r 2               FDIV    = $DB28         ;divide floating point numbers
000000r 2               PLYEVL  = $DD40         ;evaluate floating point polynomial
000000r 2               FLD0R   = $DD89         ;load floating point number
000000r 2               FLD0P   = $DD8D         ;load floating point number
000000r 2               FLD1R   = $DD98         ;load floating point number
000000r 2               PLD1P   = $DD9C         ;load floating point number
000000r 2               FST0R   = $DDA7         ;store floating point number
000000r 2               FST0P   = $DDAB         ;store floating point number
000000r 2               FMOVE   = $DDB6         ;move floating point number
000000r 2               LOG     = $DECD         ;calculate floating point logarithm
000000r 2               LOG10   = $DED1         ;calculate floating point base 10 logarithm
000000r 2               EXP     = $DDC0         ;calculate floating point exponential
000000r 2               EXP10   = $DDCC         ;calculate floating point base 10 exponential
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Device Handler Vector Table Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               EDITRV  = $E400         ;editor handler vector table
000000r 2               SCRENV  = $E410         ;screen handler vector table
000000r 2               KEYBDV  = $E420         ;keyboard handler vector table
000000r 2               PRINTV  = $E430         ;printer handler vector table
000000r 2               CASETV  = $E440         ;cassette handler vector table
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Jump Vector Address Equates
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               DISKIV  = $E450         ;vector to initialize DIO
000000r 2               DSKINV  = $E453         ;vector to DIO
000000r 2               .ifdef __ATARIXL__
000000r 2               .ifndef SHRAM_HANDLERS
000000r 2               .import CIO_handler, SIO_handler, SETVBV_handler
000000r 2               .endif
000000r 2               .define CIOV    CIO_handler
000000r 2               .define SIOV    SIO_handler
000000r 2               .define SETVBV  SETVBV_handler
000000r 2               CIOV_org    = $E456     ;vector to CIO
000000r 2               SIOV_org    = $E459     ;vector to SIO
000000r 2               SETVBV_org  = $E45C     ;vector to set VBLANK parameters
000000r 2               .else
000000r 2               CIOV    = $E456         ;vector to CIO
000000r 2               SIOV    = $E459         ;vector to SIO
000000r 2               SETVBV  = $E45C         ;vector to set VBLANK parameters
000000r 2               ; aliases in order not to have to sprinkle common code with .ifdefs
000000r 2               CIOV_org    = CIOV
000000r 2               SIOV_org    = SIOV
000000r 2               SETVBV_org  = SETVBV
000000r 2               .endif
000000r 2               SYSVBV  = $E45F         ;vector to process immediate VBLANK
000000r 2               XITVBV  = $E462         ;vector to process deferred VBLANK
000000r 2               SIOINV  = $E465         ;vector to initialize SIO
000000r 2               SENDEV  = $E468         ;vector to enable SEND
000000r 2               INTINV  = $E46B         ;vector to initialize interrupt handler
000000r 2               CIOINV  = $E46E         ;vector to initialize CIO
000000r 2               BLKBDV  = $E471         ;vector to power-up display
000000r 2               WARMSV  = $E474         ;vector to warmstart
000000r 2               COLDSV  = $E477         ;vector to coldstart
000000r 2               RBLOKV  = $E47A         ;vector to read cassette block
000000r 2               CSOPIV  = $E47D         ;vector to open cassette for input
000000r 2               VCTABL  = $E480         ;RAM vector initial value table
000000r 2               PUPDIV  = $E480         ;##rev2## vector to power-up display
000000r 2               SLFTSV  = $E483         ;##rev2## vector to self-test
000000r 2               PHENTV  = $E486         ;##rev2## vector to enter peripheral handler
000000r 2               PHUNLV  = $E489         ;##rev2## vector to unlink peripheral handler
000000r 2               PHINIV  = $E48C         ;##rev2## vector to initialize peripheral handler
000000r 2               GPDVV   = $E48F         ;##rev2## generic parallel device handler vector
000000r 2               
000000r 2               ; NOTE: OS rom self-test labels are not included in this file
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; Some misc. stuff from the 400/800 rev.B source
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               ; THE FOLLOWING ARE IN BASIC CARTRIDGE:
000000r 2               SIN     = $BD81         ;FR0 <- SIN (FR0) DEGFLG (0=RAD,6=DEG) CARRY
000000r 2               COS     = $BD73         ;FR0 <- COS (FR0) CARRY
000000r 2               ATAN    = $BE43         ;FR0 <- ATAN(FR0) CARRY
000000r 2               SQR     = $BEB1         ;FR0 <- ROOT(FR0) CARRY
000000r 2               
000000r 2               RADON   = 0             ;INDICATES RADIANS
000000r 2               DEGON   = 6             ;INDICATES DEGREES
000000r 2               
000000r 2               ASCZER  = '0'           ;ASCII ZERO
000000r 2               COLON   = $3A           ;ASCII COLON
000000r 2               CR      = $9B           ;SYSTEM EOL (CARRIAGE RETURN)
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; 6502
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               NMIVEC  = $FFFA
000000r 2               RESVEC  = $FFFC
000000r 2               IRQVEC  = $FFFE
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; BASIC
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               LOMEM   = $80           ;2-byte low memory pointer
000000r 2               VNTP    = $82           ;2-byte variable name table address
000000r 2               VNTD    = $84           ;2-byte variable name table end + 1
000000r 2               VVTP    = $86           ;2-byte variable value table
000000r 2               STMTAB  = $88           ;2-byte statement table address
000000r 2               STMCUR  = $8A           ;2-byte current statement pointer
000000r 2               STARP   = $8C           ;2-byte string and array table pointer
000000r 2               RUNSTK  = $8E           ;2-byte runtime stack address
000000r 2               BMEMTOP = $90           ;2-byte top of memory pointer
000000r 2               STOPLN  = $BA           ;2-byte stopped line number
000000r 2               ERRSAVE = $C3           ;1-byte error code
000000r 2               PTABW   = $C9           ;1-byte tab width
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; ATASCII CHARACTER DEFS
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               ATCLR   = $7D           ;CLEAR SCREEN CHARACTER
000000r 2               ATRUB   = $7E           ;BACK SPACE (RUBOUT)
000000r 2               ATTAB   = $7F           ;TAB
000000r 2               ATEOL   = $9B           ;END-OF-LINE
000000r 2               ATDELL  = $9C           ;delete line
000000r 2               ATINSL  = $9D           ;insert line
000000r 2               ATCTAB  = $9E           ;clear TAB
000000r 2               ATSTAB  = $9F           ;set TAB
000000r 2               ATBEL   = $FD           ;CONSOLE BELL
000000r 2               ATDEL   = $FE           ;delete char.
000000r 2               ATINS   = $FF           ;insert char.
000000r 2               ATURW   = $1C           ;UP-ARROW
000000r 2               ATDRW   = $1D           ;DOWN-ARROW
000000r 2               ATLRW   = $1E           ;LEFT-ARROW
000000r 2               ATRRW   = $1F           ;RIGHT-ARROW
000000r 2               ATESC   = $1B           ;ESCAPE
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; OFFSETS INTO SECTSIZETAB (DIO functions)
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               sst_flag     = 0        ; length 1
000000r 2               sst_sectsize = 1        ;        2
000000r 2               sst_driveno  = 3        ;        1  (drive #)
000000r 2               sst_size     = 4        ; size of one entry
000000r 2                                       ; if changed, adapt diopncls.s
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; OFFSETS INTO dio_phys_pos
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               diopp_head   = 0        ; head
000000r 2               diopp_track  = 1        ; track / cylinder
000000r 2               diopp_sector = 3        ; sector
000000r 2               diopp_size   = 5        ; size of structure
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; VALUES for dos_type
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               SPARTADOS    = 0
000000r 2               REALDOS      = 1
000000r 2               BWDOS        = 2
000000r 2               OSADOS       = 3        ; OS/A+
000000r 2               XDOS         = 4
000000r 2               ATARIDOS     = 5
000000r 2               MYDOS        = 6
000000r 2               NODOS        = 255
000000r 2               ; The DOSes with dos_type below or equal MAX_DOS_WITH_CMDLINE do support
000000r 2               ; command line arguments.
000000r 2               MAX_DOS_WITH_CMDLINE = XDOS
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; XDOS defines (version 2.4, taken from xdos24.pdf)
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 2               XOPT         = $070B    ; XDOS options
000000r 2               XCAR         = $070C    ; XDOS cartridge address (+ $70D)
000000r 2               XPAT         = $086F    ; XDOS bugfix and patch number
000000r 2               XVER         = $0870    ; XDOS version number
000000r 2               XFILE        = $087D    ; XDOS filename buffer
000000r 2               XLINE        = $0880    ; XDOS DUP input line
000000r 2               XGLIN        = $0871    ; get line
000000r 2               XSKIP        = $0874    ; skip parameter
000000r 2               .ifdef __ATARIXL__
000000r 2               .ifndef SHRAM_HANDLERS
000000r 2               .import XMOVE_handler
000000r 2               .endif
000000r 2               .define XMOVE XMOVE_handler
000000r 2               XMOVE_org    = $0877    ; move filename
000000r 2               .else
000000r 2               XMOVE        = $0877    ; move filename
000000r 2               .endif
000000r 2               XGNUM        = $087A    ; get number
000000r 2               
000000r 2               ;-------------------------------------------------------------------------
000000r 2               ; End of atari.inc
000000r 2               ;-------------------------------------------------------------------------
000000r 2               
000000r 1               
000000r 1               .CODE
000000r 1               
000000r 1               
000000r 1               .proc main
000000r 1  A9 00                lda #0                  ; kod barvy
000002r 1  8D C4 02             sta COLOR0              ; ulozit do registru COLOR2
000005r 1               
000005r 1  A9 0A                lda #10                 ; kod barvy
000007r 1  8D C8 02             sta COLOR4              ; ulozit do registru COLOR4
00000Ar 1               
00000Ar 1  A9 rr                lda #<dlist             ; nižší byte adresy display listu
00000Cr 1  8D 30 02             sta SDLSTL
00000Fr 1  A9 rr                lda #>dlist             ; vyšší byte adresy display listu
000011r 1  8D 31 02             sta SDLSTH
000014r 1               
000014r 1  4C rr rr     loop:   jmp loop
000017r 1               .endproc
000017r 1               
000017r 1               dlist:
000017r 1  70 70 70     .byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
00001Ar 1  4C           .byte DL_LMS+DL_MAP160x1x2      ; určení počáteční adresy obrazové paměti + jeden řádek režimu C (GR.14)
00001Br 1  rr rr        .byte <screen, >screen          ; počáteční adresa obrazové paměti
00001Dr 1  0C 0C 0C 0C  .res 191, DL_MAP160x1x2          ; opakovat řádky grafického režimu C (GR.14)
000021r 1  0C 0C 0C 0C  
000025r 1  0C 0C 0C 0C  
000029r 1  0C 0C 0C 0C  
00002Dr 1  0C 0C 0C 0C  
000031r 1  0C 0C 0C 0C  
000035r 1  0C 0C 0C 0C  
000039r 1  0C 0C 0C 0C  
00003Dr 1  0C 0C 0C 0C  
000041r 1  0C 0C 0C 0C  
000045r 1  0C 0C 0C 0C  
000049r 1  0C 0C 0C 0C  
00004Dr 1  0C 0C 0C 0C  
000051r 1  0C 0C 0C 0C  
000055r 1  0C 0C 0C 0C  
000059r 1  0C 0C 0C 0C  
00005Dr 1  0C 0C 0C 0C  
000061r 1  0C 0C 0C 0C  
000065r 1  0C 0C 0C 0C  
000069r 1  0C 0C 0C 0C  
00006Dr 1  0C 0C 0C 0C  
000071r 1  0C 0C 0C 0C  
000075r 1  0C 0C 0C 0C  
000079r 1  0C 0C 0C 0C  
00007Dr 1  0C 0C 0C 0C  
0000DCr 1  41 rr rr     .byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu
0000DFr 1               
0000DFr 1               screen:
0000DFr 1               .include "image_160x192.asm"
0000DFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
0000E3r 2  FF FF FF FF  
0000E7r 2  FF FF FF FF  
0000EBr 2  FF FF FF FF  
0000EFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
0000F3r 2  FF FF FF FF  
0000F7r 2  FF FF FF FF  
0000FBr 2  FF FF FF FF  
0000FFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $f0, $00, $00, $00, $00, $00
000103r 2  FF FF FF FF  
000107r 2  FF FF F0 00  
00010Br 2  00 00 00 00  
00010Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $ff, $f8, $00
000113r 2  00 00 00 00  
000117r 2  00 FF FF FF  
00011Br 2  FF FF F8 00  
00011Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $ff, $ff, $ff
000123r 2  00 00 00 00  
000127r 2  00 00 00 00  
00012Br 2  01 FF FF FF  
00012Fr 2  FF FF E4 00  .byte $ff, $ff, $e4, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
000133r 2  00 00 00 00  
000137r 2  00 00 00 00  
00013Br 2  00 00 00 00  
00013Fr 2  03 FF FF FF  .byte $03, $ff, $ff, $ff, $ff, $ff, $da, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000143r 2  FF FF DA FF  
000147r 2  FF FF FF FF  
00014Br 2  FF FF FF FF  
00014Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $fb, $ff, $ff, $ff, $ff, $ff, $a0, $00, $00, $00, $00, $00
000153r 2  FB FF FF FF  
000157r 2  FF FF A0 00  
00015Br 2  00 00 00 00  
00015Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $07, $7f, $ff, $ff, $ff, $ff, $c1, $00
000163r 2  00 00 00 00  
000167r 2  07 7F FF FF  
00016Br 2  FF FF C1 00  
00016Fr 2  03 0C 00 00  .byte $03, $0c, $00, $00, $00, $00, $00, $00, $00, $03, $0c, $00, $06, $bf, $ff, $ff
000173r 2  00 00 00 00  
000177r 2  00 03 0C 00  
00017Br 2  06 BF FF FF  
00017Fr 2  FF FF 40 00  .byte $ff, $ff, $40, $00, $00, $82, $00, $00, $00, $00, $00, $00, $00, $00, $82, $00
000183r 2  00 82 00 00  
000187r 2  00 00 00 00  
00018Br 2  00 00 82 00  
00018Fr 2  0F BF FF FF  .byte $0f, $bf, $ff, $ff, $ff, $ff, $20, $00, $04, $70, $00, $00, $00, $00, $00, $00
000193r 2  FF FF 20 00  
000197r 2  04 70 00 00  
00019Br 2  00 00 00 00  
00019Fr 2  00 04 70 00  .byte $00, $04, $70, $00, $0a, $ff, $ff, $ff, $ff, $ff, $00, $80, $04, $80, $0b, $7f
0001A3r 2  0A FF FF FF  
0001A7r 2  FF FF 00 80  
0001ABr 2  04 80 0B 7F  
0001AFr 2  D9 FE FF 5B  .byte $d9, $fe, $ff, $5b, $dc, $04, $80, $00, $0b, $ff, $ff, $ff, $ff, $ff, $90, $80
0001B3r 2  DC 04 80 00  
0001B7r 2  0B FF FF FF  
0001BBr 2  FF FF 90 80  
0001BFr 2  44 81 16 80  .byte $44, $81, $16, $80, $28, $01, $00, $b4, $22, $24, $81, $20, $0a, $6f, $ff, $ff
0001C3r 2  28 01 00 B4  
0001C7r 2  22 24 81 20  
0001CBr 2  0A 6F FF FF  
0001CFr 2  FF FF 80 00  .byte $ff, $ff, $80, $00, $28, $72, $92, $92, $28, $13, $02, $94, $a6, $08, $72, $c0
0001D3r 2  28 72 92 92  
0001D7r 2  28 13 02 94  
0001DBr 2  A6 08 72 C0  
0001DFr 2  19 FF FF FF  .byte $19, $ff, $ff, $ff, $ff, $ff, $88, $00, $12, $81, $12, $93, $00, $73, $02, $94
0001E3r 2  FF FF 88 00  
0001E7r 2  12 81 12 93  
0001EBr 2  00 73 02 94  
0001EFr 2  E2 12 81 00  .byte $e2, $12, $81, $00, $10, $0b, $ff, $ff, $ff, $fe, $00, $00, $27, $6e, $10, $93
0001F3r 2  10 0B FF FF  
0001F7r 2  FF FE 00 00  
0001FBr 2  27 6E 10 93  
0001FFr 2  00 13 00 84  .byte $00, $13, $00, $84, $26, $27, $6e, $00, $11, $9b, $ff, $ff, $ff, $fe, $04, $00
000203r 2  26 27 6E 00  
000207r 2  11 9B FF FF  
00020Br 2  FF FE 04 00  
00020Fr 2  09 98 94 93  .byte $09, $98, $94, $93, $29, $93, $12, $a4, $a6, $09, $98, $c0, $10, $9b, $ff, $ff
000213r 2  29 93 12 A4  
000217r 2  A6 09 98 C0  
00021Br 2  10 9B FF FF  
00021Fr 2  FF FE 80 40  .byte $ff, $fe, $80, $40, $14, $11, $94, $92, $28, $13, $02, $a4, $a0, $34, $11, $80
000223r 2  14 11 94 92  
000227r 2  28 13 02 A4  
00022Br 2  A0 34 11 80  
00022Fr 2  10 6B FF FF  .byte $10, $6b, $ff, $ff, $ff, $fe, $82, $40, $02, $16, $16, $80, $28, $13, $02, $b4
000233r 2  FF FE 82 40  
000237r 2  02 16 16 80  
00023Br 2  28 13 02 B4  
00023Fr 2  20 02 16 40  .byte $20, $02, $16, $40, $10, $03, $ff, $ff, $ff, $fe, $00, $40, $01, $88, $0d, $7f
000243r 2  10 03 FF FF  
000247r 2  FF FE 00 40  
00024Br 2  01 88 0D 7F  
00024Fr 2  D9 EC FF 6B  .byte $d9, $ec, $ff, $6b, $de, $01, $88, $00, $10, $13, $ff, $ff, $ff, $fe, $41, $40
000253r 2  DE 01 88 00  
000257r 2  10 13 FF FF  
00025Br 2  FF FE 41 40  
00025Fr 2  00 80 00 00  .byte $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $10, $03, $ff, $ff
000263r 2  00 00 00 00  
000267r 2  00 00 80 00  
00026Br 2  10 03 FF FF  
00026Fr 2  FF FE A0 40  .byte $ff, $fe, $a0, $40, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $10, $00
000273r 2  00 10 00 00  
000277r 2  00 00 00 00  
00027Br 2  00 00 10 00  
00027Fr 2  10 2B FF FF  .byte $10, $2b, $ff, $ff, $ff, $fe, $90, $c0, $00, $60, $00, $00, $00, $00, $00, $00
000283r 2  FF FE 90 C0  
000287r 2  00 60 00 00  
00028Br 2  00 00 00 00  
00028Fr 2  00 00 60 00  .byte $00, $00, $60, $00, $10, $cb, $ff, $ff, $ff, $fe, $8c, $00, $00, $00, $00, $00
000293r 2  10 CB FF FF  
000297r 2  FF FE 8C 00  
00029Br 2  00 00 00 00  
00029Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $11, $0b, $ff, $ff, $ff, $fe, $83, $ff
0002A3r 2  00 00 00 00  
0002A7r 2  11 0B FF FF  
0002ABr 2  FF FE 83 FF  
0002AFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ee, $0b, $ff, $ff
0002B3r 2  FF FF FF FF  
0002B7r 2  FF FF FF FF  
0002BBr 2  EE 0B FF FF  
0002BFr 2  FF FE 80 5F  .byte $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
0002C3r 2  FF FF FF FF  
0002C7r 2  FF FF FF FF  
0002CBr 2  FF FF FF FF  
0002CFr 2  C0 0B FF FF  .byte $c0, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
0002D3r 2  FF FE 80 5F  
0002D7r 2  FF FF FF FF  
0002DBr 2  FF FF FF FF  
0002DFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $c0, $0b, $ff, $ff, $ff, $fe, $80, $40, $00, $00, $00, $00
0002E3r 2  C0 0B FF FF  
0002E7r 2  FF FE 80 40  
0002EBr 2  00 00 00 00  
0002EFr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $0b, $ff, $ff, $ff, $fe, $80, $5f
0002F3r 2  00 00 00 00  
0002F7r 2  00 0B FF FF  
0002FBr 2  FF FE 80 5F  
0002FFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff
000303r 2  FF FF FF FF  
000307r 2  FF FF FF FF  
00030Br 2  80 0B FF FF  
00030Fr 2  FF FE 80 5F  .byte $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000313r 2  FF FF FF FF  
000317r 2  FF FF FF FF  
00031Br 2  FF FF FF FF  
00031Fr 2  80 0B FF FF  .byte $80, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000323r 2  FF FE 80 5F  
000327r 2  FF FF FF FF  
00032Br 2  FF FF FF FF  
00032Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff
000333r 2  80 0B FF FF  
000337r 2  FF FE 80 5F  
00033Br 2  FF FF FF FF  
00033Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $80, $5f
000343r 2  FF FF FF FF  
000347r 2  80 0B FF FF  
00034Br 2  FF FE 80 5F  
00034Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff
000353r 2  FF FF FF FF  
000357r 2  FF FF FF FF  
00035Br 2  80 0B FF FF  
00035Fr 2  FF FE 80 5F  .byte $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000363r 2  FF FF FF FF  
000367r 2  FF FF FF FF  
00036Br 2  FF FF FF FF  
00036Fr 2  80 0B FF FF  .byte $80, $0b, $ff, $ff, $ff, $fe, $94, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $ff
000373r 2  FF FE 94 5F  
000377r 2  FF FF FF FF  
00037Br 2  FF FF FE FF  
00037Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $84, $5f, $ff, $ff, $ff, $ff
000383r 2  80 0B FF FF  
000387r 2  FF FE 84 5F  
00038Br 2  FF FF FF FF  
00038Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $86, $5f
000393r 2  FF FF FF FF  
000397r 2  80 0B FF FF  
00039Br 2  FF FE 86 5F  
00039Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $fd, $ff, $ff, $ff, $ff, $ff, $82, $0b, $ff, $ff
0003A3r 2  FF FF FD FF  
0003A7r 2  FF FF FF FF  
0003ABr 2  82 0B FF FF  
0003AFr 2  FF FE 84 5F  .byte $ff, $fe, $84, $5f, $ff, $ff, $ff, $ff, $ff, $df, $fb, $ff, $ff, $ff, $ff, $ff
0003B3r 2  FF FF FF FF  
0003B7r 2  FF DF FB FF  
0003BBr 2  FF FF FF FF  
0003BFr 2  82 0B FF FF  .byte $82, $0b, $ff, $ff, $ff, $fe, $88, $5f, $ff, $ff, $ff, $ff, $ff, $d3, $f7, $ff
0003C3r 2  FF FE 88 5F  
0003C7r 2  FF FF FF FF  
0003CBr 2  FF D3 F7 FF  
0003CFr 2  DF FF FF FF  .byte $df, $ff, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $98, $5f, $ff, $ff, $ff, $ff
0003D3r 2  80 8B FF FF  
0003D7r 2  FF FE 98 5F  
0003DBr 2  FF FF FF FF  
0003DFr 2  FF AF E3 FF  .byte $ff, $af, $e3, $ff, $ff, $ff, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $b8, $5f
0003E3r 2  FF FF FF FF  
0003E7r 2  80 8B FF FF  
0003EBr 2  FF FE B8 5F  
0003EFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $1f, $c7, $ff, $f3, $ff, $ff, $df, $83, $4b, $ff, $ff
0003F3r 2  FF 1F C7 FF  
0003F7r 2  F3 FF FF DF  
0003FBr 2  83 4B FF FF  
0003FFr 2  FF FE 82 5F  .byte $ff, $fe, $82, $5f, $ff, $ff, $ff, $ff, $fd, $ff, $8f, $ff, $9f, $ff, $ff, $ff
000403r 2  FF FF FF FF  
000407r 2  FD FF 8F FF  
00040Br 2  9F FF FF FF  
00040Fr 2  81 AB FF FF  .byte $81, $ab, $ff, $ff, $ff, $fe, $ca, $5f, $ff, $ff, $ff, $ff, $ff, $fe, $3f, $ff
000413r 2  FF FE CA 5F  
000417r 2  FF FF FF FF  
00041Br 2  FF FE 3F FF  
00041Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $c2, $5f, $ff, $ff, $ff, $ff
000423r 2  81 0B FF FF  
000427r 2  FF FE C2 5F  
00042Br 2  FF FF FF FF  
00042Fr 2  FF FC 1F FF  .byte $ff, $fc, $1f, $ff, $f7, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $c4, $5f
000433r 2  F7 FF FF FF  
000437r 2  81 0B FF FF  
00043Br 2  FF FE C4 5F  
00043Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $eb, $f0, $3f, $fe, $ff, $ff, $ff, $ff, $85, $0b, $ff, $ff
000443r 2  EB F0 3F FE  
000447r 2  FF FF FF FF  
00044Br 2  85 0B FF FF  
00044Fr 2  FF FE C4 5F  .byte $ff, $fe, $c4, $5f, $ff, $ff, $ff, $f7, $ef, $e0, $6f, $cf, $ff, $ff, $ff, $ff
000453r 2  FF FF FF F7  
000457r 2  EF E0 6F CF  
00045Br 2  FF FF FF FF  
00045Fr 2  85 0B FF FF  .byte $85, $0b, $ff, $ff, $ff, $fe, $9d, $5f, $ff, $ff, $ff, $ef, $e3, $e1, $07, $8f
000463r 2  FF FE 9D 5F  
000467r 2  FF FF FF EF  
00046Br 2  E3 E1 07 8F  
00046Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $84, $6b, $ff, $ff, $ff, $fe, $a6, $5f, $fd, $ff, $ff, $2f
000473r 2  84 6B FF FF  
000477r 2  FF FE A6 5F  
00047Br 2  FD FF FF 2F  
00047Fr 2  E7 C7 03 37  .byte $e7, $c7, $03, $37, $ff, $ff, $ff, $ff, $8a, $8b, $ff, $ff, $ff, $fe, $a0, $df
000483r 2  FF FF FF FF  
000487r 2  8A 8B FF FF  
00048Br 2  FF FE A0 DF  
00048Fr 2  FE F3 FF C3  .byte $fe, $f3, $ff, $c3, $ff, $01, $b0, $f3, $ff, $ff, $ff, $bf, $81, $8b, $ff, $ff
000493r 2  FF 01 B0 F3  
000497r 2  FF FF FF BF  
00049Br 2  81 8B FF FF  
00049Fr 2  FF FE A0 DF  .byte $ff, $fe, $a0, $df, $ff, $07, $fd, $8f, $fe, $1f, $f3, $fd, $ff, $ff, $ff, $ff
0004A3r 2  FF 07 FD 8F  
0004A7r 2  FE 1F F3 FD  
0004ABr 2  FF FF FF FF  
0004AFr 2  81 8B FF FF  .byte $81, $8b, $ff, $ff, $ff, $fe, $a0, $df, $ff, $4f, $f7, $ff, $f0, $3f, $f3, $ff
0004B3r 2  FF FE A0 DF  
0004B7r 2  FF 4F F7 FF  
0004BBr 2  F0 3F F3 FF  
0004BFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $8b, $ff, $ff, $ff, $fe, $a0, $df, $ff, $37, $fb, $ff
0004C3r 2  81 8B FF FF  
0004C7r 2  FF FE A0 DF  
0004CBr 2  FF 37 FB FF  
0004CFr 2  C0 1F E3 FF  .byte $c0, $1f, $e3, $ff, $ff, $fb, $e7, $ff, $81, $8b, $ff, $ff, $ff, $fe, $a6, $5f
0004D3r 2  FF FB E7 FF  
0004D7r 2  81 8B FF FF  
0004DBr 2  FF FE A6 5F  
0004DFr 2  FE D7 E3 FF  .byte $fe, $d7, $e3, $ff, $00, $ff, $c7, $ff, $ff, $fb, $ff, $ff, $8a, $8b, $ff, $ff
0004E3r 2  00 FF C7 FF  
0004E7r 2  FF FB FF FF  
0004EBr 2  8A 8B FF FF  
0004EFr 2  FF FE 9D 5F  .byte $ff, $fe, $9d, $5f, $ff, $df, $bb, $fe, $03, $ff, $93, $ff, $ff, $fb, $bf, $ff
0004F3r 2  FF DF BB FE  
0004F7r 2  03 FF 93 FF  
0004FBr 2  FF FB BF FF  
0004FFr 2  84 6B FF FF  .byte $84, $6b, $ff, $ff, $ff, $fe, $c4, $5f, $ff, $df, $7f, $f8, $00, $ff, $18, $ff
000503r 2  FF FE C4 5F  
000507r 2  FF DF 7F F8  
00050Br 2  00 FF 18 FF  
00050Fr 2  FF 7F FF FF  .byte $ff, $7f, $ff, $ff, $85, $0b, $ff, $ff, $ff, $fe, $c4, $5f, $ff, $fe, $f7, $e0
000513r 2  85 0B FF FF  
000517r 2  FF FE C4 5F  
00051Br 2  FF FE F7 E0  
00051Fr 2  3F FF 5E 3F  .byte $3f, $ff, $5e, $3f, $ff, $ff, $fb, $ff, $85, $0b, $ff, $ff, $ff, $fe, $c2, $5f
000523r 2  FF FF FB FF  
000527r 2  85 0B FF FF  
00052Br 2  FF FE C2 5F  
00052Fr 2  FF EE EF 00  .byte $ff, $ee, $ef, $00, $07, $ff, $ff, $9f, $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff
000533r 2  07 FF FF 9F  
000537r 2  FF FF FF FF  
00053Br 2  81 0B FF FF  
00053Fr 2  FF FE CA 5F  .byte $ff, $fe, $ca, $5f, $ff, $fe, $fe, $01, $ff, $fe, $ff, $9f, $ff, $f7, $ff, $ff
000543r 2  FF FE FE 01  
000547r 2  FF FE FF 9F  
00054Br 2  FF F7 FF FF  
00054Fr 2  81 0B FF FF  .byte $81, $0b, $ff, $ff, $ff, $fe, $82, $5f, $ff, $ff, $3c, $07, $ff, $ff, $ff, $1f
000553r 2  FF FE 82 5F  
000557r 2  FF FF 3C 07  
00055Br 2  FF FF FF 1F  
00055Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $ab, $ff, $ff, $ff, $fe, $b0, $5f, $fd, $7f, $f8, $19
000563r 2  81 AB FF FF  
000567r 2  FF FE B0 5F  
00056Br 2  FD 7F F8 19  
00056Fr 2  FF FF F2 3F  .byte $ff, $ff, $f2, $3f, $ff, $7d, $ff, $ff, $82, $4b, $ff, $ff, $ff, $fe, $84, $5f
000573r 2  FF 7D FF FF  
000577r 2  82 4B FF FF  
00057Br 2  FF FE 84 5F  
00057Fr 2  FB BF F0 07  .byte $fb, $bf, $f0, $07, $ff, $ff, $c4, $ff, $ff, $7f, $ff, $ff, $82, $0b, $ff, $ff
000583r 2  FF FF C4 FF  
000587r 2  FF 7F FF FF  
00058Br 2  82 0B FF FF  
00058Fr 2  FF FE 84 5F  .byte $ff, $fe, $84, $5f, $fc, $7f, $e0, $7f, $ff, $ff, $df, $ff, $ef, $7f, $bf, $ff
000593r 2  FC 7F E0 7F  
000597r 2  FF FF DF FF  
00059Br 2  EF 7F BF FF  
00059Fr 2  82 8B FF FF  .byte $82, $8b, $ff, $ff, $ff, $fe, $88, $5f, $fe, $79, $80, $8a, $ff, $ff, $9f, $ff
0005A3r 2  FF FE 88 5F  
0005A7r 2  FE 79 80 8A  
0005ABr 2  FF FF 9F FF  
0005AFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $82, $8b, $ff, $ff, $ff, $fe, $88, $5f, $ff, $f0, $04, $75
0005B3r 2  82 8B FF FF  
0005B7r 2  FF FE 88 5F  
0005BBr 2  FF F0 04 75  
0005BFr 2  3F FF C7 FF  .byte $3f, $ff, $c7, $ff, $ff, $ff, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $83, $5f
0005C3r 2  FF FF FF FF  
0005C7r 2  80 8B FF FF  
0005CBr 2  FF FE 83 5F  
0005CFr 2  FF E0 03 F7  .byte $ff, $e0, $03, $f7, $ff, $f7, $e7, $ff, $ff, $ff, $ff, $ff, $84, $8b, $ff, $ff
0005D3r 2  FF F7 E7 FF  
0005D7r 2  FF FF FF FF  
0005DBr 2  84 8B FF FF  
0005DFr 2  FF FE 90 5F  .byte $ff, $fe, $90, $5f, $ff, $c0, $2f, $cf, $ff, $ff, $f7, $ff, $f9, $ff, $ff, $ff
0005E3r 2  FF C0 2F CF  
0005E7r 2  FF FF F7 FF  
0005EBr 2  F9 FF FF FF  
0005EFr 2  8B 0B FF FF  .byte $8b, $0b, $ff, $ff, $ff, $fe, $94, $df, $fc, $03, $cf, $bb, $ff, $ff, $f7, $ff
0005F3r 2  FF FE 94 DF  
0005F7r 2  FC 03 CF BB  
0005FBr 2  FF FF F7 FF  
0005FFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $90, $df, $f0, $1f, $6f, $ff
000603r 2  81 0B FF FF  
000607r 2  FF FE 90 DF  
00060Br 2  F0 1F 6F FF  
00060Fr 2  FF FF F3 FF  .byte $ff, $ff, $f3, $ff, $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $88, $df
000613r 2  FF FF FF FF  
000617r 2  81 0B FF FF  
00061Br 2  FF FE 88 DF  
00061Fr 2  FB E7 DF FF  .byte $fb, $e7, $df, $ff, $ff, $fd, $f3, $ff, $ff, $ff, $ff, $ff, $81, $4b, $ff, $ff
000623r 2  FF FD F3 FF  
000627r 2  FF FF FF FF  
00062Br 2  81 4B FF FF  
00062Fr 2  FF FE 88 DF  .byte $ff, $fe, $88, $df, $ff, $9f, $9f, $ff, $df, $fc, $f5, $ff, $bf, $ff, $ff, $ff
000633r 2  FF 9F 9F FF  
000637r 2  DF FC F5 FF  
00063Br 2  BF FF FF FF  
00063Fr 2  81 4B FF FF  .byte $81, $4b, $ff, $ff, $ff, $fe, $ae, $5f, $ff, $ff, $9f, $ff, $ff, $fa, $35, $ff
000643r 2  FF FE AE 5F  
000647r 2  FF FF 9F FF  
00064Br 2  FF FA 35 FF  
00064Fr 2  FF EF FF FF  .byte $ff, $ef, $ff, $ff, $8c, $4b, $ff, $ff, $ff, $fe, $99, $5f, $ff, $ff, $1f, $ff
000653r 2  8C 4B FF FF  
000657r 2  FF FE 99 5F  
00065Br 2  FF FF 1F FF  
00065Fr 2  FC 77 84 7F  .byte $fc, $77, $84, $7f, $ff, $ff, $ff, $ff, $82, $ab, $ff, $ff, $ff, $fe, $c1, $5f
000663r 2  FF FF FF FF  
000667r 2  82 AB FF FF  
00066Br 2  FF FE C1 5F  
00066Fr 2  FF FE DF FF  .byte $ff, $fe, $df, $ff, $fb, $0f, $f7, $ff, $ff, $ff, $ff, $ff, $83, $0b, $ff, $ff
000673r 2  FB 0F F7 FF  
000677r 2  FF FF FF FF  
00067Br 2  83 0B FF FF  
00067Fr 2  FF FE C1 5F  .byte $ff, $fe, $c1, $5f, $ff, $ff, $ff, $ff, $f6, $7f, $f7, $ff, $ff, $ff, $ff, $ff
000683r 2  FF FF FF FF  
000687r 2  F6 7F F7 FF  
00068Br 2  FF FF FF FF  
00068Fr 2  83 0B FF FF  .byte $83, $0b, $ff, $ff, $ff, $fe, $c1, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $f7, $fb
000693r 2  FF FE C1 5F  
000697r 2  FF FF FF FF  
00069Br 2  FF FF F7 FB  
00069Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $83, $0b, $ff, $ff, $ff, $fe, $c1, $5f, $ff, $ff, $7f, $ff
0006A3r 2  83 0B FF FF  
0006A7r 2  FF FE C1 5F  
0006ABr 2  FF FF 7F FF  
0006AFr 2  FF FF EF F1  .byte $ff, $ff, $ef, $f1, $ff, $ff, $ff, $ff, $83, $0b, $ff, $ff, $ff, $fe, $99, $5f
0006B3r 2  FF FF FF FF  
0006B7r 2  83 0B FF FF  
0006BBr 2  FF FE 99 5F  
0006BFr 2  FF FF 7F FF  .byte $ff, $ff, $7f, $ff, $ff, $ff, $ef, $e1, $ff, $ff, $ff, $ff, $82, $ab, $ff, $ff
0006C3r 2  FF FF EF E1  
0006C7r 2  FF FF FF FF  
0006CBr 2  82 AB FF FF  
0006CFr 2  FF FE AE 5F  .byte $ff, $fe, $ae, $5f, $ff, $ff, $7f, $ff, $ff, $ff, $ef, $c5, $ff, $ff, $ff, $7f
0006D3r 2  FF FF 7F FF  
0006D7r 2  FF FF EF C5  
0006DBr 2  FF FF FF 7F  
0006DFr 2  8C 4B FF FF  .byte $8c, $4b, $ff, $ff, $ff, $fe, $88, $df, $ff, $fe, $7f, $ff, $ff, $ff, $e7, $8d
0006E3r 2  FF FE 88 DF  
0006E7r 2  FF FE 7F FF  
0006EBr 2  FF FF E7 8D  
0006EFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $4b, $ff, $ff, $ff, $fe, $88, $df, $ff, $c2, $c0, $00
0006F3r 2  81 4B FF FF  
0006F7r 2  FF FE 88 DF  
0006FBr 2  FF C2 C0 00  
0006FFr 2  00 00 14 1C  .byte $00, $00, $14, $1c, $00, $7f, $ff, $ff, $81, $4b, $ff, $ff, $ff, $fe, $90, $df
000703r 2  00 7F FF FF  
000707r 2  81 4B FF FF  
00070Br 2  FF FE 90 DF  
00070Fr 2  FF C3 A0 00  .byte $ff, $c3, $a0, $00, $00, $00, $12, $3c, $00, $3f, $ff, $ff, $81, $0b, $ff, $ff
000713r 2  00 00 12 3C  
000717r 2  00 3F FF FF  
00071Br 2  81 0B FF FF  
00071Fr 2  FF FE 94 DF  .byte $ff, $fe, $94, $df, $ff, $c3, $c0, $00, $00, $00, $3c, $7c, $00, $3f, $ff, $ff
000723r 2  FF C3 C0 00  
000727r 2  00 00 3C 7C  
00072Br 2  00 3F FF FF  
00072Fr 2  81 0B FF FF  .byte $81, $0b, $ff, $ff, $ff, $fe, $90, $5f, $ff, $9f, $7f, $ff, $ff, $fd, $8f, $fd
000733r 2  FF FE 90 5F  
000737r 2  FF 9F 7F FF  
00073Br 2  FF FD 8F FD  
00073Fr 2  FD BF FF FF  .byte $fd, $bf, $ff, $ff, $8b, $0b, $ff, $ff, $ff, $fe, $87, $5f, $ff, $9f, $7f, $ff
000743r 2  8B 0B FF FF  
000747r 2  FF FE 87 5F  
00074Br 2  FF 9F 7F FF  
00074Fr 2  FF FD C7 FD  .byte $ff, $fd, $c7, $fd, $fd, $bf, $ff, $ff, $85, $8b, $ff, $ff, $ff, $fe, $86, $5f
000753r 2  FD BF FF FF  
000757r 2  85 8B FF FF  
00075Br 2  FF FE 86 5F  
00075Fr 2  FF BF 7F FF  .byte $ff, $bf, $7f, $ff, $ff, $fd, $e3, $fd, $fb, $9f, $ff, $ff, $82, $0b, $ff, $ff
000763r 2  FF FD E3 FD  
000767r 2  FB 9F FF FF  
00076Br 2  82 0B FF FF  
00076Fr 2  FF FE 84 5F  .byte $ff, $fe, $84, $5f, $ff, $bf, $3c, $00, $00, $0d, $f0, $1d, $fb, $9f, $ff, $ff
000773r 2  FF BF 3C 00  
000777r 2  00 0D F0 1D  
00077Br 2  FB 9F FF FF  
00077Fr 2  82 0B FF FF  .byte $82, $0b, $ff, $ff, $ff, $fe, $88, $5f, $ff, $3e, $3c, $00, $00, $0d, $f0, $1d
000783r 2  FF FE 88 5F  
000787r 2  FF 3E 3C 00  
00078Br 2  00 0D F0 1D  
00078Fr 2  F7 DF FF FF  .byte $f7, $df, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $98, $5f, $ff, $3e, $3d, $f7
000793r 2  80 8B FF FF  
000797r 2  FF FE 98 5F  
00079Br 2  FF 3E 3D F7  
00079Fr 2  FB ED F7 DD  .byte $fb, $ed, $f7, $dd, $f7, $df, $f7, $ff, $80, $8b, $ff, $ff, $ff, $fe, $b8, $5f
0007A3r 2  F7 DF F7 FF  
0007A7r 2  80 8B FF FF  
0007ABr 2  FF FE B8 5F  
0007AFr 2  FF 7E 7B F7  .byte $ff, $7e, $7b, $f7, $fb, $ed, $f7, $dd, $ef, $cf, $ff, $ff, $83, $4b, $ff, $ff
0007B3r 2  FB ED F7 DD  
0007B7r 2  EF CF FF FF  
0007BBr 2  83 4B FF FF  
0007BFr 2  FF FE 82 5F  .byte $ff, $fe, $82, $5f, $7f, $7e, $7b, $f7, $f7, $ed, $f7, $dd, $ef, $cf, $ff, $ff
0007C3r 2  7F 7E 7B F7  
0007C7r 2  F7 ED F7 DD  
0007CBr 2  EF CF FF FF  
0007CFr 2  81 AB FF FF  .byte $81, $ab, $ff, $ff, $ff, $fe, $ca, $5f, $fe, $7c, $7b, $f7, $f7, $ed, $ef, $dd
0007D3r 2  FF FE CA 5F  
0007D7r 2  FE 7C 7B F7  
0007DBr 2  F7 ED EF DD  
0007DFr 2  DF EF FF BF  .byte $df, $ef, $ff, $bf, $81, $0b, $ff, $ff, $ff, $fe, $c2, $5f, $fe, $7e, $7b, $f7
0007E3r 2  81 0B FF FF  
0007E7r 2  FF FE C2 5F  
0007EBr 2  FE 7E 7B F7  
0007EFr 2  F7 ED EF DD  .byte $f7, $ed, $ef, $dd, $df, $ef, $df, $ff, $81, $0b, $ff, $ff, $ff, $fe, $c4, $5f
0007F3r 2  DF EF DF FF  
0007F7r 2  81 0B FF FF  
0007FBr 2  FF FE C4 5F  
0007FFr 2  FE FE F7 F7  .byte $fe, $fe, $f7, $f7, $f7, $ed, $ef, $dd, $be, $07, $ff, $ff, $85, $0b, $ff, $ff
000803r 2  F7 ED EF DD  
000807r 2  BE 07 FF FF  
00080Br 2  85 0B FF FF  
00080Fr 2  FF FE C4 5F  .byte $ff, $fe, $c4, $5f, $fe, $fe, $f7, $f7, $ef, $ed, $ef, $dd, $be, $07, $fb, $f7
000813r 2  FE FE F7 F7  
000817r 2  EF ED EF DD  
00081Br 2  BE 07 FB F7  
00081Fr 2  85 0B FF FF  .byte $85, $0b, $ff, $ff, $ff, $fe, $9d, $5f, $fc, $fe, $f7, $77, $ee, $ed, $dd, $df
000823r 2  FF FE 9D 5F  
000827r 2  FC FE F7 77  
00082Br 2  EE ED DD DF  
00082Fr 2  7F F7 FF FF  .byte $7f, $f7, $ff, $ff, $84, $6b, $ff, $ff, $ff, $fe, $a6, $5f, $fc, $ff, $77, $76
000833r 2  84 6B FF FF  
000837r 2  FF FE A6 5F  
00083Br 2  FC FF 77 76  
00083Fr 2  EE ED DD DF  .byte $ee, $ed, $dd, $df, $bf, $f7, $ff, $bf, $8a, $8b, $ff, $ff, $ff, $fe, $a0, $df
000843r 2  BF F7 FF BF  
000847r 2  8A 8B FF FF  
00084Br 2  FF FE A0 DF  
00084Fr 2  FC 1F 6E 76  .byte $fc, $1f, $6e, $76, $ee, $ed, $dd, $df, $bf, $f3, $7f, $ff, $81, $8b, $ff, $ff
000853r 2  EE ED DD DF  
000857r 2  BF F3 7F FF  
00085Br 2  81 8B FF FF  
00085Fr 2  FF FE A0 DF  .byte $ff, $fe, $a0, $df, $fc, $1f, $6f, $77, $de, $ed, $dd, $dd, $bf, $f3, $ff, $ff
000863r 2  FC 1F 6F 77  
000867r 2  DE ED DD DD  
00086Br 2  BF F3 FF FF  
00086Fr 2  81 8B FF FF  .byte $81, $8b, $ff, $ff, $ff, $fe, $a0, $df, $f9, $ff, $6f, $77, $de, $ed, $bd, $dd
000873r 2  FF FE A0 DF  
000877r 2  F9 FF 6F 77  
00087Br 2  DE ED BD DD  
00087Fr 2  BF FB FF FF  .byte $bf, $fb, $ff, $ff, $81, $8b, $ff, $ff, $ff, $fe, $a0, $df, $f9, $ff, $af, $77
000883r 2  81 8B FF FF  
000887r 2  FF FE A0 DF  
00088Br 2  F9 FF AF 77  
00088Fr 2  EF ED BD DD  .byte $ef, $ed, $bd, $dd, $de, $03, $ff, $ff, $81, $8b, $ff, $ff, $ff, $fe, $a6, $5f
000893r 2  DE 03 FF FF  
000897r 2  81 8B FF FF  
00089Br 2  FF FE A6 5F  
00089Fr 2  FB FF 9F 77  .byte $fb, $ff, $9f, $77, $ef, $ed, $bd, $dd, $de, $01, $db, $ff, $8a, $8b, $ff, $ff
0008A3r 2  EF ED BD DD  
0008A7r 2  DE 01 DB FF  
0008ABr 2  8A 8B FF FF  
0008AFr 2  FF FE 9D 5F  .byte $ff, $fe, $9d, $5f, $fb, $ff, $9c, $76, $f7, $ef, $b9, $dd, $df, $f9, $ff, $ff
0008B3r 2  FB FF 9C 76  
0008B7r 2  F7 EF B9 DD  
0008BBr 2  DF F9 FF FF  
0008BFr 2  84 6B FF FF  .byte $84, $6b, $ff, $ff, $ff, $fe, $c4, $5f, $f3, $ff, $9c, $76, $f7, $ef, $b9, $dd
0008C3r 2  FF FE C4 5F  
0008C7r 2  F3 FF 9C 76  
0008CBr 2  F7 EF B9 DD  
0008CFr 2  DF FD FF FF  .byte $df, $fd, $ff, $ff, $85, $0b, $ff, $ff, $ff, $fe, $c4, $5f, $f3, $ff, $d8, $76
0008D3r 2  85 0B FF FF  
0008D7r 2  FF FE C4 5F  
0008DBr 2  F3 FF D8 76  
0008DFr 2  FB EF D1 DD  .byte $fb, $ef, $d1, $dd, $ef, $fd, $ff, $ff, $85, $0b, $ff, $ff, $ff, $fe, $c2, $5f
0008E3r 2  EF FD FF FF  
0008E7r 2  85 0B FF FF  
0008EBr 2  FF FE C2 5F  
0008EFr 2  FB FF D8 76  .byte $fb, $ff, $d8, $76, $fb, $ef, $d1, $dd, $ef, $fc, $ff, $ff, $81, $0b, $ff, $ff
0008F3r 2  FB EF D1 DD  
0008F7r 2  EF FC FF FF  
0008FBr 2  81 0B FF FF  
0008FFr 2  FF FE CA 5F  .byte $ff, $fe, $ca, $5f, $fb, $ff, $d8, $76, $fd, $ef, $d1, $dd, $ef, $fc, $ff, $ff
000903r 2  FB FF D8 76  
000907r 2  FD EF D1 DD  
00090Br 2  EF FC FF FF  
00090Fr 2  81 0B FF FF  .byte $81, $0b, $ff, $ff, $ff, $fe, $82, $5f, $f8, $2c, $00, $70, $01, $e0, $00, $1d
000913r 2  FF FE 82 5F  
000917r 2  F8 2C 00 70  
00091Br 2  01 E0 00 1D  
00091Fr 2  E0 00 FF FF  .byte $e0, $00, $ff, $ff, $81, $ab, $ff, $ff, $ff, $fe, $b0, $5f, $f8, $0e, $00, $70
000923r 2  81 AB FF FF  
000927r 2  FF FE B0 5F  
00092Br 2  F8 0E 00 70  
00092Fr 2  00 E0 00 1D  .byte $00, $e0, $00, $1d, $f0, $00, $ff, $ff, $82, $4b, $ff, $ff, $ff, $fe, $84, $5f
000933r 2  F0 00 FF FF  
000937r 2  82 4B FF FF  
00093Br 2  FF FE 84 5F  
00093Fr 2  FD EF FF FF  .byte $fd, $ef, $ff, $ff, $fe, $e7, $ff, $fd, $ff, $fe, $7f, $ff, $82, $0b, $ff, $ff
000943r 2  FE E7 FF FD  
000947r 2  FF FE 7F FF  
00094Br 2  82 0B FF FF  
00094Fr 2  FF FE 84 5F  .byte $ff, $fe, $84, $5f, $fd, $eb, $ff, $ff, $fe, $ef, $ff, $fd, $ff, $fc, $ff, $ff
000953r 2  FD EB FF FF  
000957r 2  FE EF FF FD  
00095Br 2  FF FC FF FF  
00095Fr 2  82 8B FF FF  .byte $82, $8b, $ff, $ff, $ff, $fe, $88, $5f, $fc, $eb, $ff, $ff, $fe, $ff, $ff, $fd
000963r 2  FF FE 88 5F  
000967r 2  FC EB FF FF  
00096Br 2  FE FF FF FD  
00096Fr 2  FF FC FB FF  .byte $ff, $fc, $fb, $ff, $82, $8b, $ff, $ff, $ff, $fe, $88, $5f, $fc, $2a, $00, $00
000973r 2  82 8B FF FF  
000977r 2  FF FE 88 5F  
00097Br 2  FC 2A 00 00  
00097Fr 2  00 F8 00 00  .byte $00, $f8, $00, $00, $00, $01, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $83, $5f
000983r 2  00 01 FF FF  
000987r 2  80 8B FF FF  
00098Br 2  FF FE 83 5F  
00098Fr 2  FE 0A 00 00  .byte $fe, $0a, $00, $00, $00, $f0, $00, $00, $00, $01, $ff, $ff, $84, $8b, $ff, $ff
000993r 2  00 F0 00 00  
000997r 2  00 01 FF FF  
00099Br 2  84 8B FF FF  
00099Fr 2  FF FE 90 5F  .byte $ff, $fe, $90, $5f, $fe, $34, $20, $00, $00, $e0, $08, $00, $00, $03, $ff, $ff
0009A3r 2  FE 34 20 00  
0009A7r 2  00 E0 08 00  
0009ABr 2  00 03 FF FF  
0009AFr 2  8B 0B FF FF  .byte $8b, $0b, $ff, $ff, $ff, $fe, $94, $df, $ff, $f7, $df, $ff, $fe, $ff, $f7, $ff
0009B3r 2  FF FE 94 DF  
0009B7r 2  FF F7 DF FF  
0009BBr 2  FE FF F7 FF  
0009BFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $90, $df, $ff, $f7, $cf, $db
0009C3r 2  81 0B FF FF  
0009C7r 2  FF FE 90 DF  
0009CBr 2  FF F7 CF DB  
0009CFr 2  FE AF E7 FF  .byte $fe, $af, $e7, $ff, $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $88, $df
0009D3r 2  FF FF FF FF  
0009D7r 2  81 0B FF FF  
0009DBr 2  FF FE 88 DF  
0009DFr 2  FF FB DF A7  .byte $ff, $fb, $df, $a7, $fe, $2f, $af, $ff, $ff, $ff, $ff, $ff, $81, $4b, $ff, $ff
0009E3r 2  FE 2F AF FF  
0009E7r 2  FF FF FF FF  
0009EBr 2  81 4B FF FF  
0009EFr 2  FF FE 88 DF  .byte $ff, $fe, $88, $df, $ff, $fb, $df, $8f, $fe, $2f, $9f, $ff, $ff, $ff, $ff, $ff
0009F3r 2  FF FB DF 8F  
0009F7r 2  FE 2F 9F FF  
0009FBr 2  FF FF FF FF  
0009FFr 2  81 4B FF FF  .byte $81, $4b, $ff, $ff, $ff, $fe, $ae, $5f, $ff, $f7, $07, $7f, $fe, $7f, $9f, $ff
000A03r 2  FF FE AE 5F  
000A07r 2  FF F7 07 7F  
000A0Br 2  FE 7F 9F FF  
000A0Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $8c, $4b, $ff, $ff, $ff, $fe, $99, $5f, $ff, $f4, $70, $7f
000A13r 2  8C 4B FF FF  
000A17r 2  FF FE 99 5F  
000A1Br 2  FF F4 70 7F  
000A1Fr 2  FF F2 9F FF  .byte $ff, $f2, $9f, $ff, $ff, $ff, $ff, $ff, $82, $ab, $ff, $ff, $ff, $fe, $c1, $5f
000A23r 2  FF FF FF FF  
000A27r 2  82 AB FF FF  
000A2Br 2  FF FE C1 5F  
000A2Fr 2  FF F1 FF FF  .byte $ff, $f1, $ff, $ff, $7f, $fa, $df, $ff, $ff, $ff, $fb, $ff, $83, $0b, $ff, $ff
000A33r 2  7F FA DF FF  
000A37r 2  FF FF FB FF  
000A3Br 2  83 0B FF FF  
000A3Fr 2  FF FE C1 5F  .byte $ff, $fe, $c1, $5f, $ff, $f3, $ff, $ff, $ff, $fb, $9f, $ff, $ff, $ff, $ff, $ff
000A43r 2  FF F3 FF FF  
000A47r 2  FF FB 9F FF  
000A4Br 2  FF FF FF FF  
000A4Fr 2  83 0B FF FF  .byte $83, $0b, $ff, $ff, $ff, $fe, $c1, $5f, $ff, $f3, $ff, $ff, $ff, $fb, $3f, $ff
000A53r 2  FF FE C1 5F  
000A57r 2  FF F3 FF FF  
000A5Br 2  FF FB 3F FF  
000A5Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $83, $0b, $ff, $ff, $ff, $fe, $c1, $5f, $ff, $fb, $ff, $ff
000A63r 2  83 0B FF FF  
000A67r 2  FF FE C1 5F  
000A6Br 2  FF FB FF FF  
000A6Fr 2  FF F9 7F FF  .byte $ff, $f9, $7f, $ff, $ff, $eb, $ff, $ff, $83, $0b, $ff, $ff, $ff, $fe, $99, $5f
000A73r 2  FF EB FF FF  
000A77r 2  83 0B FF FF  
000A7Br 2  FF FE 99 5F  
000A7Fr 2  FF F9 FF FF  .byte $ff, $f9, $ff, $ff, $ff, $fd, $7f, $ff, $ff, $ff, $ff, $ff, $82, $ab, $ff, $ff
000A83r 2  FF FD 7F FF  
000A87r 2  FF FF FF FF  
000A8Br 2  82 AB FF FF  
000A8Fr 2  FF FE AE 5F  .byte $ff, $fe, $ae, $5f, $ff, $fd, $ff, $ff, $ff, $e0, $7f, $fd, $f8, $00, $0f, $ff
000A93r 2  FF FD FF FF  
000A97r 2  FF E0 7F FD  
000A9Br 2  F8 00 0F FF  
000A9Fr 2  8C 4B FF FF  .byte $8c, $4b, $ff, $ff, $ff, $fe, $88, $df, $ff, $fe, $ff, $ff, $ff, $de, $7f, $ff
000AA3r 2  FF FE 88 DF  
000AA7r 2  FF FE FF FF  
000AABr 2  FF DE 7F FF  
000AAFr 2  FF 00 1F FF  .byte $ff, $00, $1f, $ff, $81, $4b, $ff, $ff, $ff, $fe, $88, $df, $ef, $fc, $ff, $ff
000AB3r 2  81 4B FF FF  
000AB7r 2  FF FE 88 DF  
000ABBr 2  EF FC FF FF  
000ABFr 2  FF FE 7F F8  .byte $ff, $fe, $7f, $f8, $00, $00, $03, $ff, $81, $4b, $ff, $ff, $ff, $fe, $90, $df
000AC3r 2  00 00 03 FF  
000AC7r 2  81 4B FF FF  
000ACBr 2  FF FE 90 DF  
000ACFr 2  FF EC FF FF  .byte $ff, $ec, $ff, $ff, $ff, $fe, $ff, $f0, $00, $00, $00, $ff, $81, $0b, $ff, $ff
000AD3r 2  FF FE FF F0  
000AD7r 2  00 00 00 FF  
000ADBr 2  81 0B FF FF  
000ADFr 2  FF FE 94 DF  .byte $ff, $fe, $94, $df, $ff, $e1, $ff, $ff, $ff, $fc, $fd, $00, $00, $3f, $f0, $ff
000AE3r 2  FF E1 FF FF  
000AE7r 2  FF FC FD 00  
000AEBr 2  00 3F F0 FF  
000AEFr 2  81 0B FF FF  .byte $81, $0b, $ff, $ff, $ff, $fe, $90, $5f, $ff, $63, $ff, $ff, $7f, $fd, $ff, $e0
000AF3r 2  FF FE 90 5F  
000AF7r 2  FF 63 FF FF  
000AFBr 2  7F FD FF E0  
000AFFr 2  01 FE FF 7F  .byte $01, $fe, $ff, $7f, $8b, $0b, $ff, $ff, $ff, $fe, $87, $5f, $ff, $67, $ff, $9f
000B03r 2  8B 0B FF FF  
000B07r 2  FF FE 87 5F  
000B0Br 2  FF 67 FF 9F  
000B0Fr 2  FF FC 60 00  .byte $ff, $fc, $60, $00, $0f, $ff, $7f, $ff, $85, $8b, $ff, $ff, $ff, $fe, $86, $5f
000B13r 2  0F FF 7F FF  
000B17r 2  85 8B FF FF  
000B1Br 2  FF FE 86 5F  
000B1Fr 2  FF 73 FF FF  .byte $ff, $73, $ff, $ff, $ff, $fd, $fc, $03, $3e, $f7, $ff, $ff, $82, $0b, $ff, $ff
000B23r 2  FF FD FC 03  
000B27r 2  3E F7 FF FF  
000B2Br 2  82 0B FF FF  
000B2Fr 2  FF FE 84 5F  .byte $ff, $fe, $84, $5f, $ff, $fb, $fe, $e7, $ff, $e0, $00, $0f, $fd, $ef, $ff, $ff
000B33r 2  FF FB FE E7  
000B37r 2  FF E0 00 0F  
000B3Br 2  FD EF FF FF  
000B3Fr 2  82 0B FF FF  .byte $82, $0b, $ff, $ff, $ff, $fe, $88, $5f, $ff, $fd, $ff, $ff, $ff, $f0, $00, $1f
000B43r 2  FF FE 88 5F  
000B47r 2  FF FD FF FF  
000B4Br 2  FF F0 00 1F  
000B4Fr 2  FF CF FF FF  .byte $ff, $cf, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $98, $5f, $ff, $f9, $ff, $ff
000B53r 2  80 8B FF FF  
000B57r 2  FF FE 98 5F  
000B5Br 2  FF F9 FF FF  
000B5Fr 2  FF C0 00 1F  .byte $ff, $c0, $00, $1f, $ff, $f7, $ff, $ff, $80, $8b, $ff, $ff, $ff, $fe, $b8, $5f
000B63r 2  FF F7 FF FF  
000B67r 2  80 8B FF FF  
000B6Br 2  FF FE B8 5F  
000B6Fr 2  FE F2 FF FF  .byte $fe, $f2, $ff, $ff, $ff, $80, $00, $7f, $ff, $df, $ff, $ff, $83, $4b, $ff, $ff
000B73r 2  FF 80 00 7F  
000B77r 2  FF DF FF FF  
000B7Br 2  83 4B FF FF  
000B7Fr 2  FF FE 82 5F  .byte $ff, $fe, $82, $5f, $ff, $c6, $ff, $ff, $ff, $c1, $f3, $ff, $ff, $ff, $ff, $ff
000B83r 2  FF C6 FF FF  
000B87r 2  FF C1 F3 FF  
000B8Br 2  FF FF FF FF  
000B8Fr 2  81 AB FF FF  .byte $81, $ab, $ff, $ff, $ff, $fe, $ca, $5f, $ff, $df, $7f, $ff, $ff, $06, $0f, $ff
000B93r 2  FF FE CA 5F  
000B97r 2  FF DF 7F FF  
000B9Br 2  FF 06 0F FF  
000B9Fr 2  CF FF FF FF  .byte $cf, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $c2, $5f, $ff, $ef, $7f, $ff
000BA3r 2  81 0B FF FF  
000BA7r 2  FF FE C2 5F  
000BABr 2  FF EF 7F FF  
000BAFr 2  F0 8D E7 FF  .byte $f0, $8d, $e7, $ff, $b7, $ff, $ff, $ff, $81, $0b, $ff, $ff, $ff, $fe, $c4, $5f
000BB3r 2  B7 FF FF FF  
000BB7r 2  81 0B FF FF  
000BBBr 2  FF FE C4 5F  
000BBFr 2  FA EF 3F FF  .byte $fa, $ef, $3f, $ff, $ff, $1f, $e9, $ff, $e3, $ff, $ff, $ff, $85, $0b, $ff, $ff
000BC3r 2  FF 1F E9 FF  
000BC7r 2  E3 FF FF FF  
000BCBr 2  85 0B FF FF  
000BCFr 2  FF FE C4 5F  .byte $ff, $fe, $c4, $5f, $fe, $ef, $07, $ff, $80, $1f, $e7, $ff, $ff, $ff, $ff, $ff
000BD3r 2  FE EF 07 FF  
000BD7r 2  80 1F E7 FF  
000BDBr 2  FF FF FF FF  
000BDFr 2  85 0B FF FF  .byte $85, $0b, $ff, $ff, $ff, $fe, $9d, $5f, $fe, $df, $83, $ff, $e0, $0f, $9b, $ff
000BE3r 2  FF FE 9D 5F  
000BE7r 2  FE DF 83 FF  
000BEBr 2  E0 0F 9B FF  
000BEFr 2  F7 FF FF FF  .byte $f7, $ff, $ff, $ff, $84, $6b, $ff, $ff, $ff, $fe, $a6, $5f, $7f, $ff, $f8, $fe
000BF3r 2  84 6B FF FF  
000BF7r 2  FF FE A6 5F  
000BFBr 2  7F FF F8 FE  
000BFFr 2  00 27 7F FF  .byte $00, $27, $7f, $ff, $ff, $ff, $ff, $ff, $8a, $8b, $ff, $ff, $ff, $fe, $a0, $df
000C03r 2  FF FF FF FF  
000C07r 2  8A 8B FF FF  
000C0Br 2  FF FE A0 DF  
000C0Fr 2  FF E7 FC 3F  .byte $ff, $e7, $fc, $3f, $80, $3f, $ff, $ff, $ff, $ff, $ff, $ff, $81, $8b, $ff, $ff
000C13r 2  80 3F FF FF  
000C17r 2  FF FF FF FF  
000C1Br 2  81 8B FF FF  
000C1Fr 2  FF FE A0 DF  .byte $ff, $fe, $a0, $df, $ff, $db, $fe, $1c, $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000C23r 2  FF DB FE 1C  
000C27r 2  00 FF FF FF  
000C2Br 2  FF FF FF FF  
000C2Fr 2  81 8B FF FF  .byte $81, $8b, $ff, $ff, $ff, $fe, $a0, $df, $ff, $bf, $ff, $82, $03, $ff, $ff, $af
000C33r 2  FF FE A0 DF  
000C37r 2  FF BF FF 82  
000C3Br 2  03 FF FF AF  
000C3Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $81, $8b, $ff, $ff, $ff, $fe, $a0, $df, $ff, $ff, $ff, $c4
000C43r 2  81 8B FF FF  
000C47r 2  FF FE A0 DF  
000C4Br 2  FF FF FF C4  
000C4Fr 2  1F FF FF DF  .byte $1f, $ff, $ff, $df, $ff, $ff, $ff, $ff, $81, $8b, $ff, $ff, $ff, $fe, $a6, $5f
000C53r 2  FF FF FF FF  
000C57r 2  81 8B FF FF  
000C5Br 2  FF FE A6 5F  
000C5Fr 2  FF FF FE 00  .byte $ff, $ff, $fe, $00, $3f, $ff, $fe, $bf, $ff, $ff, $ff, $ff, $8a, $8b, $ff, $ff
000C63r 2  3F FF FE BF  
000C67r 2  FF FF FF FF  
000C6Br 2  8A 8B FF FF  
000C6Fr 2  FF FE 9D 5F  .byte $ff, $fe, $9d, $5f, $ff, $ff, $ff, $80, $3f, $3f, $fe, $7f, $ff, $ff, $ff, $ff
000C73r 2  FF FF FF 80  
000C77r 2  3F 3F FE 7F  
000C7Br 2  FF FF FF FF  
000C7Fr 2  84 6B FF FF  .byte $84, $6b, $ff, $ff, $ff, $fe, $c4, $5f, $ff, $ff, $f8, $01, $ff, $bf, $fd, $ff
000C83r 2  FF FE C4 5F  
000C87r 2  FF FF F8 01  
000C8Br 2  FF BF FD FF  
000C8Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $85, $0b, $ff, $ff, $ff, $fe, $c4, $5f, $ff, $ff, $fe, $01
000C93r 2  85 0B FF FF  
000C97r 2  FF FE C4 5F  
000C9Br 2  FF FF FE 01  
000C9Fr 2  FE FD FF FF  .byte $fe, $fd, $ff, $ff, $ff, $ff, $ff, $ff, $85, $0b, $ff, $ff, $ff, $fe, $c2, $5f
000CA3r 2  FF FF FF FF  
000CA7r 2  85 0B FF FF  
000CABr 2  FF FE C2 5F  
000CAFr 2  FF FF F0 3F  .byte $ff, $ff, $f0, $3f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $81, $0b, $ff, $ff
000CB3r 2  FF FF FF FF  
000CB7r 2  FF FF FF FF  
000CBBr 2  81 0B FF FF  
000CBFr 2  FF FE CA 5F  .byte $ff, $fe, $ca, $5f, $ff, $ff, $fc, $7f, $ff, $7d, $ff, $ff, $ff, $ff, $ff, $ff
000CC3r 2  FF FF FC 7F  
000CC7r 2  FF 7D FF FF  
000CCBr 2  FF FF FF FF  
000CCFr 2  81 0B FF FF  .byte $81, $0b, $ff, $ff, $ff, $fe, $82, $5f, $ff, $ff, $f8, $7f, $ff, $ff, $ff, $ef
000CD3r 2  FF FE 82 5F  
000CD7r 2  FF FF F8 7F  
000CDBr 2  FF FF FF EF  
000CDFr 2  CD 9F 7F FF  .byte $cd, $9f, $7f, $ff, $81, $ab, $ff, $ff, $ff, $fe, $b0, $5f, $ff, $ff, $e1, $ff
000CE3r 2  81 AB FF FF  
000CE7r 2  FF FE B0 5F  
000CEBr 2  FF FF E1 FF  
000CEFr 2  F7 FF FF EF  .byte $f7, $ff, $ff, $ef, $cd, $9f, $7f, $ff, $82, $4b, $ff, $ff, $ff, $fe, $84, $5f
000CF3r 2  CD 9F 7F FF  
000CF7r 2  82 4B FF FF  
000CFBr 2  FF FE 84 5F  
000CFFr 2  FF FF F3 E7  .byte $ff, $ff, $f3, $e7, $cf, $ff, $ff, $e4, $04, $93, $21, $3f, $82, $0b, $ff, $ff
000D03r 2  CF FF FF E4  
000D07r 2  04 93 21 3F  
000D0Br 2  82 0B FF FF  
000D0Fr 2  FF FE 84 5F  .byte $ff, $fe, $84, $5f, $ff, $ff, $c7, $eb, $cf, $ff, $ff, $e0, $04, $03, $00, $7f
000D13r 2  FF FF C7 EB  
000D17r 2  CF FF FF E0  
000D1Br 2  04 03 00 7F  
000D1Fr 2  82 8B FF FF  .byte $82, $8b, $ff, $ff, $ff, $fe, $88, $5f, $ff, $ff, $ef, $eb, $b7, $ff, $ff, $e8
000D23r 2  FF FE 88 5F  
000D27r 2  FF FF EF EB  
000D2Br 2  B7 FF FF E8  
000D2Fr 2  05 03 41 3F  .byte $05, $03, $41, $3f, $82, $8b, $ff, $ff, $ff, $fe, $88, $5f, $ff, $ff, $df, $ff
000D33r 2  82 8B FF FF  
000D37r 2  FF FE 88 5F  
000D3Br 2  FF FF DF FF  
000D3Fr 2  FF FF FF E0  .byte $ff, $ff, $ff, $e0, $04, $07, $01, $bf, $80, $8b, $ff, $ff, $ff, $fe, $80, $5f
000D43r 2  04 07 01 BF  
000D47r 2  80 8B FF FF  
000D4Br 2  FF FE 80 5F  
000D4Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $e6, $44, $93, $32, $3f, $84, $8b, $ff, $ff
000D53r 2  FF FF FF E6  
000D57r 2  44 93 32 3F  
000D5Br 2  84 8B FF FF  
000D5Fr 2  FF FE 90 5F  .byte $ff, $fe, $90, $5f, $ff, $ff, $bf, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000D63r 2  FF FF BF FF  
000D67r 2  FF FF FF FF  
000D6Br 2  FF FF FF FF  
000D6Fr 2  81 0B FF FF  .byte $81, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000D73r 2  FF FE 80 5F  
000D77r 2  FF FF FF FF  
000D7Br 2  FF FF FF FF  
000D7Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff
000D83r 2  80 0B FF FF  
000D87r 2  FF FE 80 5F  
000D8Br 2  FF FF FF FF  
000D8Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $80, $5f
000D93r 2  FF FF FF FF  
000D97r 2  80 0B FF FF  
000D9Br 2  FF FE 80 5F  
000D9Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff
000DA3r 2  FF FF FF FF  
000DA7r 2  FF FF FF FF  
000DABr 2  80 0B FF FF  
000DAFr 2  FF FE 80 5F  .byte $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000DB3r 2  FF FF FF FF  
000DB7r 2  FF FF FF FF  
000DBBr 2  FF FF FF FF  
000DBFr 2  80 0B FF FF  .byte $80, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000DC3r 2  FF FE 80 5F  
000DC7r 2  FF FF FF FF  
000DCBr 2  FF FF FF FF  
000DCFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $80, $5f, $ff, $ff, $ff, $ff
000DD3r 2  80 0B FF FF  
000DD7r 2  FF FE 80 5F  
000DDBr 2  FF FF FF FF  
000DDFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $80, $0b, $ff, $ff, $ff, $fe, $80, $40
000DE3r 2  FF FF FF FF  
000DE7r 2  80 0B FF FF  
000DEBr 2  FF FE 80 40  
000DEFr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $40, $0b, $ff, $ff
000DF3r 2  00 00 00 00  
000DF7r 2  00 00 00 00  
000DFBr 2  40 0B FF FF  
000DFFr 2  FF FE 80 60  .byte $ff, $fe, $80, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
000E03r 2  00 00 00 00  
000E07r 2  00 00 00 00  
000E0Br 2  00 00 00 00  
000E0Fr 2  00 0B FF FF  .byte $00, $0b, $ff, $ff, $ff, $fe, $80, $40, $00, $00, $00, $00, $00, $00, $00, $00
000E13r 2  FF FE 80 40  
000E17r 2  00 00 00 00  
000E1Br 2  00 00 00 00  
000E1Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $20, $0b, $ff, $ff, $ff, $fe, $83, $ff, $ff, $ff, $ff, $ff
000E23r 2  20 0B FF FF  
000E27r 2  FF FE 83 FF  
000E2Br 2  FF FF FF FF  
000E2Fr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ee, $0b, $ff, $ff, $ff, $fe, $8c, $00
000E33r 2  FF FF FF FF  
000E37r 2  EE 0B FF FF  
000E3Br 2  FF FE 8C 00  
000E3Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $11, $0b, $ff, $ff
000E43r 2  00 00 00 00  
000E47r 2  00 00 00 00  
000E4Br 2  11 0B FF FF  
000E4Fr 2  FF FE 90 C0  .byte $ff, $fe, $90, $c0, $00, $60, $00, $00, $00, $00, $00, $00, $00, $00, $60, $00
000E53r 2  00 60 00 00  
000E57r 2  00 00 00 00  
000E5Br 2  00 00 60 00  
000E5Fr 2  00 CB FF FF  .byte $00, $cb, $ff, $ff, $ff, $fe, $a0, $40, $00, $10, $00, $00, $00, $00, $00, $00
000E63r 2  FF FE A0 40  
000E67r 2  00 10 00 00  
000E6Br 2  00 00 00 00  
000E6Fr 2  00 00 10 00  .byte $00, $00, $10, $00, $08, $2b, $ff, $ff, $ff, $fe, $41, $40, $00, $80, $00, $00
000E73r 2  08 2B FF FF  
000E77r 2  FF FE 41 40  
000E7Br 2  00 80 00 00  
000E7Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $80, $00, $00, $03, $ff, $ff, $ff, $fe, $00, $40
000E83r 2  00 00 80 00  
000E87r 2  00 03 FF FF  
000E8Br 2  FF FE 00 40  
000E8Fr 2  01 88 1D FF  .byte $01, $88, $1d, $ff, $fd, $76, $cf, $7f, $bf, $01, $88, $00, $04, $13, $ff, $ff
000E93r 2  FD 76 CF 7F  
000E97r 2  BF 01 88 00  
000E9Br 2  04 13 FF FF  
000E9Fr 2  FF FE 82 40  .byte $ff, $fe, $82, $40, $02, $16, $a2, $01, $02, $88, $08, $80, $40, $22, $16, $00
000EA3r 2  02 16 A2 01  
000EA7r 2  02 88 08 80  
000EABr 2  40 22 16 00  
000EAFr 2  00 03 FF FF  .byte $00, $03, $ff, $ff, $ff, $fe, $80, $40, $14, $11, $2b, $27, $02, $99, $08, $81
000EB3r 2  FF FE 80 40  
000EB7r 2  14 11 2B 27  
000EBBr 2  02 99 08 81  
000EBFr 2  40 14 11 80  .byte $40, $14, $11, $80, $02, $03, $ff, $ff, $ff, $fe, $04, $00, $09, $98, $af, $21
000EC3r 2  02 03 FF FF  
000EC7r 2  FF FE 04 00  
000ECBr 2  09 98 AF 21  
000ECFr 2  02 88 09 81  .byte $02, $88, $09, $81, $40, $09, $98, $c0, $10, $0b, $ff, $ff, $ff, $fe, $00, $00
000ED3r 2  40 09 98 C0  
000ED7r 2  10 0B FF FF  
000EDBr 2  FF FE 00 00  
000EDFr 2  07 6E 21 27  .byte $07, $6e, $21, $27, $00, $98, $09, $81, $40, $27, $6e, $00, $11, $0b, $ff, $ff
000EE3r 2  00 98 09 81  
000EE7r 2  40 27 6E 00  
000EEBr 2  11 0B FF FF  
000EEFr 2  FF FF 88 00  .byte $ff, $ff, $88, $00, $12, $81, $99, $27, $32, $98, $09, $89, $40, $12, $81, $00
000EF3r 2  12 81 99 27  
000EF7r 2  32 98 09 89  
000EFBr 2  40 12 81 00  
000EFFr 2  10 03 FF FF  .byte $10, $03, $ff, $ff, $ff, $ff, $80, $80, $08, $72, $29, $21, $02, $81, $08, $81
000F03r 2  FF FF 80 80  
000F07r 2  08 72 29 21  
000F0Br 2  02 81 08 81  
000F0Fr 2  40 08 72 C0  .byte $40, $08, $72, $c0, $00, $83, $ff, $ff, $ff, $ff, $90, $80, $04, $81, $21, $21
000F13r 2  00 83 FF FF  
000F17r 2  FF FF 90 80  
000F1Br 2  04 81 21 21  
000F1Fr 2  02 80 08 80  .byte $02, $80, $08, $80, $40, $24, $81, $00, $00, $07, $ff, $ff, $ff, $ff, $00, $80
000F23r 2  40 24 81 00  
000F27r 2  00 07 FF FF  
000F2Br 2  FF FF 00 80  
000F2Fr 2  04 80 1E DE  .byte $04, $80, $1e, $de, $cd, $7e, $cf, $7f, $bf, $04, $80, $00, $00, $57, $ff, $ff
000F33r 2  CD 7E CF 7F  
000F37r 2  BF 04 80 00  
000F3Br 2  00 57 FF FF  
000F3Fr 2  FF FF 20 00  .byte $ff, $ff, $20, $00, $04, $70, $00, $00, $00, $00, $00, $00, $00, $04, $70, $00
000F43r 2  04 70 00 00  
000F47r 2  00 00 00 00  
000F4Br 2  00 04 70 00  
000F4Fr 2  08 1F FF FF  .byte $08, $1f, $ff, $ff, $ff, $ff, $40, $00, $00, $82, $00, $00, $00, $00, $00, $00
000F53r 2  FF FF 40 00  
000F57r 2  00 82 00 00  
000F5Br 2  00 00 00 00  
000F5Fr 2  00 00 82 00  .byte $00, $00, $82, $00, $08, $2f, $ff, $ff, $ff, $ff, $c1, $00, $03, $0c, $00, $00
000F63r 2  08 2F FF FF  
000F67r 2  FF FF C1 00  
000F6Br 2  03 0C 00 00  
000F6Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $03, $0c, $00, $00, $2f, $ff, $ff, $ff, $ff, $a0, $00
000F73r 2  00 03 0C 00  
000F77r 2  00 2F FF FF  
000F7Br 2  FF FF A0 00  
000F7Fr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $5f, $ff, $ff
000F83r 2  00 00 00 00  
000F87r 2  00 00 00 00  
000F8Br 2  04 5F FF FF  
000F8Fr 2  FF FF DA FF  .byte $ff, $ff, $da, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000F93r 2  FF FF FF FF  
000F97r 2  FF FF FF FF  
000F9Br 2  FF FF FF FF  
000F9Fr 2  F2 9F FF FF  .byte $f2, $9f, $ff, $ff, $ff, $ff, $e4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
000FA3r 2  FF FF E4 FF  
000FA7r 2  FF FF FF FF  
000FABr 2  FF FF FF FF  
000FAFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $f9, $3f, $ff, $ff, $ff, $ff, $f9, $ff, $ff, $ff, $ff, $ff
000FB3r 2  F9 3F FF FF  
000FB7r 2  FF FF F9 FF  
000FBBr 2  FF FF FF FF  
000FBFr 2  FF FF FF FF  .byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fc, $ff, $ff, $ff, $ff, $ff, $f0, $00
000FC3r 2  FF FF FF FF  
000FC7r 2  FC FF FF FF  
000FCBr 2  FF FF F0 00  
000FCFr 2  00 00 00 00  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $7f, $ff, $ff
000FD3r 2  00 00 00 00  
000FD7r 2  00 00 00 00  
000FDBr 2  00 7F FF FF  
000FDFr 2               
000FDFr 1               end:
000FDFr 1               
000FDFr 1               
000FDFr 1               
000FDFr 1               .segment "EXEHDR"
000000r 1  FF FF        .word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
000002r 1  rr rr        .word   main                    ; zacatek kodoveho segmentu
000004r 1  rr rr        .word   end - 1                ; konec kodoveho segmentu
000006r 1               
000006r 1               
000006r 1               .segment "AUTOSTRT"             ; segment s pocatecni adresou
000000r 1  E0 02        .word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
000002r 1  E1 02        .word   RUNAD+1
000004r 1  rr rr        .word   main                    ; adresa vstupniho bodu do programu
000006r 1               
000006r 1               ; finito
000006r 1               
