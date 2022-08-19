# What is the value of A + B + C + D + E + F + G given that
# A + B = C + 1
# B + C = D - 1
# C + D = E + 1
# D + E = F - 1
# E + F = G + 1
# F + G = A - 1
# G + A = B + 1
# pip3 install sympy

import sympy as sym
a,b,c,d,e,f,g = sym.symbols('a,b,c,d,e,f,g')
eq1 = sym.Eq(a+b,c+1)
eq2 = sym.Eq(b+c,d-1)
eq3 = sym.Eq(c+d,e+1)
eq4 = sym.Eq(d+e,f-1)
eq5 = sym.Eq(e+f,g+1)
eq6 = sym.Eq(f+g,a-1)
eq7 = sym.Eq(g+a,b+1)
result = sym.solve([eq1,eq2,eq3,eq4,eq5,eq6,eq7],(a,b,c,d,e,f,g))
print(result)
# print(type(result))
# print(result.keys())
# print(list(result.keys())[0])
# print(type(list(result.keys())[0]))
# print(result[a])
print("a + b + c + d + e + f + g =", sum(result.values()))


