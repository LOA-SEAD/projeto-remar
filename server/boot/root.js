module.exports = function(server) {
  // Install a `/` route that returns server status
  var router = server.loopback.Router();

  router.get('/', function (req, res, next) {
    res.render("index", {title: "Projeto REMAR"})
  });

  server.use(router);
};
