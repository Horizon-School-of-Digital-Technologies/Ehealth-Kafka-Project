 FROM confluentinc/cp-kafka-connect-base:5.3.0
 
 ENV  CONNECT_PLUGIN_PATH:"/usr/share/java,/usr/share/confluent-hub-components" \
 && CLASSPATH: /usr/share/java/monitoring-interceptors/monitoring-interceptors-5.3.0.jar
 
 RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:latest
