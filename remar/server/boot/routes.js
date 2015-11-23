module.exports = function(app) {

  // begin Static
  var bcrypt = require('bcrypt');

  app.get('/', app.auth(null, "/dashboard"), function (req, res) {
    res.render("index/index");
  });

  app.get('/dashboard', app.auth('login'), function (req, res) {
    res.render("dashboard", {title: "Dashboard - Projeto REMAR"});
  });

  app.get('/info', app.auth(null, "/dashboard"), function (req, res) {
    res.render("index/info");
  });

  // end Static


  // begin User

  app.get("/signup",function(req,res){
    res.render("user/create");
  });


  app.post('/confirmation', function(req, res){
    console.dir(req.body);
    res.render("user/confirmation");

    //var Firstname = req.body.firstName;
    //console.log(Firstname);
    app.models.user.create([{firstName:req.body.firstName,lastName:req.body.lastName,username:req.body.username,email: req.body.email,password:req.body.password,
    gender:"male"}],function(err, user) {
      if (err) throw err;

      console.log('User created:\n', user);
    });

  });
  // end User

};
