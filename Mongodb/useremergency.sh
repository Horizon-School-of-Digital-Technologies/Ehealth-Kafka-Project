db.createRole(
   {
     role: "StrokeReadWrite",
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
db.createUser({user: 'Emergencydoctor',
  pwd: 'emergency',
  roles: [
    { role: 'StrokeReadWrite', db: 'Ehealth'}
  ]})