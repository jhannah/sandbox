# Very neato solve with Raku:
# https://fosstodon.org/@sumankhanal/109302264883388370

# Can I do it in sympy?

# Construct
#
#  a   /   b = div1
#  +       +
#  c   /   d = div2
#  ||      ||
# sum1     sum2

# pip3 install sympy
import sympy as sym
def my_four_numbers(div1, div2, sum1, sum2):
  a,b,c,d = sym.symbols('a,b,c,d')
  eq1 = sym.Eq(a/b,div1)
  eq2 = sym.Eq(c/d,div2)
  eq3 = sym.Eq(a+c,sum1)
  eq4 = sym.Eq(b+d,sum2)
  result = sym.solve([eq1,eq2,eq3,eq4],(a,b,c,d))
  print(result)

my_four_numbers(23,13,222,14)
# {a: 92, b: 4, c: 130, d: 10}

