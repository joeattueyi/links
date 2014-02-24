redis = require('redis')
client = redis.createClient()
client.auth('')
console.log 'welcome ~~/\~~'

client.on 'error', (err)->
	console.log 'error: '+ err
	return
###
client.hmset('user:2', 
	'username': 'joe'
	'email': 'jo4reel@yahoo.com'
	'no_links': 1
)

client.hmset('user:3',
	'username': 'ezzie'
	'email': 'ez@gmail.com'
	'no_links': 0
)
###

client.hgetall 'user:2', (err, replies)->
	console.log err if err
	console.log replies

client.quit()

