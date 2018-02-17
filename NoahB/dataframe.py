import pandas as pd
data = [
  [1,2,3,'will be a shift() copy','will be a formula'],
  [2,3,4],
  [5,6,7]
]
df = pd.DataFrame(
  data,
  columns=['A', 'B', 'C', 'D', 'E'],
  dtype=float
)
df['D'] = df['C'].shift(1)
df['E'] = pd.eval('df.D - df.C')

print (df)
'''
     A    B    C    D    E
0  1.0  2.0  3.0  NaN  NaN
1  2.0  3.0  4.0  3.0 -1.0
2  5.0  6.0  7.0  4.0 -3.0
'''

