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

  // end User

};
