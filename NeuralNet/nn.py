# coding=utf-8
from __future__ import absolute_import
import numpy as np
import coremltools
import keras
import pandas as pd
from keras.models import Sequential
from keras.layers import Dense, Activation, Dropout, Flatten
from keras.layers.normalization import BatchNormalization
from keras.regularizers import l2
from keras.optimizers import Adam


def create_mini_batches(X, y, batch_size):
    mini_batches = []
    data = np.hstack((X, y))
    np.random.shuffle(data)
    n_minibatches = data.shape[0] // batch_size
    i = 0
    
    for i in range(n_minibatches + 1):
        mini_batch = data[i * batch_size:(i + 1)*batch_size, :]
        X_mini = mini_batch[:, :-2]
        Y_mini = mini_batch[:, -2:]
        mini_batches.append((X_mini, Y_mini))
    if data.shape[0] % batch_size != 0:
        mini_batch = data[i * batch_size:data.shape[0]]
        X_mini = mini_batch[:, :-2]
        Y_mini = mini_batch[:, -2]
        mini_batches.append((X_mini, Y_mini))
    return mini_batches

dfInput = pd.read_csv("trainingdata.csv")
dfInput = dfInput.values
dfOutput = pd.read_csv("trainingsol.csv")
dfOutput = dfOutput.values
print(dfOutput)

#print(dfInput)
#x=np.zeros(5)
#print(x)
#print(dfInput.shape)
#print(x.shape)


N=64  #Batch size of 32ß, 50 epochs
D=7
H=5
O=2

model=Sequential()
model.add(Dense(input_dim=D, output_dim=H))
model.add(Activation('relu'))
model.add(Dense(input_dim=H, output_dim=O))
model.add(Activation('sigmoid'))

optimizer=Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=None, decay=0.0, amsgrad=False)
model.compile(loss='binary_crossentropy', optimizer=optimizer)

#x=np.random.randn(32,7)
#y= np.zeros((N, 2))
#temp= np.random.choice(2, 32)
#for i, j in enumerate(temp):
#    y[i, j] = 1

minibatches = create_mini_batches(dfInput, dfOutput, N)
print(minibatches)
x,y = minibatches[0]
#x= np.random.choice(minix, 1)
#y= np.random.choice(miniy, 1)

history=model.fit(x,y,nb_epoch=5000, batch_size=N, verbose=2)


print(history.history)

model.save_weights('dummy_weights.h5')
coreml_model= coremltools.converters.keras.convert(model)
coreml_model.save('my_model.mlmodel')
