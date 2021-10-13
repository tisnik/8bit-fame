' Použito v článku
'
' Small Basic: moderní reinkarnace BASICu určená pro výuku programování
' https://www.root.cz/clanky/small-basic-moderni-reinkarnace-basicu-urcena-pro-vyuku-programovani/

i = 1

LOOP:
    TextWindow.WriteLine(i)
    i = i + 1
    if i <= 10 then
        goto LOOP
    endif
