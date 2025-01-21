     1                                  ; Otestovani, jestli je nainstalovan matematicky koprocesor.
     2                                  ; Kompatibilni i s cipem Intel 80286
     3                                  ;-----------------------------------------------------------------------------
     4                                  
     5                                  BITS 16         ; 16bitovy vystup pro DOS
     6                                  CPU  286        ; specifikace pouziteho instrukcniho souboru
     7                                  
     8                                  ;-----------------------------------------------------------------------------
     9                                  
    10                                  ; ukonceni procesu a navrat do DOSu
    11                                  %macro exit 0
    12                                          ret
    13                                  %endmacro
    14                                  
    15                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    16                                  %macro wait_key 0
    17                                          xor     ax, ax
    18                                          int     0x16
    19                                  %endmacro
    20                                  
    21                                  ; tisk retezce na obrazovku
    22                                  %macro print 1
    23                                          mov     dx, %1
    24                                          mov     ah, 9
    25                                          int     0x21
    26                                  %endmacro
    27                                  
    28                                  ;-----------------------------------------------------------------------------
    29                                  org  0x100                     ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    30                                  
    31                                  start:
    32 00000000 0F01E0                          smsw ax                    ; prenos MSW do registru AX
    33 00000003 A90400                          test ax, 0x4               ; test tretiho nejnizsiho bitu MSW (EM)
    34                                  
    35 00000006 7409                            jz fpu_present             ; nulovy bit? -> 80287 je nainstalovan
    36                                          print fpu_not_present_message  ; nenulovy bit? -> koprocesor chybi
    23 00000008 BA[3200]            <1>  mov dx, %1
    24 0000000B B409                <1>  mov ah, 9
    25 0000000D CD21                <1>  int 0x21
    37 0000000F EB07                            jmp end
    38                                  fpu_present:
    39                                          print fpu_present_message
    23 00000011 BA[1D00]            <1>  mov dx, %1
    24 00000014 B409                <1>  mov ah, 9
    25 00000016 CD21                <1>  int 0x21
    40                                  end:
    41                                          wait_key                   ; cekani na stisk klavesy
    17 00000018 31C0                <1>  xor ax, ax
    18 0000001A CD16                <1>  int 0x16
    42                                          exit                       ; navrat do DOSu
    12 0000001C C3                  <1>  ret
    43                                  
    44                                  ; datova cast
    45                                  fpu_present_message:
    46 0000001D 465020756E69742069-         db "FP unit is present", 0x0a, 0x0d, "$"
    46 00000026 732070726573656E74-
    46 0000002F 0A0D24             
    47                                  
    48                                  fpu_not_present_message:
    49 00000032 465020756E69742069-         db "FP unit is NOT present", 0x0a, 0x0d, "$"
    49 0000003B 73204E4F5420707265-
    49 00000044 73656E740A0D24     
