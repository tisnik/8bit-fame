for i = 0 to 10
    select case i
        case 1, 3, 5, 7, 9
            print i, "odd"
        case 2, 4, 6, 8, 10
            print i, "even"
        case else
            print i, "something else"
    end select
next
