rem *****************************
rem
rem Výpočet konstanty Pi.
rem 
rem Uprava pro EndBASIC
rem 
rem *****************************



n=1
for i=1 to 10
  gosub @calc_pi
  print i,n,pi_approx
  n=n*2
next
end

@calc_pi
rem 
rem Subrutina pro výpočet Pi
rem 
pi_approx=4.0
for j=3 to n+2 step 2
    pi_approx=pi_approx*(j-1)/j*(j+1)/j
next
return 
