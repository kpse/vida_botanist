_ = require('lodash')
crypto = require('crypto');
$ = require('jquery');

md5 = (text) -> crypto.createHash('md5').update(text).digest("hex")

encryptPassword = (e)->
  $('#password').val md5 $('#password').val()
  console.log(password)

signupSubmit = ->
  $('#signup-form').submit()
  false
loginSubmit = ->
  $('#login-form').submit()
  false

$('#btn-login').click _.flow(encryptPassword, loginSubmit)
$('#btn-signup').click _.flow(encryptPassword, signupSubmit)