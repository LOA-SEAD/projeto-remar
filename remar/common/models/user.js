var bcrypt = require('bcrypt');

module.exports = function(User) {
  User.observe('before save', function (ctx, next) {
    var instance = ctx.instance? ctx.instance : ctx.data;

    if (instance.password) {
      if (instance.password.length < 8) {
        var err = new Error("Password is too short"); // TODO: figure out how to use loopback.ValidationError
        err.statusCode = 422;
        return next(err);
      }
      instance.password = bcrypt.hashSync(instance.password, 10);
    }
    next();
  });

  User.observe('loaded', function (ctx, next) {
    var instance = ctx.instance;
    if (!instance) return next();

    instance.roles = {};
    instance.roles.admin = instance.username == 'root';
    instance.roles.dev   = instance.dev;

    next();
  });


  User.getApp(function (err, app) {
    app.get("/signup", function (req, res) {
      res.render("user/create");
    });

    app.post('/signup', function (req, res) {
      console.dir(req.body);
      res.render("user/confirmation");

      app.models.user.create([{
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        username: req.body.username,
        email: req.body.email,
        password: req.body.password,
        gender: "male"
      }], function (err, user) {
        if (err) throw err;

        console.log('User created:\n', user);
      });
    });
  });
};
