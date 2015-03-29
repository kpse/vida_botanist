mongoose = require("mongoose");

userSchema =
  username: String
  password: String
  fullname: String
  suffix: String

User = mongoose.model('User', userSchema, 'users')

exports.passport = (username, password, done) ->
  User.findOne {username: username}, (err, user) ->
    return done(err) if err
    return done(null, false, {message: 'Incorrect username.'}) unless user
    return done(null, false, {message: 'Incorrect password.'}) unless user.password == password
    done null, user

exports.User = User