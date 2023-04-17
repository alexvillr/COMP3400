module Tut05Ans where

rev :: [a] -> [a]
rev = hRev []

hRev :: [a] -> [a] -> [a]
hRev ans [] = ans
hRev ans (x:xs) = hRev (x:ans) xs
{-
Iteration invariant: hRev ans xs = reverse xs ++ ans

Bound value for hRev ans xs = length xs
-}

data Tree a = Empty | Node (Tree a) a (Tree a) deriving (Show)

-- inserts an element into a bst
insert :: Ord a => a -> Tree a -> Tree a
insert a Empty = Node Empty a Empty
insert a (Node left val right)
    | a < val   = Node (insert a left) val right
    | a > val   = Node left val (insert a right)
    | otherwise = Node left a right

-- finds an element in a bst
find :: Ord a => a -> Tree a -> Maybe a
find _ Empty = Nothing
find a (Node left val right)
    | a < val   = find a left
    | a > val   = find a right
    | otherwise = Just a

-- mirror image of a tree
mirror :: Tree a -> Tree a
mirror Empty = Empty
mirror (Node left a right) = Node (mirror right) a (mirror left)
