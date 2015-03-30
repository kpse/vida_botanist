passport = require('passport')
express = require('express')
UserModel = require('../model/user')
router = express.Router()
User = UserModel.User

### GET home page. ###

router.get '/', (req, res, next) ->
  res.render 'index', {title: 'Express', user: req.user}

router.get '/signup', (req, res, next) ->
  res.render 'signup', title: 'Sign up'

router.post '/signup', (req, res, next) ->
  data = req.body
  console.log(data);
  new User(data).save();
  res.redirect('/login');

module.exports = router