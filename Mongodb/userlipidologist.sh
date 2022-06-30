db.createRole(
   {
     role: "DyslipidemiaReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'Dyslipidemia'
          }, actions: ["find","update","insert"]
        }
     ],
     roles: []
   }
)
use Ehealth 
db.createUser({user: 'Lipidologist',
  pwd: 'lipidologist',
  roles: [
    { role: 'DyslipidemiaReadWrite', db: 'Ehealth'}
  ]})