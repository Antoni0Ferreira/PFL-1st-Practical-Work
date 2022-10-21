module Main where

import Data.Char (isDigit, digitToInt, isLetter)
import Data.Maybe (fromJust)

import Sum
import Prod
import Deriv
import Poli
import Moni
import Vars
import Tree

a = Moni 2 [('x', 3)]
b = Moni (-5) [('x', 3)]
c = Moni 5 [('y', 2)]
d = Moni 0 [('x', 2)]
e = Moni 1 [('x', 1)]
f = Moni 3 [('x', 1)]
g = Moni 2 [('x', 0)]
h = Moni 2 [('x', 2), ('y', 1), ('x', 3)]

poliEx = [a, b, c, d, e, f, g]
poliEx2 = parsePoli "2*x*y^2 + 3*x"
poliEx3 = parsePoli "0*x + y^2 + 5*x"
poliEx4 = parsePoli "2*y^4 + 3*y^2 + 10*y^2 - 15"


main :: IO ()
main = do
    putStrLn "\nInstructions:\nTo test the functions and examples manually, load Main.hs in ghci\nTo run the tests suites you can do `cabal test`"
