: factorial
    dup 0= if
        drop 1
    else
        dup 1 - recurse *
    then
;

10 factorial . cr
