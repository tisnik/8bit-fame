: factorial
    dup 0= if
        drop 1
    else
        dup 1 - factorial *
    then
;

10 factorial . cr
