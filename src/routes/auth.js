var express, passport, router;

passport = require('passport');

express = require('express');

router = express.Router();


/* GET login page. */

router.get('/', function(req, res, next) {
  if (req.user) {
    return res.render('profile', {
      title: 'Profile',
      user: req.user
    });
  } else {
    return res.render('login', {
      title: 'Login'
    });
  }
});

router.post('/', passport.authenticate('local', {
  successRedirect: '/',
  failureRedirect: '/login',
  failureFlash: true
}));

module.exports = router;
