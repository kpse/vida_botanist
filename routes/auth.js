// Generated by CoffeeScript 1.7.1
(function() {
  var express, passport, router;

  passport = require('passport');

  express = require('express');

  router = express.Router();


  /* GET login page. */

  router.get('/', function(req, res, next) {
    return res.render('login', {
      title: 'Login'
    });
  });

  router.post('/', passport.authenticate('local', {
    successRedirect: '/',
    failureRedirect: '/login',
    failureFlash: true
  }));

  module.exports = router;

}).call(this);

//# sourceMappingURL=auth.map