for y = 0 to 400
    for x = 0 to 400
        c = int(x*x/20+y*y/20)
        while c > 15
            c = c - 16
        wend
        color c
        gfx_pixel x, y
    next
next
