cs = (name)->
	(req, res, next)->
		req.session = req.signedCookies[name] or {}

		res.on 'header', ()->
			res.signesCookie(name, req.session, {signed: true})
		next()
		return

module.exports = cs	