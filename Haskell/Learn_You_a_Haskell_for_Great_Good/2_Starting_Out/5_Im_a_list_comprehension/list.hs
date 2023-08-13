boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]