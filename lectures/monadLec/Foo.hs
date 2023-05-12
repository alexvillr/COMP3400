module Foo where

data Expr = Val Integer | Div Expr Expr

eval :: Expr -> Maybe Integer
eval (Val x) = Just x
eval (Div ex1 ex2) = do
    x <- eval ex1
    y <- eval ex2
    if y == 0 then
        Nothing
    else
        return $ div x y
