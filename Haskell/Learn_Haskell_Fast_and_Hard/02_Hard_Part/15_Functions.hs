import Data.List (foldl')

evenSum1 l = mysum 0 (filter even l)
    where
        mysum n [] = n
        mysum n (h:t) = mysum (n + h) t

evenSum2 l = foldl' mysum 0 (filter even l)
    where mysum acc value = acc + value
    
evenSum3 l = foldl' (\x y -> x + y) 0 (filter even l)

evenSum4 l = foldl' (+) 0 (filter even l)