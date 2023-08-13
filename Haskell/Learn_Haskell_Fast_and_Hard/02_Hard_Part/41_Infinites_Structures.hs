data BinTree a = Empty
                 | Node a (BinTree a) (BinTree a)
                  deriving (Eq,Ord)

instance (Show a) => Show (BinTree a) where
  show t = "< " ++ replace '\n' "\n: " (treeshow "" t)
    where
    treeshow pref Empty = ""
    treeshow pref (Node x Empty Empty) =
                  (pshow pref x)
    treeshow pref (Node x left Empty) =
                  (pshow pref x) ++ "\n" ++
                  (showSon pref "`-- " "   " left)
    treeshow pref (Node x Empty right) =
                  (pshow pref x) ++ "\n" ++
                  (showSon pref "`-- " "   " right)
    treeshow pref (Node x left right) =
                  (pshow pref x) ++ "\n" ++
                  (showSon pref "|-- " "|  " left) ++ "\n" ++
                  (showSon pref "`-- " "   " right)
    showSon pref before next t =
                  pref ++ before ++ treeshow (pref ++ next) t
    pshow pref x = replace '\n' ("\n"++pref) (show x)
    replace c new string =
      concatMap (change c new) string
      where
          change c new x
              | x == c = new
              | otherwise = x:[]

treeFromList :: (Ord a) => [a] -> BinTree a
treeFromList [] = Empty
treeFromList (h:t) = Node h (treeFromList (filter (<h) t))
                            (treeFromList (filter (>h) t))

nullTree = Node 0 nullTree nullTree

treeTakeDepth _ Empty = Empty
treeTakeDepth 0 _ = Empty
treeTakeDepth n (Node x left right) = let
    nl = treeTakeDepth (n - 1) left
    nr = treeTakeDepth (n - 1) right
    in
        Node x nl nr

iTree = Node 0 (dec iTree) (inc iTree)
    where
        dec (Node x l r) = Node (x - 1) (dec l) (dec r)
        inc (Node x l r) = Node (x - 1) (inc l) (inc r)
        
treeMap :: (a -> b) -> BinTree a -> BinTree b
treeMap f Empty = Empty
treeMap f (Node x left right) = Node (f x) 
                                     (treeMap f left) 
                                     (treeMap f right)

infTreeTwo :: BinTree Int
infTreeTwo = Node 0 (treeMap (\x -> x-1) infTreeTwo) 
                    (treeMap (\x -> x+1) infTreeTwo) 
                    
main = print $ treeTakeDepth 4 infTreeTwo