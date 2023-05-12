module Sandbox where

-- Goal increment Just 1 --> Just 2

minc :: Maybe Integer -> Maybe Integer
minc mx = (+1) <$> mx
-- minc (Just x) = Just $ x + 1
-- minc _ = Nothing

madd :: Maybe Integer -> Maybe Integer -> Maybe Integer
madd mx my = 
    mx >>= \x ->
    my >>= \y ->
    return $ x + y

madd' :: Maybe Integer -> Maybe Integer -> Maybe Integer
madd' mx my = do
    x <- mx
    y <- my
    return $ x + y

