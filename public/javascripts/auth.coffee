_ = require('lodash')
crypto = require('crypto');
$ = require('jquery');

$('#btn-signup').prop('disabled', true);

md5 = (text) -> crypto.createHash('md5').update(text).digest("hex")

encryptPassword = (e)->
  $('#password').val md5 $('#password').val()

passwordIsTheSame = -> $('#password-repeat').val() == $('#password').val()

passwordIsLongerEnough = -> $('#password').val().length >= 6

passwordRepeatIsEmpty = -> $('#password-repeat').val().length == 0

hasUsername = -> $('#username').val().length > 0

hasFullname = -> $('#fullname').val().length > 0


signupSubmit = ->
  $('#signup-form').submit()
  false
loginSubmit = ->
  $('#login-form').submit() if passwordIsLongerEnough()
  false


$('#btn-login').click _.flow(encryptPassword, loginSubmit)
$('#btn-signup').click _.flow(passwordIsTheSame, encryptPassword, signupSubmit)

$('#password, #password-repeat').change (e) ->
  if passwordIsTheSame()
    $('.error-password-match').hide()
  else if !passwordRepeatIsEmpty()
    $('.error-password-match').show()

$('#password, #password-repeat').bind 'input', (e) ->
  if passwordIsLongerEnough() && passwordIsTheSame() && hasUsername() && hasFullname()
    $('#btn-signup').prop('disabled', false);
  else
    $('#btn-signup').prop('disabled', true);

$('#password').change (e) ->
  if passwordIsLongerEnough()
    $('.error-password-length').hide()
  else
    $('.error-password-length').show()

$('#username').change (e) ->
  if hasUsername()
    $('.error-phone-required').hide()
  else
    $('.error-phone-required').show()

$('#fullname').change (e) ->
  if hasFullname()
    $('.error-name-required').hide()
  else
    $('.error-name-required').show()

