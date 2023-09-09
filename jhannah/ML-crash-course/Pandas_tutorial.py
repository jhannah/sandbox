# https://colab.research.google.com/github/google/eng-edu/blob/main/ml/cc/exercises/pandas_dataframe_ultraquick_tutorial.ipynb
# pip3 install numpy pandas

import numpy as np
import pandas as pd

# Create and populate a 5x2 NumPy array.
my_data = np.array([[0, 3], [10, 7], [20, 9], [30, 14], [40, 15]])

# Create a Python list that holds the names of the two columns.
my_column_names = ['temperature', 'activity']

# Create a DataFrame.
my_dataframe = pd.DataFrame(data=my_data, columns=my_column_names)

# Print the entire DataFrame
# print(my_dataframe)

# Create a new column named adjusted.
my_dataframe["adjusted"] = my_dataframe["activity"] + 2

# Print the entire DataFrame
print(my_dataframe)

# print("Rows #0, #1, and #2:")
# print(my_dataframe.head(3), '\n')

# print("Row #2:")
# print(my_dataframe.iloc[[2]], '\n')

# print("Rows #1, #2, and #3:")
# print(my_dataframe[1:4], '\n')

# print("Column 'temperature':")
# print(my_dataframe['temperature'])

print("----- Task 1 ---------")
data = np.random.randint(low=0, high=101, size=(3,4))
columns = ['Eleanor', 'Chidi', 'Tahani', 'Jason']
df = pd.DataFrame(data=data, columns=columns)
print(df)
print(df['Eleanor'][1])
print("\nSecond row of the Eleanor column: %d\n" % df['Eleanor'][1])

df['Janet'] = df['Tahani'] * df['Jason']
print(df)

print("---- Back to tutorial -----")

# Create a reference by assigning my_dataframe to a new variable.
print("Experiment with a reference:")
reference_to_df = df

# Print the starting value of a particular cell.
print("  Starting value of df: %d" % df['Jason'][1])
print("  Starting value of reference_to_df: %d\n" % reference_to_df['Jason'][1])

# Modify a cell in df.
df.at[1, 'Jason'] = df['Jason'][1] + 5
print("  Updated df: %d" % df['Jason'][1])
print("  Updated reference_to_df: %d\n\n" % reference_to_df['Jason'][1])

# Create a true copy of my_dataframe
print("Experiment with a true copy:")
copy_of_my_dataframe = my_dataframe.copy()

# Print the starting value of a particular cell.
print("  Starting value of my_dataframe: %d" % my_dataframe['activity'][1])
print("  Starting value of copy_of_my_dataframe: %d\n" % copy_of_my_dataframe['activity'][1])

# Modify a cell in df.
my_dataframe.at[1, 'activity'] = my_dataframe['activity'][1] + 3
print("  Updated my_dataframe: %d" % my_dataframe['activity'][1])
print("  copy_of_my_dataframe does not get updated: %d" % copy_of_my_dataframe['activity'][1])



