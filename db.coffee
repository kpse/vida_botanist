mongoose = require("mongoose");
cors = require("cors");
dbpath =  process.env['MONGOLAB_URI'] || 'mongodb://localhost/simple'
mongoose.connect dbpath