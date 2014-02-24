
hash = require('./utils/nh').hasher

user = {}
user.name = 'joe'
user.email = 'jo4reel@yahoo.com'
user.password = 'secret'

hash {plaintext: user.password}, (err, result)->
	console.log err if err
	user.salt = result.salt.toString 'hex'
	user.key = result.key.toString 'hex'
	console.log user.salt
	console.log user.key
	console.log typeof user.salt
	salt = new Buffer user.salt, 'hex'	
	hash {plaintext: user.password, salt: salt}, (err, result)->
		console.log err if err
		console.log 'YES' if result.key.toString('hex') is user.key
		return
	return

