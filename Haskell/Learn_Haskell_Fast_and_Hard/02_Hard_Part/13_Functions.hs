evenSum l = accumSum 0 l
    where
        accumSum n [] = n
        accumSum n (h:t) = 
            if even h
                then accumSum (n + h) t
                else accumSum n t