

rev :: [a] -> [a]
rev = h_rev []
  where
    {-
     - h_rev ans xs = reverse (xs) ++ ans
     -
     - base case:
     -      h_rev ans [] = reverse([]) ++ ans
     -
     - recursive case:
     -      h_rev ans (x:xs) = h_rev (x:ans) xs
     -      RHS = reverse(xs) ++ (x:ans)
     -      LHS = reverse(x:xs) ++ ans
     -          = reverse(xs) ++ [x] ++ [ans]
     -          = reverse(xs) ++ (x:ans)
     -          = RHS
     -
     - h_rev [] xs = reverse (xs) ++ [] = reverse xs
     - -}
    h_rev :: [a] -> [a] -> [a]
    h_rev ans [] = ans
    h_rev ans (x:xs) = h_rev (x:ans) xs
    -- by grabbing last element of list (inefficient)
    -- h_rev ans list = h_rev (ans ++ [last list]) (init list)



data Tree a = Empty | Node (Tree a) a (Tree a)

find :: Ord a => a -> Tree a -> Maybe a
find a Empty = Nothing
find a (Node ltree x rtree)
  | a < x     = find a ltree
  | a > x     = find a rtree
  | otherwise = Just a

insert :: Ord a => a -> Tree a -> Tree a
insert a Empty = Node Empty a Empty
insert a tree@(Node ltree x rtree)
  | a < x = Node (insert a ltree) x rtree
  | a > x = Node ltree x (insert a rtree)
  | otherwise = tree

mirror :: Ord a => Tree a -> Tree a
mirror Empty = Empty
mirror (Node ltree x rtree) = Node (mirror rtree) x (mirror ltree)



factorial :: Integral a => a -> a
factorial = h_factorial 1
  where
    h_factorial :: Integral a => a -> a -> a
    {- 
     - h_factorial ans n = ans * n!
     -
     - Base cae:
     -      h_factorial ans 0 = ans * 0!
     -      LHS = h_factorial ans 0 = ans * 1 = ans * 0! = RHS
     -
     - Recursive case:
     -      h_factorial ans n = ans * n!
     -      LHS: h_factorial (ans * n) (n - 1)
     -      = h_factorial (ans * n) * (n - 1)!
     -      = ans * n! = RHS
     -
     - -}
    h_factorial ans 0 = ans
    h_factorial ans n = h_factorial (ans * n) (n - 1)

