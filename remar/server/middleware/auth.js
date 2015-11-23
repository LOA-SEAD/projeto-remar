/**
 * Created by matheus on 11/23/15.
 *
 * @param level 'login' | 'admin' | 'dev' | (null | undefined)
 * @param url required if level == null | undefined. If the user is authenticated, redirect s/he to this url.
 * @returns {Function}
 */
module.exports = function (level, url) {
  return function (req, res, next) {

    if (level === 'login') {
      if (!req.isAuthenticated()) {
        return res.redirect("/login");
      }
    } else if (level == null) {
      if (req.isAuthenticated()) {
        return res.redirect(url);
      }
    } else {
      if (req.isUnauthenticated()) {
        return res.redirect("/login");
      } else {
        if (!req.user.roles[level]) {
          return res.redirect("/403");
        }
      }
    }
    next();
  }
};
