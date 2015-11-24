module.exports = function (app) {
  var db = app.dataSources.db;
  var User = app.models.user;
  var Resource = app.models.Resource;
  var Platform = app.models.Platform;
  var models = [User.modelName, Resource.modelName, Platform.modelName];

  db.isActual(models, function (err, actual) {
    if (!actual) {
      console.log("Creating or updating tables");
      db.autoupdate(models, function (err) {
        if (err) throw err;

        User.findOrCreate({username: 'root'}, {
          username: 'root', email: 'contato@remar.dc.ufscar.br',
          firstName: 'REMAR', lastName: 'Admin', password: 'rootroot', gender: 'other', dev: true
        }, function (err, ignored) {
          if (err) throw err;

          console.log("root user: ok");
        });

        Platform.findOrCreate({name: 'web'}, {name: 'web'}, function (err, ignored) {
          if (err) throw err;

          console.log("Web platform: ok");
        });
      });
    } else {
      console.log("All models are up-to-date");
    }
  });
};
