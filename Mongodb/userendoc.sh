db.createRole(
   {
     role: "EndocrinologistReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'Diabetes'
          }, actions: ["find","update","insert"]
        }
     ],
     roles: []
   }
)
use Ehealth 
db.createUser({user: 'Endocrinologist',
  pwd: 'diabetes',
  roles: [
    { role: 'EndocrinologistReadWrite', db: 'Ehealth'},
    { role: 'ResearchReadOnly', db: 'Ehealth'},

  ]})