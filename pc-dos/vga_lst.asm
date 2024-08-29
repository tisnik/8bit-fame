     1                                  ; Graficky rezim karty VGA s rozlisenim 320x240 pixelu.
     2                                  ; Vyuziti souboru se symboly, makry a podprogramy.
     3                                  ; Vypnuti zretezeni bitovych rovin.
     4                                  ; Vykresleni rastroveho obrazku postupne do vsech bitovych rovin.
     5                                  ; Odskrolovani obrazku.
     6                                  ; Pouziti knihovnich funkci.
     7                                  ;
     8                                  ; preklad pomoci:
     9                                  ;     nasm -f bin -o vga.com vga_320x240_lib.asm
    10                                  ;
    11                                  ; nebo pouze:
    12                                  ;     nasm -o vga.com vga_320x240_lib.asm
    13                                  
    14                                  ;-----------------------------------------------------------------------------
    15                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    16                                  
    17                                  start:
    18 00000000 E98800                          jmp main            ; skok na zacatek kodu
    19                                  
    20                                  %include "io.asm"           ; nacist symboly, makra a podprogramy
     1                              <1> ;-----------------------------------------------------------------------------
     2                              <1> ; Symboly, makra a subrutiny pro zjednoduseni I/O operaci
     3                              <1> ;-----------------------------------------------------------------------------
     4                              <1> 
     5                              <1> %ifndef IO_LIB
     6                              <1> %define IO_LIB
     7                              <1> 
     8                              <1> 
     9                              <1> ;-----------------------------------------------------------------------------
    10                              <1> ; makra
    11                              <1> ;-----------------------------------------------------------------------------
    12                              <1> 
    13                              <1> 
    14                              <1> ; ukonceni procesu a navrat do DOSu
    15                              <1> %macro exit 0
    16                              <1>         mov     ah, 0x4c
    17                              <1>         int     0x21
    18                              <1> %endmacro
    19                              <1> 
    20                              <1> ; vyprazdneni bufferu klavesnice a cekani na klavesu
    21                              <1> %macro wait_key 0
    22                              <1>         xor     ax, ax
    23                              <1>         int     0x16
    24                              <1> %endmacro
    25                              <1> 
    26                              <1> %endif
    21                                  %include "vga_lib.asm"      ; nacist symboly, makra a podprogramy
     1                              <1> ;-----------------------------------------------------------------------------
     2                              <1> ; Symboly, makra a subrutiny pro zjednoduseni programovaci graficke karty VGA
     3                              <1> ;-----------------------------------------------------------------------------
     4                              <1> 
     5                              <1> 
     6                              <1> %ifndef VGA_LIB
     7                              <1> 
     8                              <1> 
     9                              <1> ;-----------------------------------------------------------------------------
    10                              <1> ; symboly
    11                              <1> ;-----------------------------------------------------------------------------
    12                              <1> 
    13                              <1> ; registry karty VGA
    14                              <1> MISC_REGISTER        equ 0x3c2
    15                              <1> SEQUENCER_INDEX      equ 0x3c4
    16                              <1> SEQUENCER_DATA       equ 0x3c5
    17                              <1> CRTC_INDEX           equ 0x3d4
    18                              <1> CRTC_DATA            equ 0x3d5
    19                              <1> INPUT_STATUS         equ 0x3da
    20                              <1> BITPLANE_SELECTOR    equ 0x02
    21                              <1> MEMORY_MODE_REGISTER equ 0x04   ; sekvencer
    22                              <1> UNDERLINE_LOCATION   equ 0x14   ; CRTC
    23                              <1> MODE_CONTROL         equ 0x17   ; CRTC
    24                              <1> START_ADDRESS_HIGH   equ 0x0c   ; CRTC
    25                              <1> START_ADDRESS_LOW    equ 0x0d   ; CRTC
    26                              <1> 
    27                              <1> ; bitove masky
    28                              <1> V_RETRACE            equ 0x08
    29                              <1> 
    30                              <1> 
    31                              <1> 
    32                              <1> ;-----------------------------------------------------------------------------
    33                              <1> ; makra
    34                              <1> ;-----------------------------------------------------------------------------
    35                              <1> 
    36                              <1> ; nastaveni grafickeho rezimu
    37                              <1> %macro gfx_mode 1
    38                              <1>         mov     ah, 0
    39                              <1>         mov     al, %1
    40                              <1>         int     0x10
    41                              <1> %endmacro
    42                              <1> 
    43                              <1> ; nastaveni jednoho registru sekvenceru
    44                              <1> %macro set_sequencer_register 2
    45                              <1>         mov dx, SEQUENCER_INDEX
    46                              <1>         mov al, %1    ; ridici registr
    47                              <1>         out dx, al
    48                              <1>         inc dx
    49                              <1>         mov al, %2    ; hodnota zapisovana do registru
    50                              <1>         out dx, al
    51                              <1> %endmacro
    52                              <1> 
    53                              <1> ; nastaveni jednoho CRTC registru
    54                              <1> %macro set_crtc_register 2
    55                              <1>         mov dx, CRTC_INDEX
    56                              <1>         mov al, %1    ; ridici registr (CRTC)
    57                              <1>         out dx, al
    58                              <1>         inc dx
    59                              <1>         mov al, %2    ; hodnota zapisovana do registru
    60                              <1>         out dx, al
    61                              <1> %endmacro
    62                              <1> 
    63                              <1> ; vyber bitove roviny
    64                              <1> %macro select_bitplane 1
    65                              <1>         mov  al, %1         ; bitova rovina
    66                              <1>         mov  dx, SEQUENCER_INDEX
    67                              <1>         mov  ah, BITPLANE_SELECTOR
    68                              <1>         xchg ah, al
    69                              <1>         out  dx, ax         ; vyber registru sekvenceru
    70                              <1>                             ; a zapis masky bitovych rovin
    71                              <1> %endmacro
    72                              <1> 
    73                              <1> ; paleta ve stupnich sedi
    74                              <1> %macro grayscale_palette 0
    75                              <1>         mov ax, 0x1010      ; cislo sluzby a podsluzby VGA BIOSu
    76                              <1>         xor bl, bl          ; index barvy
    77                              <1> .next_dac:
    78                              <1>         mov ch, bl          ; prvni barvova slozka
    79                              <1>         shr ch, 1
    80                              <1>         shr ch, 1
    81                              <1>         mov cl, ch          ; druha barvova slozka
    82                              <1>         mov dh, ch          ; treti barvova slozka
    83                              <1>         int 0x10            ; modifikace mapovani v DAC
    84                              <1>         inc bl              ; zvysit index v DAC
    85                              <1>         jnz .next_dac       ; nastavit dalsi barvu, dokud nedosahneme hodnoty 256
    86                              <1> %endmacro
    87                              <1> 
    88                              <1> ; presun obrazku
    89                              <1> %macro move_one_bitplane 3
    90                              <1>         mov si, %1          ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku
    91                              <1>         add si, ax          ; offset pixelu
    92                              <1>         mov di, %2          ; adresa, kam se bude vykreslovat
    93                              <1> 
    94                              <1>         mov cx, %3          ; pocet zapisovanych bajtu (=pixelu)
    95                              <1> .bitblt:
    96                              <1>         lodsb               ; nacist bajt z obrazku
    97                              <1>         add si, 3           ; celkove posun o 4 pixely v obrazku 
    98                              <1>         stosb               ; ulozit do obrazove pameti
    99                              <1>         loop .bitblt        ; presunout CX pixelu
   100                              <1>         ret
   101                              <1> %endmacro
   102                              <1> 
   103                              <1> ; nastaveni pocatecni adresy video RAM
   104                              <1> %macro set_video_ram_start 1
   105                              <1>         set_crtc_register START_ADDRESS_HIGH, %1h
   106                              <1>         set_crtc_register START_ADDRESS_LOW, %1l
   107                              <1> %endmacro
   108                              <1> 
   109                              <1> 
   110                              <1> 
   111                              <1> ;-----------------------------------------------------------------------------
   112                              <1> ; podprogramy
   113                              <1> ;-----------------------------------------------------------------------------
   114                              <1> 
   115                              <1> gfx_mode_x:
   116                              <1>         ; Nastaveni registru VGA pro rezim X
   117                              <1>         ; ------------------------------------------------------
   118                              <1>         ; Register name            port    index   13h    mode X
   119                              <1>         ; Miscellaneous Output     0x3C2   N/A     0x63    0xE3
   120                              <1>         ; Memory Mode Register     0x3C4   0x04    0x0E    0x06
   121                              <1>         ; Mode Register            0x3CE   0x05    0x40    0x40
   122                              <1>         ; Miscellaneous Register   0x3CE   0x06    0x05    0x05
   123                              <1>         ; Vertical Total           0x3D4   0x06    0xBF    0x0D
   124                              <1>         ; Overflow Register        0x3D4   0x07    0x1F    0x3E
   125                              <1>         ; Vertical Retrace Start   0x3D4   0x10    0x9C    0xEA
   126                              <1>         ; Vertical Retrace End     0x3D4   0x11    0x8E    0xAC
   127                              <1>         ; Vertical Display End     0x3D4   0x12    0x8F    0xDF
   128                              <1>         ; Underline Location       0x3D4   0x14    0x40    0x00
   129                              <1>         ; Vertical Blank Start     0x3D4   0x15    0x96    0xE7
   130                              <1>         ; Vertical Blank End       0x3D4   0x16    0xB9    0x06
   131                              <1>         ; Mode Control             0x3D4   0x17    0xA3    0xE3 
   132                              <1> 
   133                              <1>         gfx_mode 0x13       ; nastaveni rezimu 320x200 s 256 barvami
    38 00000003 B400                <2>  mov ah, 0
    39 00000005 B013                <2>  mov al, %1
    40 00000007 CD10                <2>  int 0x10
   134                              <1>         grayscale_palette   ; nastaveni palety se stupni sedi
    75 00000009 B81010              <2>  mov ax, 0x1010
    76 0000000C 30DB                <2>  xor bl, bl
    77                              <2> .next_dac:
    78 0000000E 88DD                <2>  mov ch, bl
    79 00000010 D0ED                <2>  shr ch, 1
    80 00000012 D0ED                <2>  shr ch, 1
    81 00000014 88E9                <2>  mov cl, ch
    82 00000016 88EE                <2>  mov dh, ch
    83 00000018 CD10                <2>  int 0x10
    84 0000001A FEC3                <2>  inc bl
    85 0000001C 75F0                <2>  jnz .next_dac
   135                              <1> 
   136                              <1>         ; mod 320x200 bez zretezeni rovin
   137                              <1>         set_sequencer_register MEMORY_MODE_REGISTER, 0x06 ; vypnuti zretezeni + povoleni 256 kB RAM
    45 0000001E BAC403              <2>  mov dx, SEQUENCER_INDEX
    46 00000021 B004                <2>  mov al, %1
    47 00000023 EE                  <2>  out dx, al
    48 00000024 42                  <2>  inc dx
    49 00000025 B006                <2>  mov al, %2
    50 00000027 EE                  <2>  out dx, al
   138                              <1>         set_crtc_register UNDERLINE_LOCATION, 0x00        ; vypnuti double word rezimu
    55 00000028 BAD403              <2>  mov dx, CRTC_INDEX
    56 0000002B B014                <2>  mov al, %1
    57 0000002D EE                  <2>  out dx, al
    58 0000002E 42                  <2>  inc dx
    59 0000002F B000                <2>  mov al, %2
    60 00000031 EE                  <2>  out dx, al
   139                              <1>         set_crtc_register MODE_CONTROL,  0xe3             ; zapnuti bytoveho rezimu
    55 00000032 BAD403              <2>  mov dx, CRTC_INDEX
    56 00000035 B017                <2>  mov al, %1
    57 00000037 EE                  <2>  out dx, al
    58 00000038 42                  <2>  inc dx
    59 00000039 B0E3                <2>  mov al, %2
    60 0000003B EE                  <2>  out dx, al
   140                              <1> 
   141                              <1>         ; prepnuti do 320x240
   142 0000003C BAC403              <1>         mov dx, SEQUENCER_INDEX
   143 0000003F B80001              <1>         mov ax, 0x100       ; synchronni reset (bit cislo 1 je vynulovan)
   144 00000042 EF                  <1>         out dx, ax
   145                              <1> 
   146 00000043 BAC203              <1>         mov dx, MISC_REGISTER
   147 00000046 B0E3                <1>         mov al, 0xe3
   148 00000048 EE                  <1>         out dx, al          ; hodiny 25 MHz obrazova frekvence 60 Hz (nastaveni polarity syncu)
   149                              <1> 
   150 00000049 BAC403              <1>         mov dx, SEQUENCER_INDEX
   151 0000004C B80003              <1>         mov ax, 0x300       ; restart sekvenceru (oba resety jsou zakazane)
   152 0000004F EF                  <1>         out dx, ax
   153                              <1> 
   154 00000050 BAD403              <1>         mov dx, CRTC_INDEX
   155 00000053 B011                <1>         mov al, 0x11        ; Vertical Retrace End registr
   156 00000055 EE                  <1>         out dx, al
   157                              <1> 
   158 00000056 42                  <1>         inc dx
   159 00000057 EC                  <1>         in al, dx           ; cteni hodnoty registru
   160 00000058 247F                <1>         and al, 0x7f        ; vypnout write protect bit (sedmi bit)
   161 0000005A EE                  <1>         out dx, al          ; nyni lze zapisovat do jakehokoli CRTC registru
   162                              <1> 
   163 0000005B BAD403              <1>         mov dx, CRTC_INDEX  ; budou se zapisovat hodnoty CRTC registru
   164 0000005E FC                  <1>         cld                 ; smer prenosu (pro jistotu)
   165 0000005F BE[7700]            <1>         mov si, crtc_values ; tabulka s hodnotami CRTC registru
   166 00000062 B90A00              <1>         mov cx, 10          ; velikost tabulky s hodnotami CRTC registru
   167                              <1> .set_crtc:
   168 00000065 AD                  <1>         lodsw               ; nacteni dvojice: index registru + hodnota registru
   169 00000066 EF                  <1>         out dx, ax          ; zapis do zvoleneho CRTC registru
   170 00000067 E2FC                <1>         loop .set_crtc      ; provest vsech 10 zapisu
   171                              <1> 
   172                              <1> 
   173                              <1> 
   174                              <1> wait_sync:
   175 00000069 BADA03              <1>         mov dx, INPUT_STATUS ; adresa stavoveho registru graficke karty CGA
   176                              <1> .wait_sync_end:
   177 0000006C EC                  <1>         in al, dx           ; precteni hodnoty stavoveho registru
   178 0000006D A808                <1>         test al, V_RETRACE  ; odmaskovat priznak vertikalniho synchronizacniho pulsu
   179 0000006F 75FB                <1>         jnz .wait_sync_end  ; probiha - cekat na konec
   180                              <1> .wait_sync_start:
   181 00000071 EC                  <1>         in al, dx           ; precteni hodnoty stavoveho registru
   182 00000072 A808                <1>         test al, V_RETRACE  ; odmaskovat priznak vertikalniho synchronizacniho pulsu
   183 00000074 74FB                <1>         jz .wait_sync_start ; neprobiha - cekat na zacatek
   184 00000076 C3                  <1>         ret                 ; ok - synchronizacni kurz probiha, lze zapisovat do pameti
   185                              <1> 
   186                              <1> 
   187                              <1> 
   188                              <1> crtc_values:
   189 00000077 060D                <1>         dw 00d06h           ; Vertical Total
   190 00000079 073E                <1>         dw 03e07h           ; Overflow Register
   191 0000007B 0941                <1>         dw 04109h           ; Cell Height (teoreticky nemusime menit)
   192 0000007D 10EA                <1>         dw 0ea10h           ; Vertical Retrace Start
   193 0000007F 11AC                <1>         dw 0ac11h           ; Vertical Retrace End
   194 00000081 12DF                <1>         dw 0df12h           ; Vertical Display End
   195 00000083 1400                <1>         dw 00014h           ; Underline Location
   196 00000085 15E7                <1>         dw 0e715h           ; Vertical Blank Start
   197 00000087 1606                <1>         dw 00616h           ; Vertical Blank End
   198 00000089 17E3                <1>         dw 0e317h           ; Mode Control
   199                              <1> 
   200                              <1> %endif
    22                                  
    23                                  main:
    24                                  
    25 0000008B E875FF                          call gfx_mode_x     ; nastavit rezim X
    26                                  
    27 0000008E 8CC8                            mov ax, cs
    28 00000090 8ED8                            mov ds, ax          ; zajistit, ze bude mozne adresovat cely obrazek
    29                                  
    30 00000092 B800A0                          mov ax, 0xa000      ; video RAM v textovem rezimu
    31 00000095 8EC0                            mov es, ax
    32                                  
    33                                          select_bitplane 1   ; prvni bitplane
    65 00000097 B001                <1>  mov al, %1
    66 00000099 BAC403              <1>  mov dx, SEQUENCER_INDEX
    67 0000009C B402                <1>  mov ah, BITPLANE_SELECTOR
    68 0000009E 86E0                <1>  xchg ah, al
    69 000000A0 EF                  <1>  out dx, ax
    70                              <1> 
    34 000000A1 31C0                            xor ax, ax          ; offset pixelu
    35 000000A3 E86900                          call move_image_part; prenest obrazek
    36                                          wait_key            ; cekani na klavesu
    22 000000A6 31C0                <1>  xor ax, ax
    23 000000A8 CD16                <1>  int 0x16
    37                                  
    38                                          select_bitplane 2   ; druha bitplane
    65 000000AA B002                <1>  mov al, %1
    66 000000AC BAC403              <1>  mov dx, SEQUENCER_INDEX
    67 000000AF B402                <1>  mov ah, BITPLANE_SELECTOR
    68 000000B1 86E0                <1>  xchg ah, al
    69 000000B3 EF                  <1>  out dx, ax
    70                              <1> 
    39 000000B4 B80100                          mov ax, 1
    40 000000B7 E85500                          call move_image_part; prenest obrazek
    41                                          wait_key            ; cekani na klavesu
    22 000000BA 31C0                <1>  xor ax, ax
    23 000000BC CD16                <1>  int 0x16
    42                                  
    43                                          select_bitplane 4   ; treti bitplane
    65 000000BE B004                <1>  mov al, %1
    66 000000C0 BAC403              <1>  mov dx, SEQUENCER_INDEX
    67 000000C3 B402                <1>  mov ah, BITPLANE_SELECTOR
    68 000000C5 86E0                <1>  xchg ah, al
    69 000000C7 EF                  <1>  out dx, ax
    70                              <1> 
    44 000000C8 B80200                          mov ax, 2
    45 000000CB E84100                          call move_image_part; prenest obrazek
    46                                          wait_key            ; cekani na klavesu
    22 000000CE 31C0                <1>  xor ax, ax
    23 000000D0 CD16                <1>  int 0x16
    47                                  
    48                                          select_bitplane 8   ; ctvrta bitplane
    65 000000D2 B008                <1>  mov al, %1
    66 000000D4 BAC403              <1>  mov dx, SEQUENCER_INDEX
    67 000000D7 B402                <1>  mov ah, BITPLANE_SELECTOR
    68 000000D9 86E0                <1>  xchg ah, al
    69 000000DB EF                  <1>  out dx, ax
    70                              <1> 
    49 000000DC B80300                          mov ax, 3
    50 000000DF E82D00                          call move_image_part; prenest obrazek
    51                                          wait_key            ; cekani na klavesu
    22 000000E2 31C0                <1>  xor ax, ax
    23 000000E4 CD16                <1>  int 0x16
    52                                  
    53 000000E6 B92800                          mov cx, 40          ; pocet radku, o ktere budeme scrollovat
    54 000000E9 31DB                            xor bx, bx          ; adresa zacatku vykreslovani
    55                                  
    56                                  opak:
    57 000000EB 83C350                          add bx, 80          ; prechod na dalsi adresu, od ktere se bude vykreslovat
    58 000000EE E878FF                          call wait_sync      ; cekani na sync.
    59                                                              ; zmena adresy
    60                                          set_video_ram_start b
   105                              <1>  set_crtc_register START_ADDRESS_HIGH, %1h
    55 000000F1 BAD403              <2>  mov dx, CRTC_INDEX
    56 000000F4 B00C                <2>  mov al, %1
    57 000000F6 EE                  <2>  out dx, al
    58 000000F7 42                  <2>  inc dx
    59 000000F8 88F8                <2>  mov al, %2
    60 000000FA EE                  <2>  out dx, al
   106                              <1>  set_crtc_register START_ADDRESS_LOW, %1l
    55 000000FB BAD403              <2>  mov dx, CRTC_INDEX
    56 000000FE B00D                <2>  mov al, %1
    57 00000100 EE                  <2>  out dx, al
    58 00000101 42                  <2>  inc dx
    59 00000102 88D8                <2>  mov al, %2
    60 00000104 EE                  <2>  out dx, al
    61 00000105 E2E4                            loop opak
    62                                  
    63                                          wait_key            ; cekani na klavesu
    22 00000107 31C0                <1>  xor ax, ax
    23 00000109 CD16                <1>  int 0x16
    64                                          exit                ; navrat do DOSu
    16 0000010B B44C                <1>  mov ah, 0x4c
    17 0000010D CD21                <1>  int 0x21
    65                                  
    66                                  move_image_part:
    67                                          move_one_bitplane image, 40*80, 320*200/4
    90 0000010F BE[2301]            <1>  mov si, %1
    91 00000112 01C6                <1>  add si, ax
    92 00000114 BF800C              <1>  mov di, %2
    93                              <1> 
    94 00000117 B9803E              <1>  mov cx, %3
    95                              <1> .bitblt:
    96 0000011A AC                  <1>  lodsb
    97 0000011B 83C603              <1>  add si, 3
    98 0000011E AA                  <1>  stosb
    99 0000011F E2F9                <1>  loop .bitblt
   100 00000121 C3                  <1>  ret
    68 00000122 C3                              ret
    69                                  
    70                                  
    71                                  ; pridani binarnich dat s rastrovym obrazkem
    72                                  image:
    73 00000123 <bin FA01h>                 incbin "image_320x200.bin"
