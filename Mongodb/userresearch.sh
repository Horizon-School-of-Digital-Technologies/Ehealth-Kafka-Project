db.createRole(
   {
     role: "ResearchReadOnly",
     privileges: [
        {
          resource: {
            role: 'read',
            db: 'Ehealth',
            collection: 'patients_record'
          }, actions: ["find"]
        }
     ],
     roles: []
   }
)
use Ehealth 
db.createUser({user: 'Researcher',
  pwd: 'researcher',
  roles: [
    { role: 'ResearchReadOnly', db: 'Ehealth'}
  ]})
  


  





