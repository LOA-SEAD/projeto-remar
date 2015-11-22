/**
 * Created by matheus on 11/22/15.
 */

var httpProxy = require('http-proxy');

var proxy = httpProxy.createProxyServer({});

// TODO: make this dynamic, i.e., accept new additions/removals in runtime
var apps = ['forca', 'escola-magica', 'mathjong'];

module.exports = function() {
  return function (req, res, next) {
    /**
     * An error will occur when the user hits an app that isn't running.
     * Example: someone fires a GET http://remar.dc.ufscar.br/forca and no app is listening to :3001
     *
     * TODO: figure out how to show loopback's 404 page
     */
    proxy.on("error", function () {
      var e = new Error("Something went wrong");
      e.statusCode = 404;
      next(e);
    });

    var app = req.url.split("/")[1];
    var index = apps.indexOf(app) + 1;

    if (index != 0) {
      req.url = req.url.replace("/" + app, "");
      proxy.web(req, res, {target: "http://localhost:" + (3000 + index)})
    } else {
      next();
    }
  }
};
