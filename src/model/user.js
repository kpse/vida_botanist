var User, mongoose, userSchema;

mongoose = require("mongoose");

userSchema = {
  username: String,
  password: String,
  fullname: String,
  suffix: String
};

User = mongoose.model('User', userSchema, 'users');

exports.passport = function(username, password, done) {
  return User.findOne({
    username: username
  }, function(err, user) {
    if (err) {
      return done(err);
    }
    if (!user) {
      return done(null, false, {
        message: 'Incorrect username.'
      });
    }
    if (user.password !== password) {
      return done(null, false, {
        message: 'Incorrect password.'
      });
    }
    return done(null, user);
  });
};

exports.User = User;
