db.createRole(
   {
     role: "CardiologistReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'cardio_patients'
          }, actions: ["find","update","insert"]
        }
     ],
     roles: []
   }
)
db.createRole(
   {
     role: "CardiologistRead",
     privileges: [
        {
          resource: {
            role: 'read',
            db: 'Ehealth',
            collection: 'stroke'
          }, actions: ["find"]
        }
     ],
     roles: []
   }
)

use Ehealth 
db.createUser({user: 'Cardiologist',
  pwd: 'cardiologist',
  roles: [
    { role: 'CardiologistReadWrite', db: 'Ehealth'},
    { role: 'CardiologistRead', db: 'Ehealth'}
  ]})
