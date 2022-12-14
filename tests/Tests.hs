import Test.QuickCheck
import Deriv
import Moni
import Poli
import Prod
import Tree
import Vars
import Sum

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

-- Tests Polinomial Parsing
prop_poliParsing1 = poliEx2 == [Moni 2 [('x', 1),('y', 2)], Moni 3 [('x', 1)]]
prop_poliParsing2 = poliEx3 == [Moni 1 [('y', 2)], Moni 5 [('x', 1)]]
prop_poliParsing3 = poliEx4 == [Moni 2 [('y', 4)], Moni 13 [('y', 2)], Moni (-15) [('_', 0)]]

-- Tests polinomial representation
prop_tellPoli = tellPoli poliEx == "2*x^3 + (-5)*x^3 + 5*y^2 + 3*x + x + 2" 

-- Tests polinomial normalization

prop_normalizePoli1 = tellPoli (normalizePoli poliEx) == "(-3)*x^3 + 5*y^2 + 4*x + 2"
prop_normalizePoli2 = tellPoli poliEx2 == "2*x*y^2 + 3*x"


-- Tests Polinomial sum
prop_addPoli1  = tellPoli (sumPoli poliEx2 poliEx3) == poli_res
    where poli_res = "2*x*y^2 + y^2 + 8*x"

prop_addPoli2  = tellPoli (sumPoli poliEx poliEx2) == poli_res
    where poli_res = "(-3)*x^3 + 5*y^2 + 2*x*y^2 + 7*x + 2"

prop_addPoli3  = tellPoli (sumPoli poliEx poliEx3) == poli_res
    where poli_res = "(-3)*x^3 + 6*y^2 + 9*x + 2"

-- Tests Polinomial multiplication

prop_multPoli1 = tellPoli (normalizePoli (prodPoli poliEx poliEx2)) == poli_res
    where poli_res = "10*x*y^4 + (-6)*x^4*y^2 + (-9)*x^4 + 15*x*y^2 + 6*x^2*y^2 + 4*x*y^2 + 2*x^2*y^2 + 12*x^2 + 6*x"

prop_multPoli2 = tellPoli (normalizePoli (prodPoli poliEx2 poliEx3)) == poli_res
    where poli_res = "2*x*y^4 + 10*x^2*y^2 + 3*x*y^2 + 15*x^2"

prop_multPoli3 = tellPoli (normalizePoli (prodPoli poliEx poliEx3)) == poli_res
    where poli_res = "5*y^4 + (-15)*x^4 + (-3)*x^3*y^2 + 28*x*y^2 + 2*y^2 + x*y^2 + 20*x^2 + 10*x"

-- Tests Polinomial Derivation

prop_derivation1 = tellPoli (derivPoli 'x' poliEx) == poli_res
    where poli_res = "(-9)*x^2 + 4"

prop_derivation2 = tellPoli (derivPoli 'y' poliEx) == poli_res
    where poli_res = "10*y"

prop_derivation3 = tellPoli (derivPoli 'x' poliEx2) == poli_res
    where poli_res = "2*y^2 + 3"

prop_derivation4 = tellPoli (derivPoli 'y' poliEx2) == poli_res
    where poli_res = "4*x*y"

prop_derivation5 = tellPoli (derivPoli 'y' poliEx3) == poli_res
    where poli_res = "2*y"

prop_derivation6 = tellPoli (derivPoli 'z' poliEx3) == poli_res
    where poli_res = "0"

-- Tests for operation order
prop_operationOrder = tellPoli p1 == "10*x*y + 2*x" -- If the operation order was wrong the sum would be made before the multiplication
    where p1 = parsePoli "2*x + 2*x * 5*y"


main = do
    quickCheck prop_poliParsing1
    quickCheck prop_poliParsing2
    quickCheck prop_poliParsing3
    quickCheck prop_tellPoli
    quickCheck prop_normalizePoli1
    quickCheck prop_normalizePoli2
    quickCheck prop_addPoli1  
    quickCheck prop_addPoli2
    quickCheck prop_addPoli3
    quickCheck prop_multPoli1
    quickCheck prop_multPoli2
    quickCheck prop_multPoli3
    quickCheck prop_derivation1
    quickCheck prop_derivation2
    quickCheck prop_derivation3
    quickCheck prop_derivation4
    quickCheck prop_derivation5
    quickCheck prop_derivation6
    quickCheck prop_operationOrder