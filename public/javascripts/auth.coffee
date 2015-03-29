_ = require('lodash')
crypto = require('crypto');

text = "MD5 this text!"
md5hash1 = crypto.createHash('md5').update(text).digest("hex");
console.log(md5hash1)