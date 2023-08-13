--type Name  = String
data Name = NameConstr String

--type Color = String
data Color = ColorConstr String

showInfos :: Name -> Color -> String
showInfos (NameConstr name) (ColorConstr color) =
    "Name: " ++ name
    ++ ", Color: " ++ color

-- name :: Name
name = NameConstr "Ihtier"

-- color :: Color
color = ColorConstr "Red"

main = putStrLn $ showInfos name color