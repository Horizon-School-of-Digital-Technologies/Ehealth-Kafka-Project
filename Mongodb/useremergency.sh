db.createRole(
   {
     role: "emergencyReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'stroke'
          }, actions: ["find", "update","insert"]
        }
     ],
     roles: []
   }
)
use Ehealth 
db.createUser({user: 'Emergencydoctor',
  pwd: 'emergencydoctor',
  roles: [
    { role: 'emergencyReadWrite', db: 'Ehealth'}
  ]})
