var express, router;

express = require('express');

router = express.Router();


/* GET users listing. */

router.get('/', function(req, res, next) {
  res.send('respond with a users');
});

module.exports = router;
