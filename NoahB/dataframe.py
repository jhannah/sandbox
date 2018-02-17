import pandas as pd
data = [
  [1,2,3],
  [2,3,4,3,'D1-C1'],
  [5,6,7,4,'D2-C2'],
]
df = pd.DataFrame(
  data,
  columns=['A', 'B', 'C', 'D', 'E'],
  dtype=float
)
df['E'] = pd.eval('df.D - df.C')

print (df)
'''
     A    B    C    D    E
0  1.0  2.0  3.0  NaN  NaN
1  2.0  3.0  4.0  3.0 -1.0
2  5.0  6.0  7.0  4.0 -3.0
'''

