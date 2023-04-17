module PrincipalType (f1, f2, f3, f4, f5, f5_inv) where
-- Do NOT modify anything above this line.
-- Do NOT import anything.

{--
Implement functions with the following types.
The functions should be total and should not contain 'undefined' or 'error'.
--}

f1 :: (a -> b, a) -> b
f1 (fn, a) = fn a

f2 :: a -> (b, c) -> b
f2 _ (b, _) = b

f3 :: (a -> a) -> a -> [a]
f3 fn a = [fn a]

f4 :: (b -> r) -> (a -> b) -> (a -> r)
f4 = (.)

f5 :: ((a, b, c) -> d) -> a -> b -> c -> d
f5 fn a b c = fn (a, b, c)

f5_inv ::  (a -> b -> c -> d) -> (a, b, c) -> d
f5_inv fn (a, b, c)= fn a b c
