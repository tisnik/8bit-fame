REM *****************************
REM
REM Výpočet hodnoty konstanty PI
REM postavený na smyčce
REM typu WHILE-WEND.
REM 
rem Úprava pro EndBASIC
REM
REM *****************************



n=1
while n<=2000
   gosub @calc_pi
   print n,pi_approx
   n=n*2
wend 
end

rem
rem Subrutina pro vypocet pi
rem 
@calc_pi
pi_approx=4.0
j=3
while j<=n+2
  pi_approx=pi_approx*(j-1)/j*(j+1)/j
  j=j+2
wend 
return
