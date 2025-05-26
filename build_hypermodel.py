# -*- coding: utf-8 -*-
"""
Created on Wed May 21 08:53:53 2025

@author: Subhajit Chattopadhy
"""

import tensorflow as tf
import keras as keras

import keras_tuner as kt

import pandas as pd

import numpy as np


import os as os





os.chdir('E:/Pub/Use of MLMs/Data')

os.listdir()

df = pd.read_excel("data_ann.xlsx")

df.columns


df.shape

dr3 = df.drop(df.columns[[0,1,3,4,5,10,11,18,22,23,24,25,29,30,31]],axis=1)

dr3.columns.shape






predictors = dr3.drop(dr3.columns[[14,15,16]], axis=1)

predictors.shape

y = pd.DataFrame({'side' : dr3['ann3_side'], 
                 'up' : dr3['ann3_up'],
                 'down' : dr3['ann3_dn']})



from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(predictors, y, test_size=0.2)

y_train.shape

y_test.shape


X_train.shape


import keras_tuner as kt 

from keras_tuner import HyperParameters as hp 

from keras.layers import Dense
    
def build_model(hp):
        
        mod1 = keras.Sequential()
        
        mod1.add(keras.Input(shape=(14,)))
        
        mod1.add(keras.layers.Dense(hp.Int ('units', min_value = 16, max_value = 128, step = 16),
                 hp.Choice('activation', ["relu", "tanh", "hard_tanh"])))
        
        mod1.add(keras.layers.Dense(hp.Int('units', min_value = 16, max_value = 128, step = 16),
                 hp.Choice('activation', ["relu", "tanh", "hard_tanh"])))
        
        mod1.add(keras.layers.Dense(hp.Int('units', min_value = 16, max_value = 128, step = 16),
                 hp.Choice('activation', ["relu", "tanh", "hard_tanh"])))
        
        mod1.add(keras.layers.Dense(hp.Int('units', min_value = 16, max_value = 128, step = 16),
                 hp.Choice('activation', ["relu", "tanh", "hard_tanh"])))

        mod1.add(keras.layers.Dense(3, activation = "softmax"))
        
        hp_learning_rate = hp.Float('learning_rate', min_value = 0.0001, max_value = 0.0005, step = 0.001)
        
        mod1.compile(optimizer = keras.optimizers.RMSprop(learning_rate= hp_learning_rate), 
                     loss = 'categorical_crossentropy' , 
            metrics = ['accuracy'] )
        
        return mod1
    
    
tuner3 = kt.BayesianOptimization(build_model,objective='val_accuracy' ,max_trials= 10, overwrite=True) 

tn = tuner3.search(X_train,y_train, epochs = 30, validation_data = (X_test, y_test))



best_model = tn.get_best_models()[0]

best_model


