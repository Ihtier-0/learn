accumSum n l =
    if l == []
    then n
    else let h = head l
             t = tail l
         in if even h
                then accumSum (n+h) t
                else accumSum n t

evenSum :: Integral a => [a] -> a
evenSum l = accumSum 0 l