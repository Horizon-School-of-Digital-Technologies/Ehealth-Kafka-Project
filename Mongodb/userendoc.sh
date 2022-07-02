db.createRole(
   {
     role: "EndocrinologistReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'diabete_patients'
          }, actions: ["find","update","insert"]
        }
     ],
     roles: []
   }
)
use Ehealth 
db.createUser({user: 'Endocrinologist',
  pwd: 'endocrinologist',
  roles: [
    { role: 'EndocrinologistReadWrite', db: 'Ehealth'},
    

  ]})
