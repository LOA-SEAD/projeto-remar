var passport      = require('passport'),
    LocalStrategy = require('passport-local').Strategy,
    bcrypt        = require('bcrypt'),
    loopback      = require('loopback');


module.exports = function(app) {
  passport.use(new LocalStrategy({
    passReqToCallback: true
  },
    function(req, username, password, done) {
      app.models.user.findOne({where: {username: username}}, function (err, user) {
        if (err) return done(err);
        if (!user) return done(null, false, {message: req.__('username_not_found')});

        if (!bcrypt.compareSync(password, user.password)) {
          return done(null, false, {message: req.__('wrong_password')});
        }

        return done(null, user);
      });
    }
  ));

  app.middleware('session:before', loopback.cookieParser(app.get('cookieSecret')));
  app.middleware('session', loopback.session({
    secret: 'CHANGE_THIS',
    saveUninitialized: true,
    resave: true
  }));
  app.use(passport.initialize());
  app.use(passport.session());

  app.get("/login", function (req, res) {
    res.render("login");
  });

  app.post("/login", passport.authenticate("local", {successRedirect: '/',
    failureRedirect: '/login'}));

  app.get('/logout', function (req, res) {
    req.logout();
    res.redirect('/');
  });

  passport.serializeUser(function(user, done) {
    done(null, user);
  });

  passport.deserializeUser(function(user, done) {
    done(null, user);
  });
};
