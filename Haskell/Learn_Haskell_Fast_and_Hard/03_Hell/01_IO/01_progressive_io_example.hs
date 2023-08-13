toList :: String -> [Integer]
toList input = read ("[" ++ input ++ "]")

main = do
    putStrLn ""
    input <- getLine
    print $ sum (toList input)