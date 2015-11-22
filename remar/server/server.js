var loopback = require('loopback');
var boot = require('loopback-boot');
var i18n = require('i18n');
var bodyParser = require('body-parser');

var app = module.exports = loopback();

app.start = function() {
  // start the web server
  return app.listen(function() {
    app.emit('started');
    var baseUrl = app.get('url').replace(/\/$/, '');
    console.log('Web server listening at: %s', baseUrl);
    if (app.get('loopback-component-explorer')) {
      var explorerPath = app.get('loopback-component-explorer').mountPath;
      console.log('Browse your REST API at %s%s', baseUrl, explorerPath);
    }
  });
};

//app.use(bodyParser.json()); // for parsing application/json
//app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
//app.use(multer()); // for parsing multipart/form-data

app.middleware('parse', bodyParser.json());
app.middleware('parse', bodyParser.urlencoded({extended: true}));

/* Defining the views folder */
app.set('view engine', 'jade');

i18n.configure({
  locales: ['en', 'pt-br'],
  directory: "./locales"
});

app.use(i18n.init);

// Bootstrap the application, configure models, datasources and middleware.
// Sub-apps like REST API are mounted via boot scripts.
boot(app, __dirname, function(err) {
  if (err) throw err;

  // start the server if `$ node server.js`
  if (require.main === module)
    app.start();
});
