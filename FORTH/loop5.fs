0  constant min_counter
10 constant max_counter
1  constant increment

: pocitadlo
    min_counter
    begin
        dup max_counter <
    while
        increment +
        dup . cr
    repeat
    drop
;

pocitadlo
