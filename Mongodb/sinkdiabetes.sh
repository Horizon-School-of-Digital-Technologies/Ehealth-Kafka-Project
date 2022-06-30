curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongosinkdiabetes",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"Diabetes",
     "connection.uri":"mongodb://root:root@mongo:27017",
     "database":"Ehealth",
     "collection":"Diabetes",
     "key.converter":"org.apache.kafka.connect.storage.StringConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.storage.StringConverter",
     "value.converter.schemas.enable":false
 }}' http://localhost:8083/connectors -w "\n"
