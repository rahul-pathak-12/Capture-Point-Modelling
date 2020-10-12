import numpy as np
from tensorflow.keras.layers import Dense, Activation
from tensorflow.keras.models import Sequential
from tensorflow.keras.models import load_model
from tensorflow.keras.utils import plot_model
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

# Importing the dataset
data = np.genfromtxt("NORM_TRAINING.csv", delimiter=',')
X = data[:, [0, 1, 2]]
y = data[:, [ 3 ]]

# test_data = np.genfromtxt("NORM_TEST.csv", delimiter=',')
test_data = np.genfromtxt("NORM_TRAINING_FOOT_NEW_TEST.csv", delimiter=',')
# data.ADJ_COMX(2:end) data.time(2:end) data.LEG_LENGTH(2:end) x1 x2 x3 cp_vel
test = test_data[:, [3, 4, 5]]

# Initialising the ANN
model = Sequential()

# Adding the input layer and the first hidden layer
model.add(Dense(32, activation = 'relu', input_dim = 3))

model.add(Dense(units = 32, activation = 'relu'))
model.add(Dense(units = 32, activation = 'relu'))
model.add(Dense(units = 32, activation = 'relu'))

# Adding the output layer
model.add(Dense(units = 1))

# Compiling the ANN
model.compile(optimizer = 'adam', loss = 'mean_squared_error')

# Fitting the ANN to the Training set
model.fit(X, y, batch_size = 100, epochs = 200) #  gait cycles are around 100 so thats better

# This below setting produced the best network so far. 
# model.fit(X, y, batch_size = 100, epochs = 200) 
model.save('model_X.h5')


model = load_model('model.h5')

# Columns for this need to be modified
y_pred = model.predict(test)    
np.savetxt("res_FOOT_TEST.csv", y_pred, delimiter=",")
