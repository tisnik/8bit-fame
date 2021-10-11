i = 1

LOOP:
    TextWindow.WriteLine(i)
    i = i + 1
    if i <= 10 then
        goto LOOP
    endif
