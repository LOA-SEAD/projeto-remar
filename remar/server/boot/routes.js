module.exports = function(app) {

  // begin Static
  var bcrypt = require('bcrypt');

  app.get('/', app.auth(null, "/dashboard"), function (req, res) {
    res.render("index/index");
  });

  app.get('/dashboard', app.auth('login'), function (req, res) { // TODO: not static, remove from here
    res.render("dashboard", {title: "Dashboard - Projeto REMAR"});
  });

  app.get('/info', app.auth(null, "/dashboard"), function (req, res) {
    res.render("index/info");
  });

  // end Static
};
