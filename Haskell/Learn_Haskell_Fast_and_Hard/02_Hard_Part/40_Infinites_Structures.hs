numbers :: [Integer]
numbers = 0:map (1+) numbers

take' n [] = []
take' 0 l = []
take' n (h:t) = h:take' (n-1) t

main = print $ take' 10 numbers