import Variance (variance)
import Test.QuickCheck (quickCheck)

-- Var(X + c) = Var(X), where c is some constant.
property1 :: IO()
property1 = quickCheck $ \a xs -> null xs || abs (variance (map (+ a) xs) - variance xs) < 10**(-1)

-- Var(aX) = a^2 * Var(X), where a is some constant.
property2 :: IO()
property2 = quickCheck $ \a xs -> null xs || abs (variance (map (a *) xs) - ((a ** 2) * variance xs)) < 10**(-1)

-- Var(aX + b) = a^2 * Var(X), the result of the previous two properties combined.
property3 :: IO()
property3 = quickCheck $ \a b xs -> null xs || abs (variance (map (\x -> a * x + b) xs) - ((a ** 2) * variance xs)) < 10**(-1)