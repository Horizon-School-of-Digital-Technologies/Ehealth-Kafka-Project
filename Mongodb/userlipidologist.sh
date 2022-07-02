db.createRole(
   {
     role: "DyslipidemiaReadWrite",
     privileges: [
        {
          resource: {
            role: 'readWrite',
            db: 'Ehealth',
            collection: 'dyslipidemia_patients'
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
  
  

