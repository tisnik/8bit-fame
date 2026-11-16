: sgn
  dup
  0< if
     drop
     -1
  else
     0= if
       0
     else
       1
     then
  then
;

100 sgn . cr
-100 sgn . cr
0 sgn . cr
