: factorial
    1
    swap
    1 +
    1
    do
        i *
    loop
;

: test-factorial
    21
    1
    do
        i dup . 
        factorial . cr
    loop
;

test-factorial
