# https://colab.research.google.com/github/google/eng-edu/blob/main/ml/cc/exercises/numpy_ultraquick_tutorial.ipynb
# pip3 install numpy

import numpy as np

feature = np.arange(6, 21)
print(feature)
label = feature * 3 + 4
print(label)

noise = np.random.uniform(low=-2, high=2, size=15)
print(noise)
noisy_label = noise + label
print(noisy_label)


