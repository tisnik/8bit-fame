' VYPOCET FAKTORIALU
' UPRAVA PRO TURBO-BASIC XL
' POUZITI KONSTANT %0 a %1
' ----------------------------
 
fact%=-1

for n=0 to 20
  exec factorial
  print n,fact%
next n

do
loop

' vypocet faktorialu
proc factorial
  fact%=1.0
  for i=n to 1 step -1
    fact%=fact%*i
  next i
endproc 
