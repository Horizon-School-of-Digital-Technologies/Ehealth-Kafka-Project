db.createRole(
   {
     role: "VitalsReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'abnormal_vitals'
          }, actions: ["find","update", "insert"]
        }
     ],
     roles: []
   }
)

db.createRole(
   {
     role: "patientsReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'patients_record'
          }, actions: ["find","update", "insert"]
        }
     ],
     roles: []
   }
)


use Ehealth 
db.createUser({user: 'Nurse',
  pwd: 'nurse',
  roles: [
    { role: 'VitalsReadWrite', db: 'Ehealth'},
    { role: 'patientsReadWrite', db: 'Ehealth'}
  ]})
