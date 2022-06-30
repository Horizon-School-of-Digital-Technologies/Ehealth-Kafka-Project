db.createRole(
   {
     role: "ResearchReadOnly",
     privileges: [
        {
          resource: {
            role: 'read',
            db: 'Ehealth',
            collection: 'all_data'
          }, actions: ["find"]
        }
     ],
     roles: []
   }
)
use Ehealth 
db.createUser({user: 'Researcher',
  pwd: 'research',
  roles: [
    { role: 'ResearchReadOnly', db: 'Ehealth'}
  ]})