module.exports = function(server) {
  // Install a `/` route that returns server status
  var router = server.loopback.Router();

  router.get('/', function (req, res, next) {
    res.render("index", {title: "Projeto REMAR"})
  });

  router.get('/dashboard', function (req, res, next) {
    res.render("dashboard", {title: "Dashboard - Projeto REMAR"})
  });

  router.get('/info', function (req, res, next) {
    res.render("info", {title: "Mais informações - Projeto REMAR"})
  });

  server.use(router);
};
