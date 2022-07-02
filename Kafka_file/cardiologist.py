from kafka import KafkaConsumer
topic_name = 'cardiologist'
consumer = KafkaConsumer('cardiology', group_id='cardio', auto_offset_reset=
"earliest",bootstrap_servers= 'localhost:9092')
for msg in consumer:
    print(msg)
