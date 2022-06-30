db.createRole(
   {
     role: "CardiologistReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'Stroke'
          }, actions: ["find","update","insert"]
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
    { role: 'StrokeReadWrite', db: 'Ehealth'}
  ]})