' Použito v článku
'
' Small Basic: moderní reinkarnace BASICu určená pro výuku programování
' https://www.root.cz/clanky/small-basic-moderni-reinkarnace-basicu-urcena-pro-vyuku-programovani/

limit = 2
for i = 0 to limit step 0.7
    TextWindow.WriteLine(i + " catching up " + limit)
    limit = limit + 0.6
endfor
