module Blockus (tile) where

-- import Data.List ( intercalate )
-- Do not modify anything above this line.
--
-- This question is worth 10 POINTS

{--
Implement the tiling from Q10 in the Written Assignment.

Implement function
	tile :: Int -> [[Int]]

which will construct the tiling of a board 2^k x 2^k for the given k.
If k is less than zero, return an empty list.
In the output, each V3 piece should be assigned a unique positive non-zero number.
The upper left corner should be assigned a 0.
For example, the tiling for a 4x4 Board might look like this:

0 1 4 4
1 1 2 4
5 2 2 3
5 5 3 3

So,
    tile 2 == [[0, 1, 4, 4]
              ,[1, 1, 2, 4]
              ,[5, 2, 2, 3]
              ,[5, 5, 3, 3]]

Note that this solution is not unique. Any valid solution will be accepted.

--}

powsOfFour = 0 : map (round . (^^) 4) [0..]

tile :: Int -> [[Int]]
tile n 
  | n < 0 = [] 
  | otherwise = map (map (\y -> if y == -1 then 0 else y)) (htile n 1)


htile :: Int -> Int -> [[Int]]
htile 0 1   = [[0]]
htile 1 acc = [[-1, acc], [acc, acc]]
htile size acc = combine topLeft topRight bottomLeft bottomRight (acc + 4 * sum (take (size - 1) powsOfFour))
  where
    topLeft     = htile (size - 1) (acc + 0 * sum (take size powsOfFour))
    topRight    = flipx (htile (size - 1) (acc + 1 * sum (take size powsOfFour)))
    bottomLeft  = flipy (htile (size - 1) (acc + 2 * sum (take size powsOfFour)))
    bottomRight = htile (size - 1) (acc + 3 * sum (take size powsOfFour))

-- flips the grid in the x direction
flipx :: [[Int]] -> [[Int]]
flipx = reverse

-- flips the grid in the y direction
flipy :: [[Int]] -> [[Int]]
flipy [last]     = [reverse last]
flipy (row:rest) = reverse row : flipy rest

-- combines the 4 grids into 1
combine :: [[Int]] -> [[Int]] -> [[Int]] -> [[Int]] -> Int -> [[Int]]
combine xs ys zs ws acc = insertPiece combined newID
  where
    insertPiece grid id = (-1 : drop 1 (head insertedGraph)) : tail insertedGraph
      where
        insertedGraph = map (map (\y -> if y == -1 then id else y)) grid
    combined = zipWith (++) xs ys ++ zipWith (++) zs ws
    newID
      | acc < 5   = 0
      | otherwise = acc

-- prettyPrint :: [[Int]] -> IO ()
-- prettyPrint matrix = mapM_ (putStrLn . showRow) matrix
--   where
--     showRow row = "[" ++ intercalate ", " (map showWithoutQuotes row) ++ "]"
--     showWithoutQuotes n = replicate (maxWidth - length str) ' ' ++ str
--       where
--         str = show n
--     maxWidth = maximum (map (length . show) (concat matrix))

