module.exports = function(app) {

  app.dataSources.db.automigrate('user', function(err){
    if (err) throw err;
    var user = app.models.user;

    user.create([
      {username: 'root', email: 'root@remar.com.br',
        firstName: 'ROOT',lastName: "ROOT", password: "senha", gender:"male"},
      {username: 'deniscapp', email: 'denis_cappelini@hotmail.com',
        firstName: 'Denis',lastName: "Cappelini", password: "senhadodenis", gender:"male"}
    ], function(err, users) {
      if (err) throw err;

      console.log('Users created:\n', users);
    });

  });
};
