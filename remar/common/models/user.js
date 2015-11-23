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
};
