
mysql = require 'mysql'
pool = mysql.createPool( 
	host: 'testdb.cxploeysj4ic.us-west-2.rds.amazonaws.com',
	user: 'joeatt',
	database: 'testdb'
	password: 'qwerty123'
)


getConnection = (callback)->
	pool.getConnection (err, conn)->
		callback err if err
		callback null , conn
		conn.release()
		return	
	return

module.exports.findLinksByUser = (user, sql, callback)->
	getConnection (err, conn)->
		callback err if err
		conn.query sql, [user], (err, result)->
			callback err if err
			callback null , result
			return
		return
	return

module.exports.makeLink = (link, callback)->
	getConnection (err, conn)->	
		callback err if err
		conn.query 'insert into links set ?', link, (err, result)->
			callback err if err
			callback null, result
			return
		return
	return


module.exports.findUser = (user, sql, callback)->
	getConnection (err, conn)->
		callback err if err
		conn.query sql, [user], (err, results)->
			callback err if err
			callback null, results
			return
		return
	return

module.exports.makeUser = (user, callback) ->
	getConnection (err, conn)->
		callback err if err
		conn.query 'select user_id from users where username = ? or email= ?', [user.username, user.email], (err, results)->
			callback if err
			if results.length is 0
				conn.query 'insert into users set ?', user, (err, results)->
					callback err if err
					callback null, results
					return
			return	
		return
	return








