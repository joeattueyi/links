mysql = require 'mysql'
pool = mysql.createPool( 
	host: 'testdb.cxploeysj4ic.us-west-2.rds.amazonaws.com',
	user: 'joeatt',
	database: 'testdb'
	password: 'qwerty123'
)

hash = require('./utils/nh').hasher

db = require('./utils/db_provider')





module.exports.home = (req,res) ->
	if req.sesh.user_id
		res.redirect 'user/'+req.sesh.user_id
		return
	else	
		res.render 'main.ejs'
		return
	return

module.exports.login = (req, res) ->
	res.render 'login.ejs'
	return

#get username, hash & salt from db, check if 
module.exports.plogin = (req, res)->
	sql = 'select username, hash, salt, user_id from users where email = ?'
	db.findUser req.body.email, sql, (err, results)->
		if results.length > 0
			salt = new Buffer results[0].salt, 'hex'
			hash {plaintext: req.body.password, salt: salt}, (err, r) ->
				if (r.key.toString('hex') is results[0].hash)
					req.sesh.user_id = results[0].user_id
					req.sesh.username = results[0].username
					res.json {id: results[0].user_id}
					return
				res.json {id: 'fail'} if (r.key.toString('hex') isnt results[0].hash)
				return
		else 
			res.json {id: 'fail'}
		

		return
	return
	

module.exports.signup = (req, res) ->
	res.render 'signup.ejs'
	return

module.exports.psignup = (req, res) ->
	user = {}
	user.username = req.body.username
	user.email = req.body.email
	hash({plaintext: req.body.password} , (err, r)->
		console.log(err) if err
		user.salt = r.salt.toString('hex')
		user.hash = r.key.toString('hex')
		return
	)
	db.makeUser user, (err, result)->
		res.json({id: 'fail'}) if err
		res.json({id: 'good'}) if not err
		return
	return

module.exports.user = (req, res) ->
	sql = 'select * from links where link_poster = ?'

	db.findLinksByUser req.sesh.user_id, sql, (err, result)->
		res.json {id: 'fail'} if err
		res.render 'user.ejs', {data: result, user: req.sesh.username} if not err
		return
	return

module.exports.link = (req, res) ->
	res.render 'link.ejs'
	
	return

module.exports.plink = (req, res) ->
	#save in the database
	
	link = {}
	link.link_url = req.body.link
	link.link_title = req.body.title
	link.link_description = req.body.description
	link.link_date = new Date()
	link.link_poster = req.sesh.user_id
	db.makeLink link, (err, result)->
		console.log result
		res.json {id: 'fail'} if err
		res.json {id: 'good'} if not err
		return
	return


module.exports.logout = (req, res)->
	req.sesh.reset()
	res.redirect '/'



module.exports.test = (req, res)->
	res.json {"id": req.sesh.user_id, "name": "peter" }
	return






