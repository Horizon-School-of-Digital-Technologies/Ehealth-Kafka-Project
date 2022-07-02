from kafka import KafkaConsumer
topic_name = 'vitals'
consumer = KafkaConsumer(topic_name, group_id='group_A', auto_offset_reset=
"earliest",bootstrap_servers= 'localhost:9092')
for msg in consumer:
    print(msg)
