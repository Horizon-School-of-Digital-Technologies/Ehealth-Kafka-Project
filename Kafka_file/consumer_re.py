from kafka import KafkaConsumer
topic_name = 'Research'
consumer = KafkaConsumer(topic_name, group_id='new-consumer-group-topic1', auto_offset_reset=
"earliest",bootstrap_servers= 'localhost:9092')
for msg in consumer:
    print(msg)
