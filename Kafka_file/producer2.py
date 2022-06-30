import json
from time import *
from kafka import KafkaProducer
import pandas as pd
producer = KafkaProducer(bootstrap_servers='localhost:9092',value_serializer=lambda v:
json.dumps(v).encode('utf-8'))

topiclist= ['Research','cardiologist']
df1 = pd.read_csv('heart.csv')
df2 = df1[['age','sex','cp','restecg','trestbps']]
df = [df1 , df2]
for i in range (len(df)):
    for j,row in df[i].iterrows():
        producer.send(topiclist[i], row.to_dict())
        sleep(10)
producer.flush()

