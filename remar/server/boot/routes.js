module.exports = function(app) {

  // begin Static

  app.get('/', function (req, res) {
    res.render("index/index");
  });

  app.get('/dashboard', function (req, res) {
    res.render("dashboard", {title: "Dashboard - Projeto REMAR"});
  });

  app.get('/info', function (req, res) {
    res.render("index/info");
  });

  // end Static


  // begin User

  app.get("/signup",function(req,res){
    res.render("user/create");
  });


  app.post('/confirmation', function(req, res){
    console.dir(req.body);
    res.send("Post feito!");
    //var Firstname = req.body.firstName;
    //console.log(Firstname);
    app.models.user.create([{firstName:req.body.firstName,lastName:req.body.lastName,username:req.body.username,email: req.body.email,password:req.body.password,
    gender:"male"}],function(err, users) {
      if (err) throw err;

      console.log('Users created:\n', users);
    });

  });
  // end User

};
