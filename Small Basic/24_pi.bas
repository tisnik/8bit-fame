' Použito v článku
'
' Small Basic: moderní reinkarnace BASICu určená pro výuku programování
' https://www.root.cz/clanky/small-basic-moderni-reinkarnace-basicu-urcena-pro-vyuku-programovani/

' *****************************
' Výpočet hodnoty konstanty PI
' postavený na smyčce
' typu WHILE
' 
' Uprava pro Small Basic
' *****************************
'
'
N=1
while N <= 2000
   computePi()
   TextWindow.Writeline("N=" + N + " PI=" + PI)
   N = N * 2
endwhile

sub computePi
    PI = 4
    J = 3
    while J <= N + 2
      PI=PI*(J-1)/J*(J+1)/J
      J=J+2
    endwhile
endsub
