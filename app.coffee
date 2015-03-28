express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
flash = require('connect-flash');
routes = require('./routes/index')
users = require('./routes/users')
flowers = require('./routes/flowers')
auth = require('./routes/auth')
passport = require('passport')
LocalStrategy = require('passport-local').Strategy
session = require('express-session')


app = express()
# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use require('less-middleware')(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'dist'))

app.use session({ secret: 'keyboard cat', resave: false, saveUninitialized: false })
app.use flash()
app.use passport.initialize()
app.use passport.session()

app.use '/', routes
app.use '/users', users
app.use '/flowers', flowers
app.use '/login', auth

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err

# error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}



mongoose = require("mongoose");
cors = require("cors");

mongoose.connect 'mongodb://localhost/simple'
personSchema =
  username: String
  password: String
  email: String
  cellphone: String
User = mongoose.model('User', personSchema, 'users')
user = new User
  username: 'suoqin'
  password: '12345'
  email: 'abc@a.com'
  cellphone: '1234567891'
user.save()

passport.use new LocalStrategy((username, password, done) ->
  User.findOne { username: username }, (err, user) ->
    return done(err) if err
    return done(null, false, { message: 'Incorrect username.' }) unless user
    return done(null, false, { message: 'Incorrect password.' }) unless user.password == password
    done null, user
)

passport.serializeUser (user, done) ->
  done null, user
passport.deserializeUser (user, done) ->
  done null, user

module.exports = app