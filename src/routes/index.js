var User, UserModel, express, passport, router;

passport = require('passport');

express = require('express');

UserModel = require('../model/user');

router = express.Router();

User = UserModel.User;


/* GET home page. */

router.get('/', function(req, res, next) {
  return res.render('index', {
    title: 'Express',
    user: req.user
  });
});

router.get('/signup', function(req, res, next) {
  return res.render('signup', {
    title: 'Sign up'
  });
});

router.post('/signup', function(req, res, next) {
  var data;
  data = req.body;
  console.log(data);
  new User(data).save();
  return res.redirect('/login');
});

module.exports = router;
