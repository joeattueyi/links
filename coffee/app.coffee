express = require 'express'
app = express()
routes = require('./routes.js')
helpers = require('express-helpers')(app)
cs = require('client-sessions')

app.set 'view engine', 'ejs'
app.set 'views', __dirname + '/views'
app.use express.static(__dirname, 'public')
app.use express.bodyParser()
app.use express.cookieParser('joey')
app.use express.session()
app.use cs
	secret: 'koyinsolaabaniwonda'
	cookieName: 'sesh'
	duration: 24*60*60*1000 

app.use app.router


restrict = (req, res, next)->
	if req.sesh.user_id
		next()
	else
		req.session.error = 'fail'
		res.redirect '/login'


#homepage
app.get '/', routes.home

#get login
app.get '/login', routes.login

#post login
app.post '/login', routes.plogin

#get signup
app.get '/signup', routes.signup

#post signup
app.post '/signup', routes.psignup

#make link
app.get '/link', routes.link

#post make link
app.post '/link', routes.plink

#get user
app.get '/user/:id',restrict, routes.user

#logout
app.get '/logout', routes.logout

#test
app.get '/test', routes.test

app.listen 1337, ()->
	console.log('listening on port 1337')
	return



