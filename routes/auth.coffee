passport = require('passport')
express = require('express')
router = express.Router()

### GET login page. ###

router.get '/', (req, res, next) ->
  res.render 'login', title: 'Login'

router.post '/', passport.authenticate('local',
  successRedirect: '/'
  failureRedirect: '/login'
  failureFlash: true)

module.exports = router