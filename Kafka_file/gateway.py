##import necessary modules to run classification ML model : XGBoost
#pip install scikit-learn==1.0.2
#pip install xgboost
#pip install category_encoders
from xgboost import XGBClassifier
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
import pandas as pd
import pickle
               #------------------------------------------------#
##import necessary modules for kafka producer
import json
from kafka import KafkaProducer
from datetime import datetime
from time import *
               #------------------------------------------------#

## Classification output : Labellize patients 
def classification_function(X,model):
    y_pred = model.predict(X)
    X['label'] = pd.DataFrame(y_pred)
    return X
    
## load model from file
loaded_model = pickle.load(open("pipefull.pickle.dat", "rb"))
##upload test dataset (10 lines of patient measurements
data = pd.read_csv('test.csv')

classification_function(data,loaded_model)

## create sou-datasets with specific features per topic
cardio = data[['age','sex','cp','restecg','trestbps','thalach','ca','slope','chol','label']]
vitals = data[['age','sex','Temp','restecg','trestbps']]
stroke = data[['age','sex','cp','restecg','trestbps','label']]
diabete = data[['age','sex','fbs']]
cholesterol = data[['age','sex','chol']]

##Creating Alert message content for Nurse Team
def function_alert_vitals(topic,df):
    for j,row in df.iterrows():
        if (row['restecg'] ==0) :
            message={'date':str(datetime.now()), 'Alert !!! restecg=0' : row.to_dict()}
            producer.send(topic ,message)  
        else:
            if (row['trestbps'] >140):
                message={'date':str(datetime.now()), 'Alert !!! trestbps> 140' : row.to_dict()}
                producer.send(topic, message) 
            else:
                if (row['Temp'] > 38 ):
                    message={'date':str(datetime.now()), 'Alert !!! Temperature> 38' : row.to_dict()}
                    producer.send(topic, message) 
              #------------------------------------------------# 
               
##Creating Alert message content for Emergency doctors Team
def function_alert_stroke(topic,df):
    for j,row in df.iterrows():
        if (row['label'] ==1) :
            message={'date':str(datetime.now()), 'Alert !!! Cardio patient to survey' : row.to_dict()}
            producer.send(topic ,message) 
        else: 
            if (row['restecg'] ==1) or (row['restecg'] ==2):
                message={'date':str(datetime.now()), 'Alert stroke/restecg abnormal' : row.to_dict()}
                producer.send(topic ,message)  
            else:
                if (row['trestbps'] >140):
                    message={'date':str(datetime.now()), 'Alert !!! trestbps> 140' : row.to_dict()}
                    producer.send(topic, message) 
                else:
                    if (row['cp'] == 0 ):
                        message={'date':str(datetime.now()), 'Alert stroke !!! decrease blood supply' : row.to_dict()}
                        producer.send(topic, message) 
              #------------------------------------------------#   
                       
##Creating message content for cardiologist     
def function_cardiology_patients(topic,df):
    for j,row in df.iterrows():
        if (row['label'] == 1):
            message={'date':str(datetime.now()), 'measures' : row.to_dict()}
            producer.send(topic, message)   
             #------------------------------------------------#
             
##Creating message content for Endocrinologist: Diabetes doc
def function_diabetes_patients(topic,df):
    for j,row in df.iterrows():
        if (row['fbs'] == 1):
            message={'date':str(datetime.now()), 'measures' : row.to_dict()}
            producer.send(topic, message)   
             #------------------------------------------------#  
                
##Creating message content for research purposes
def function_Research_stats(topic,df):
    for j,row in df.iterrows():
        if (row['fbs'] == 1):
            message={'date':str(datetime.now()), 'measures' : row.to_dict()}
            producer.send(topic, message)   
             #------------------------------------------------# 
                
##Creating message content for Lipidologist: cholesterol doc
def function_cholesterol_patients(topic,df):
    for j,row in df.iterrows():
        if (row['chol'] == 1):
            message={'date':str(datetime.now()), 'measures' : row.to_dict()}
            producer.send(topic, message)   
             #------------------------------------------------#      
##launching the producer                   
producer = KafkaProducer(bootstrap_servers='localhost:9092',value_serializer=lambda v:
json.dumps(v).encode('utf-8'))
now = datetime.now()

##topic declaration
topiclist= ['research','cardiology','vitals','stroke','diabete','dyslipidemia']




## call functions : sending messages to topics 
function_alert_vitals('vitals',vitals)
function_alert_stroke('stroke',stroke)          
function_Research_stats('research',data)
function_cardiology_patients('cardiology',cardio)
function_diabetes_patients('diabete',diabete)
function_cholesterol_patients('dyslipidemia',cholesterol)

##flushing producer
producer.flush
