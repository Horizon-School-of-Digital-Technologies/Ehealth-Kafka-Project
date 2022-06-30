from kafka import KafkaConsumer
import json
topic_name = 'stroke'
consumer = KafkaConsumer(topic_name, group_id='new-consumer-group-topic1', auto_offset_reset=
"earliest",bootstrap_servers= 'localhost:9092')
for msg in consumer:
    record = json.loads(msg.value.decode('utf-8'))
    age = record['age']
    sex = record['sex']
    cp = record['cp']
    restecg = record['restecg']
    trestbps = record['trestbps']
    if (cp == 0) and (trestbps > 172) :
        print('Alert!!! stroke condition', record)
  
    else :
        print(record)
