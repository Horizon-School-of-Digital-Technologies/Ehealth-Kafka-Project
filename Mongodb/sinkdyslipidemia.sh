curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkdyslipidemia",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"Dyslipidemia",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"Dyslipidemia",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
