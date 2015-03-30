express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
flash = require('connect-flash');
routes = require('./src/routes/index')
users = require('./src/routes/users')
flowers = require('./src/routes/flowers')
auth = require('./src/routes/auth')
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

app.use session({secret: 'keyboard cat', resave: false, saveUninitialized: false})
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


user = require("./src/model/user")
db = require('./db')

passport.use new LocalStrategy(user.passport)

passport.serializeUser (user, done) ->
  done null, user
passport.deserializeUser (user, done) ->
  done null, user

module.exports = app