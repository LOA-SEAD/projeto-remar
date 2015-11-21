module.exports = function(server) {
  // Install a `/` route that returns server status
  var router = server.loopback.Router();

  router.get('/', function (req, res, next) {
    res.render("index/index");
  });

  router.get('/dashboard', function (req, res, next) {
    res.render("dashboard", {title: "Dashboard - Projeto REMAR"});
  });

  router.get('/info', function (req, res, next) {
    res.render("index/info");
  });

  server.use(router);
};
