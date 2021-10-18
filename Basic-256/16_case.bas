rem Rozhodovací konstrukce case
rem Úprava pro Basic-256

print "x = "
input x

begin case
    case x < 0
        print "Negative value"
    case x > 0
        print "Positive value"
    else
        print "Zero"
endcase
