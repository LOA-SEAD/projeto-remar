module.exports = function(app) {
  var loopbackPassport = require('loopback-component-passport');
  var PassportConfigurator = loopbackPassport.PassportConfigurator;
  var passportConfigurator = new PassportConfigurator(app);

  var config = {};
  try {
    config = require('../providers.json');
  } catch (err) {
    console.trace(err);
    process.exit(1); // fatal
  }
};
