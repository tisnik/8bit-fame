     1                                  ; Otestovani, jestli je k dispozici matematický koprocesor.
     2                                  ; Kompatibilni s cipem Intel 80286
     3                                  ;-----------------------------------------------------------------------------
     4                                  
     5                                  BITS 16         ; 16bitovy vystup pro DOS
     6                                  
     7                                  ;-----------------------------------------------------------------------------
     8                                  
     9                                  ; ukonceni procesu a navrat do DOSu
    10                                  %macro exit 0
    11                                          ret
    12                                  %endmacro
    13                                  
    14                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    15                                  %macro wait_key 0
    16                                          xor     ax, ax
    17                                          int     0x16
    18                                  %endmacro
    19                                  
    20                                  ; tisk retezce na obrazovku
    21                                  %macro print 1
    22                                          mov     dx, %1
    23                                          mov     ah, 9
    24                                          int     0x21
    25                                  %endmacro
    26                                  
    27                                  ;-----------------------------------------------------------------------------
    28                                  org  0x100                         ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    29                                  
    30                                  start:
    31 00000000 EB00                            jmp main                   ; skok na zacatek kodu
    32                                  
    33                                  main:
    34 00000002 DBE3                            fninit
    35 00000004 B96400                          mov cx, 100                ; nechame koprocesor "vydechnout"
    36                                  
    37                                   .wait:
    38 00000007 E2FE                            loop .wait
    39                                  
    40 00000009 D93E[3B00]                      fnstcw word [test_word]    ; ulozeni ridiciho slova
    41 0000000D 813E[3B00]FF03                  cmp word [test_word], 0x03FF  ; vychozi bitova pole ukladana cipem 8087
    42 00000013 7411                            je  fpu_8087_present
    43                                  
    44 00000015 813E[3B00]7F03                  cmp word [test_word], 0x037F  ; vychozi bitova pole ukladana cipem 80287 a vyssim
    45 0000001B 7412                            je  fpu_present
    46                                  
    47                                          print fpu_not_present_message
    22 0000001D BA[8400]            <1>  mov dx, %1
    23 00000020 B409                <1>  mov ah, 9
    24 00000022 CD21                <1>  int 0x21
    48 00000024 EB10                            jmp end
    49                                  fpu_8087_present:
    50                                          print fpu_8087_present_message
    22 00000026 BA[3D00]            <1>  mov dx, %1
    23 00000029 B409                <1>  mov ah, 9
    24 0000002B CD21                <1>  int 0x21
    51 0000002D EB07                            jmp end
    52                                  fpu_present:
    53                                          print fpu_present_message
    22 0000002F BA[6000]            <1>  mov dx, %1
    23 00000032 B409                <1>  mov ah, 9
    24 00000034 CD21                <1>  int 0x21
    54                                  end:
    55                                          wait_key                   ; cekani na stisk klavesy
    16 00000036 31C0                <1>  xor ax, ax
    17 00000038 CD16                <1>  int 0x16
    56                                          exit                       ; navrat do DOSu
    11 0000003A C3                  <1>  ret
    57                                  
    58                                  ; datova cast
    59 0000003B 0000                    test_word: dw 0
    60                                  
    61                                  fpu_8087_present_message:
    62 0000003D 4D61746820636F7072-         db "Math coprocessor 8087 is present", 0x0a, 0x0d, "$"
    62 00000046 6F636573736F722038-
    62 0000004F 303837206973207072-
    62 00000058 6573656E740A0D24   
    63                                  
    64                                  fpu_present_message:
    65 00000060 4D61746820636F7072-         db "Math coprocessor >8087 is present", 0x0a, 0x0d, "$"
    65 00000069 6F636573736F72203E-
    65 00000072 383038372069732070-
    65 0000007B 726573656E740A0D24 
    66                                  
    67                                  fpu_not_present_message:
    68 00000084 4D61746820636F7072-         db "Math coprocessor is NOT present", 0x0a, 0x0d, "$"
    68 0000008D 6F636573736F722069-
    68 00000096 73204E4F5420707265-
    68 0000009F 73656E740A0D24     
