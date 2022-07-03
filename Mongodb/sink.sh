curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkcardio",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"cardiology",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"cardio_patients",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
 
 curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkdiabetes",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"diabete",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"diabete_patients",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
 
 curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkdyslipidemia",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"dyslipidemia",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"dyslipidemia_patients",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
 
 
 curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkresearch",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"research",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"patients_record",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
 
 curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkstroke",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"stroke",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"stroke",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
 
 curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkvitalpara",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"vitals",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"abnormal_vitals",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
