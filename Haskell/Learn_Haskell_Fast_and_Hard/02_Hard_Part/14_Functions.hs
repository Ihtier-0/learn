evenSum :: Integral a => [a] -> a
evenSum = accumSum 0
    where 
        accumSum n [] = n
        accumSum n (h:t) =
            if even h
                then accumSum (h + n) t
                else accumSum n t