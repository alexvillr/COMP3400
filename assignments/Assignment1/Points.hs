module Points (closest, npoints, manhattan) where

import           Prelude hiding (liftA2, liftM2, pure, return, sequence,
                          sequenceA, sequenceM, (*>), (<*>), (>>), (>>=))
-- Do NOT modify anything above this line.
-- Do NOT import anything.

{--
You are given N lists of integer coordinates. Without using list comprehensions
, do-notation or any functions from Control.Applicative and Control.Monad, 
implement an algorithm that constructs all possible N-dimensional points from 
the given coordinates and finds Manhattan distance between two closest distinct 
points.

The Manhattan distance of two N-dimensional points is calculated as follows:
    manhattan [x1, x2, x3, ..., xn] [y1, y2, y3, ..., yn] 
    = abs (x1 - y1) + abs (x2 - y2) + ... + abs (xn - yn)

TASK 1: Write a function
    manhattan :: [Int] -> [Int] -> Int
that returns the Manhattan distance of two coordinates represented by integer
lists.
    ghci> manhattan [0, 3, 1] [0, 2, 1] 
    1

TASK 2: Write a function
    npoints :: [[Int]] -> [[Int]]
that generates all possible points constuctable from its first input. That is,
supposing
    npoints [x1s, x2s, ..., xks] = ans
then [x1, x2, ..., xk] in ans iff x1 in x1s, x2 in x2s, ..., and xk in xks.

For example, 
    ghci> npoints [[0, 1], [2, 3], [1, 3]]
    [[0,2,1],[0,2,3],[0,3,1],[0,3,3],[1,2,1],[1,2,3],[1,3,1],[1,3,3]]

TASK 3: Write a function
    closest :: [[Int]] -> Int
that returns the least Manhattan distance among all the input points.

For example:
    ghci> closest $ npoints [[0, 1], [2, 3], [1, 3]]
    1

Because [0,3,1] and [0,2,1] have Manhattan distance 1.

In order to make this function total, we let
    closest xs = -1
when len xs < 2.

Note: the order of points does not matter, but the order of coordinates in each 
point does. The i-th coordinate of a point should always come from the i-th 
list in the input.
--}

manhattan :: [Int] -> [Int] -> Int
manhattan [x] [y]       = abs (x - y)
manhattan (x:xs) (y:ys) = abs (x - y) + manhattan xs ys

npoints :: [[Int]] -> [[Int]]
npoints [] = [[]]
npoints (xs:rest) = concatMap (\x -> map (x:) (npoints rest)) xs

closest :: [[Int]] -> Int
closest xs 
    | length xs < 2 = -1
    | otherwise     = minimum (distances xs)

distances :: [[Int]] -> [Int]
distances [] = []
distances (x:xs) = comparePoints x xs ++ distances xs

comparePoints :: [Int] -> [[Int]] -> [Int]
comparePoints _ [] = []
comparePoints point1 (point2:points)
    | point1 == point2 = comparePoints point1 points
    | otherwise        = (:) (manhattan point1 point2) (comparePoints point1 points)

