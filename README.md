# Development and Deployment of an E-Health system



![](kafka_architecture.jpg)

This small tutorial creates a data pipeline from Apache Kafka over MongoDB into R or Python.
It focuses on simplicity and can be seen as a baseline for similar projects.

## Prerequisites

* [docker](https://docs.docker.com/get-docker/)
* [docker-compose](https://docs.docker.com/compose/install/)


## Set up
```
docker-compose up --build -d
```

It starts:
* Zookeeper
* Kafka Broker 
* Kafka 
* Kafka Connect
    * with [MongoDB Connector](https://www.confluent.io/hub/mongodb/kafka-connect-mongodb)
* MongoDB 
* control-center



## Kafka Producer

[The Kafka Producer](https://github.com/nadinelabidi/Kafka-Mongo/blob/main/Kafka_file/producer2.py) fakes a Gateway simulator to push data into the topics ` in `JSON` format every five seconds.
The producer script in Kafka will do the job of data collector / Gateways  and will read / collect data from the  [heart.csv](https://www.kaggle.com/datasets/johnsmith88/heart-disease-dataset) file line by line to simulate the gateway. We managed to select 6 Topics in total.
1. Topic research 
Healthcare Data is one of the most important data and organizations working with health data are developing many needed healthcare improvements for that the department research needs to have access to the full Database collected.

2. Topic dyslipidimeia
It is the imbalance of lipids such as cholesterol, low-density lipoprotein cholesterol, (LDL-C), triglycerides, and high-density lipoprotein (HDL).
This topic takes as features : Cholesterol level, age, sex

3. Topic diabetes
Diabetes is a chronic (long-lasting) health condition that affects how your body turns food into energy and it is detected by a Fasting blood sugar test.
(fasting blood sugar > 120 mg/dl) (1 = true; 0 = false)

4. Topic stroke
A stroke is a serious life-threatening medical condition that happens when the blood supply to part of the brain is cut off. Strokes are a medical emergency and urgent treatment is essential.
Stroke will be defined based on specific features values : 
    * exang
    * oldpeak
    * slope
    * ca

5. Topic vital_signs
Vital signs are measurements of the body's most basic functions. The 3 main vital signs routinely checked by healthcare providers include:
     * trestbps : resting blood pressure (in mm Hg on admission to the hospital)
     * chol : serum cholestoral in mg/dl
     * restecg : resting electrocardiographic results
     * tmp  : Body temperature

6. Topic heart_disease
Angina is chest pain caused by reduced blood flow to the heart muscles. It's not usually life threatening, but it's a warning sign that you could be at risk of a heart attack or stroke. 
Classification based on SVM : normal patient / Cardiac patient




## Kafka Connect

Apache Kafka is an event streaming and batching solutionand  MongoDB is the world’s most popular modern database built for handling massive volumes of heterogeneous data. Together MongoDB and Kafka make up the heart of many modern data architectures today.
Integrating Kafka with external systems like MongoDB is done through the use of Kafka Connect. This API enables users to leverage ready-to-use components that can stream data from external systems into Kafka topics, and stream data from Kafka topics into external systems. The official MongoDB Connector for Apache Kafka® is developed and supported by MongoDB engineers and verified by Confluent. The connector, now released in Beta, enables MongoDB to be configured as both a sink and a source for Apache Kafka.
![](MongoDB_connector.jpg)

In our case, we used Kafka Connect to transfer the Data from Kafka topics to MongoDB.
For each topic we verify the [MongoDb Sink Connector](https://github.com/nadinelabidi/Kafka-Mongo/tree/main/Mongodb) is added to Kafka Connect correctly:
(gif connect)
```
curl -s -XGET http://localhost:8083/connector-plugins | jq '.[].class'
```
(gif localhost connect)

Start the connector:
```
curl -X POST -H "Content-Type: application/json" --data @MongoDBConnector.json http://localhost:8083/connectors | jq
```
Verify that the connector is up and running:
```
curl localhost:8083/connectors/TestData/status | jq
```
### [Running th Kafka producer](https://github.com/nadinelabidi/Kafka-Mongo/blob/main/Kafka_file/producer2.py)
Run the produce:
```
python3 Gateway.py
```
(gif)

Verify that data is produced correctly:
```
lien localhost topics
```
(gif localhost)
## Kafka Consumers


## MongoDB 
Management of users that were given access to the database is the sole responsibility of the user or users with the administrator role.

The administrator has the responsibility to manage how other users in your organization access your database. For example, the administrator can add new users, block access to users who have left the organization, help users who cannot log in.
Administrators have the following responsibilities:
* Add new users
* Delete users
* Manage user access
* Set user connection privilege
* Edit user permissions
* View existing user permissions
* Change user passwords 
For our system, we have the following users: 
* Researchers : 

| Attempt | #1  | #2  |
| :---:   | :-: | :-: |
| Seconds | 301 | 283 |

* Endocrinologists
* Cardiologists
* Emergency Doctors
* Lipiodologists
* Nurses


Connect to MongoDB Container as an administrator and check that the Database Ehealth and the collections were created:
```
docker-compose -it mongo bash
#mongo -u root -p root
>show dbs
>use <database_name>
>show collections
>db.<collection_name>.find()
```
Connect to MongoDB container as an administrator and attribute the right privileges to each user:



![](MongoDB.gif)



## Sources

* [Confluent Docker-Compose file](https://github.com/confluentinc/cp-all-in-one/blob/6.1.1-post/cp-all-in-one/docker-compose.yml)
* [Confluent Docker Configuration Parameters](https://docs.confluent.io/platform/current/installation/docker/config-reference.html)
* [Confluent Kafka Connect](https://docs.confluent.io/home/connect/userguide.html#installing-kconnect-plugins)
* [Confluent Hub MongoDB Connector](https://www.confluent.io/hub/mongodb/kafka-connect-mongodb)
* [MongoDB Connector Configuration Properties](https://docs.mongodb.com/kafka-connector/current/kafka-sink-properties/)
* [mongolite Package](https://cran.r-project.org/web/packages/mongolite/mongolite.pdf)
* [PyMongo Distribution](https://pymongo.readthedocs.io/en/stable/)


