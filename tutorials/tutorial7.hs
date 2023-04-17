{-
data Stack a = Dummy

stackPush :: Stack a -> a -> Stack a
stackPush = undefined

stackPop :: Stack a -> Maybe (Stack a, a)
stackPop = undefined

stackSize :: Stack a -> Int
stackSize = undefined

stackIsEmpty :: Stack a -> Bool
stackIsEmpty = undefined

addFromList :: Stack a -> [a] -> Stack a
addFromList = undefined

toList :: Stack a -> [a]
toList = undefined

property1 stack
  | stackIsEmpty stack = not (isJust popped stack)
  | otherwise = isJust popped
  where
    popped = stackPop
    isJust Nothing = False
    isJust (Just _) = True

property2 stack a = Just a == extractElement poppedElement
  where
    poppedElement = stackPop (stackPush stack a)

    extractElement :: Maybe (Stack a, a) -> Maybe a
    extractElement Nothing = Nothing
    extractElement (Just (_, a)) = Just a

property3 stack = stackIsEmpty stack == (stackSize stack == 0)

-}

meanLinear :: Fractional a => [a] -> a
meanLinear []       = undefined
meanLinear [x]      = x
meanLinear (x : xs) = (x + n * average) / (n + 1)
  where
    average = meanLinear xs
    n       = fromIntegral (length xs)


{- 
 - __Iteration invariant:__
 -
 - meanTail n avg xs = (Something that should be the average of xs ++
 - (previous list))
 -
 - h_meanTail n avg xs = ((n * avg) + sum(xs)) / (n + length xs)
 -
 - h_meanTail 0 0 xs = (0 * 0 + sum xs) / (0 + length xs)
 -                   = (sum xs) / (length xs)
 -                   = mean xs
 -}

meanTail :: Fractional a => [a] -> a
meanTail [] = undefined
meanTail xs = h_meanTail 0 0 xs
  where
    h_meanTail :: Fractional a => a -> a -> [a] -> a
    h_meanTail _ avg []     = avg
    h_meanTail n avg (x:xs) = h_meanTail (n + 1) ((x + n * avg) / (n + 1)) xs

