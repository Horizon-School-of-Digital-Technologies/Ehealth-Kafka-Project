# Development and Deployment of an E-Health system
## Mini-project context: 

In every E-health system, a multitude of sensors or iOT objects are deployed to collect data that surveys activity , status and environment measurments per patients.
The goal is to store data and analyze it in order to automatize decision making and protect the patients lives. 
These decisions or records may be taken on the spot, real-time, or sent to a BigData system for storage and futur diagnosis and reportings.
Added to this, in "ALERT" cases , specialized emergency teams need to be notified in real-time.

![](https://github.com/nadinelabidi/Kafka-Mongo/blob/main/Kafka_file/kafka%20mongo.PNG)

This figure  shows an example of an e-health system architecture deployed in a hospital.
Corporal sensors detect measurments per patient to survey his status (Example : Body temperature, heart beats per sec, blood sugar, etc ..)

In our mini project, we will go a little further in details in terms of system specifications and components necessary to deploy. 
We will focus on a BigData architecture that respects and deploy a specific solution based on "Batch" treatment.
More specifically, we will simulate the gateways with a kafka producer that will create topics where some will be consumed by real-time groups and other will be sent to a mongo Db sink dedicated to "Offline" consumers.
The architecture we will be applying is the following : 

![](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/kafka_architecture.png)

To keep it simple, we have
*Kafka cluster (with a Broker and a zookeeper)
*Producer API: Publish messages to the topics in the Kafka cluster.
*Consumer API: Consume messages from the topics in the Kafka cluster.
*Connect API: Directly connect the Kafka cluster the sink system without coding. The system here is our mongoDB NoSQL database.
This small tutorial creates a data pipeline from Apache Kafka over MongoDB into Python.
It focuses on simplicity and can be seen as a baseline for similar projects.

## Prerequisites

* [docker](https://docs.docker.com/get-docker/)
* [docker-compose](https://docs.docker.com/compose/install/)


## Set up
```
docker-compose up --build -d
```

The build will create the following containers : 
* Zookeeper
* Kafka Broker 
* Kafka 
* Kafka Connect
    * with [MongoDB Connector](https://www.confluent.io/hub/mongodb/kafka-connect-mongodb)
* MongoDB 
* control-center



## Kafka Producer

[The Kafka Producer](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/gateway.py) fakes a Gateway simulator to push data into the topics ` in `JSON` format every five seconds.
The producer script in Kafka will do the job of data collector / Gateways  and will read / collect data from the sub-dataset [test.csv] that contains 10 lines of different patient measurements without the label (0/1). Kafka producer will reade the file line by line to simulate the gateway and send to the consumer with a sleep of 5 seconds.
The subset is obtained from the original [dataset](https://www.kaggle.com/datasets/johnsmith88/heart-disease-dataset) which we used to develop our machine learning model to classify the patients.
![](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Demo/gateway.gif)
We managed to select 6 Topics in total.
* Topic research:  
Healthcare Data is one of the most important data and organizations working with health data are developing many needed healthcare improvements for that the department research needs to have access to the full Database collected.

* Topic dyslipidimeia: 
It is the imbalance of lipids such as cholesterol, low-density lipoprotein cholesterol, (LDL-C), triglycerides, and high-density lipoprotein (HDL).


* Topic diabete:
Diabetes is a chronic (long-lasting) health condition that affects how your body turns food into energy and it is detected by a Fasting blood sugar test.


* Topic stroke:
A stroke is a serious life-threatening medical condition that happens when the blood supply to part of the brain is cut off. Strokes are a medical emergency and urgent treatment is essential.
Stroke will be defined based on specific features values 

* Topic vitals: 
Vital signs are measurements of the body's most basic functions and are routinely checked by healthcare providers include:
     

* Topic cardiology: 
Angina is chest pain caused by reduced blood flow to the heart muscles. It's not usually life threatening, but it's a warning sign that you could be at risk of a heart attack or stroke. 
Classification based on XGBoost ML classifier model: 0 :normal patient / 1 : Cardio patient

## Kafka Consumers
### Consumer Group A 
* [Nurses](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/nurse.py)
* [Emergency doctors](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/emergency_doctor.py) 
 These consumers are Stream Consumers + get alerted when needed 
 Emergency doctors get an alert if a stroke is predicted
 The Nurses get an alert if vital signs exceed normal values
### Consumer Group B  
This group of consumers can read the data from mongodb (Batch/offline):
* Group A
* [Cardiologist](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/cardiologist.py)
* [Endocrinologist](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/endocrinologist.py)
* [Lipidologist](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/lipidologist.py)
* [Researcher](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Kafka_file/researcher.py)

### data dictionary
#### age - age in years
#### sex - (1 = male; 0 = female)
#### cp - chest pain type
* 0: Typical angina: chest pain related decrease blood supply to the heart
* 1: Atypical angina: chest pain not related to heart
* 2: Non-anginal pain: typically esophageal spasms (non heart related)
* 3: Asymptomatic: chest pain not showing signs of disease
#### trestbps - resting blood pressure (in mm Hg on admission to the hospital) anything above 130-140 is typically cause for concern
#### chol - serum cholestoral in mg/dl
* serum = LDL + HDL + .2 * triglycerides
* above 200 is cause for concern
#### fbs - (fasting blood sugar > 120 mg/dl) (1 = true; 0 = false)
* '>126' mg/dL signals diabetes
#### restecg - resting electrocardiographic results
* 0: Nothing to note
* 1: ST-T Wave abnormality: 
can range from mild symptoms to severe problems/ signals non-normal heart beat
* 2: Possible or definite left ventricular hypertrophy > Enlarged heart's main pumping chamber
#### thalach - maximum heart rate achieved
#### exang - exercise induced angina (1 = yes; 0 = no)
#### oldpeak - ST depression induced by exercise relative to rest looks at stress of heart during excercise unhealthy heart will stress more
#### slope - the slope of the peak exercise ST segment
* 0: Upsloping: better heart rate with excercise (uncommon)
* 1: Flatsloping: minimal change (typical healthy heart)
* 2: Downslopins: signs of unhealthy heart
#### ca - number of major vessels (0-3) colored by flourosopy
* colored vessel means the doctor can see the blood passing through
* the more blood movement the better (no clots)
#### thal - thalium stress result
* 1,3: normal
* 6: fixed defect: used to be defect but ok now
* 7: reversable defect: no proper blood movement when excercising

## Feature list per topic per consumer : (apart from age and sex)

| Topic     |  research   |  Cardiology          |  Stroke            |  Diabete         |  Dyslipidemia |  vitals               | 
| :---:     | :-:         | :-:                  | :-:                |       :-:        | :-:           | :-:                   | 
|  Consumer |  Researcher |  Cardiologist        |  Emergency doctor  |  Endocrinologist |  Lipiodologist|  Nurse                | 
|  Features | all         | cp,trestbps,restecg, | trestbps,cp,restecg| fbs              | chol          | Temp,trestbps,restecg |
|           |             | ca,chol,thalach,slope|                    |                  |               |                       |      

## Kafka Connect

Apache Kafka is an event streaming and batching solution and  MongoDB is the world’s most popular modern database built for handling massive volumes of heterogeneous data. Together MongoDB and Kafka make up the heart of many modern data architectures today.
Integrating Kafka with external systems like MongoDB is done through the use of Kafka Connect. This API enables users to leverage ready-to-use components that can stream data from external systems into Kafka topics, and stream data from Kafka topics into external systems. The official MongoDB Connector for Apache Kafka® is developed and supported by MongoDB engineers and verified by Confluent. The connector, now released in Beta, enables MongoDB to be configured as both a sink and a source for Apache Kafka.
![](MongoDB_connector.jpg)

## MongoDB 
Management of users that were given access to the database is the sole responsibility of the user or users with the administrator role: "root"
Administrators have the following responsibilities:
* Add new users
* Delete users
* Manage user access
* Set user connection privilege
* Edit user permissions
* View existing user permissions
* Change user passwords 
For our system, we have the following users: 

| User          |  Researcher     | Cardiologist            |  Emergency doctor |  Endocrinologist |  Lipiodologist        | Nurse                           | 
| :---:         | :-:             | :-:                     | :-:               |              :-: | :-:                   | :-:                              | 
| Collection    | patients_record | cardio_patients, stroke | stroke            | diabete_patients | dyslipidemia_patients | patients_record, abnormal_vitals |
| access rights | Read Only       | Read/write , Read Only  | Read/write        | Read/write       | Read/write            | Read Only, Read/write            |


In our case, we used Kafka Connect to transfer the Data from Kafka topics to MongoDB.
For each topic we verify that the [MongoDb Sink Connector](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Mongodb/sink.sh) is added to Kafka Connect correctly:
![](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Demo/mongosink.gif)
![](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Demo/mongosink2.gif)
```
curl -s -XGET http://localhost:8083/connector-plugins | jq '.[].class'
```
![](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Demo/topics.gif)

Start the connector:
```
curl -X POST -H "Content-Type: application/json" --data @MongoDBConnector.json http://localhost:8083/connectors | jq
```
Verify that the connector is up and running:
```
curl localhost:8083/connectors/TestData/status | jq
```
### [Running the Kafka producer](https://github.com/nadinelabidi/Kafka-Mongo/blob/main/Kafka_file/producer2.py)
Run the produce:
```
python3 Gateway.py
```
(gif)

Verify that data is produced correctly:

To access Confuent Control Center and Visualize the Cluster as well as the architecture created :
* Topics
* Consumers
* Mongo Sinks
```
localhost:9021
```
Here are the verification the the clusters, its containers and the architecture is well existing:
(gif localhost)



Connect to MongoDB Container as an administrator and check that the Database Ehealth and the collections were created:
```
docker-compose -it mongo bash
```
access mongo as an administrator
```
mongo -u root -p root
```
To visualize databases and collections
```
show dbs
```
```
use <database_name>
```
```
show collections
```
To access a specific collection
```
db.<collection_name>.find()
```
```
exit
```

* Connect to MongoDB container as an administrator and attribute the right privileges to each [user](https://github.com/nadinelabidi/Ehealth-Kafka-Project/tree/main/Mongodb)
#### [Create new roles](https://www.mongodb.com/docs/manual/tutorial/manage-users-and-roles/)

#### [Create users](https://www.mongodb.com/docs/manual/reference/method/db.createUser/)

![](https://github.com/nadinelabidi/Ehealth-Kafka-Project/blob/main/Demo/cardiologistasauser.gif)



![](MongoDB.gif)



## Sources

* [Confluent Docker-Compose file](https://github.com/confluentinc/cp-all-in-one/blob/6.1.1-post/cp-all-in-one/docker-compose.yml)
* [Confluent Docker Configuration Parameters](https://docs.confluent.io/platform/current/installation/docker/config-reference.html)
* [Confluent Kafka Connect](https://docs.confluent.io/home/connect/userguide.html#installing-kconnect-plugins)
* [Confluent Hub MongoDB Connector](https://www.confluent.io/hub/mongodb/kafka-connect-mongodb)
* [MongoDB Connector Configuration Properties](https://docs.mongodb.com/kafka-connector/current/kafka-sink-properties/)
* [mongolite Package](https://cran.r-project.org/web/packages/mongolite/mongolite.pdf)
* [PyMongo Distribution](https://pymongo.readthedocs.io/en/stable/)


