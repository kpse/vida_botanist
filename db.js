// Generated by CoffeeScript 1.7.1
(function() {
  var cors, dbpath, mongoose;

  mongoose = require("mongoose");

  cors = require("cors");

  dbpath = process.env['MONGOLAB_URI'] || 'mongodb://localhost/simple';

  mongoose.connect(dbpath);

}).call(this);

//# sourceMappingURL=db.map