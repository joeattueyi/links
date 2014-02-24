// Generated by CoffeeScript 1.7.1
(function() {
  var db, hash, mysql, pool;

  mysql = require('mysql');

  pool = mysql.createPool({
    host: 'testdb.cxploeysj4ic.us-west-2.rds.amazonaws.com',
    user: 'joeatt',
    database: 'testdb',
    password: 'qwerty123'
  });

  hash = require('./utils/nh').hasher;

  db = require('./utils/db_provider');

  module.exports.home = function(req, res) {
    if (req.sesh.user_id) {
      res.redirect('user/' + req.sesh.user_id);
      return;
    } else {
      res.render('main.ejs');
      return;
    }
  };

  module.exports.login = function(req, res) {
    res.render('login.ejs');
  };

  module.exports.plogin = function(req, res) {
    var sql;
    sql = 'select username, hash, salt, user_id from users where email = ?';
    db.findUser(req.body.email, sql, function(err, results) {
      var salt;
      if (results.length > 0) {
        salt = new Buffer(results[0].salt, 'hex');
        hash({
          plaintext: req.body.password,
          salt: salt
        }, function(err, r) {
          if (r.key.toString('hex') === results[0].hash) {
            req.sesh.user_id = results[0].user_id;
            req.sesh.username = results[0].username;
            res.json({
              id: results[0].user_id
            });
            return;
          }
          if (r.key.toString('hex') !== results[0].hash) {
            res.json({
              id: 'fail'
            });
          }
        });
      } else {
        res.json({
          id: 'fail'
        });
      }
    });
  };

  module.exports.signup = function(req, res) {
    res.render('signup.ejs');
  };

  module.exports.psignup = function(req, res) {
    var user;
    user = {};
    user.username = req.body.username;
    user.email = req.body.email;
    hash({
      plaintext: req.body.password
    }, function(err, r) {
      if (err) {
        console.log(err);
      }
      user.salt = r.salt.toString('hex');
      user.hash = r.key.toString('hex');
    });
    db.makeUser(user, function(err, result) {
      if (err) {
        res.json({
          id: 'fail'
        });
      }
      if (!err) {
        res.json({
          id: 'good'
        });
      }
    });
  };

  module.exports.user = function(req, res) {
    var sql;
    sql = 'select * from links where link_poster = ?';
    db.findLinksByUser(req.sesh.user_id, sql, function(err, result) {
      if (err) {
        res.json({
          id: 'fail'
        });
      }
      if (!err) {
        res.render('user.ejs', {
          data: result,
          user: req.sesh.username
        });
      }
    });
  };

  module.exports.link = function(req, res) {
    res.render('link.ejs');
  };

  module.exports.plink = function(req, res) {
    var link;
    link = {};
    link.link_url = req.body.link;
    link.link_title = req.body.title;
    link.link_description = req.body.description;
    link.link_date = new Date();
    link.link_poster = req.sesh.user_id;
    db.makeLink(link, function(err, result) {
      console.log(result);
      if (err) {
        res.json({
          id: 'fail'
        });
      }
      if (!err) {
        res.json({
          id: 'good'
        });
      }
    });
  };

  module.exports.logout = function(req, res) {
    req.sesh.reset();
    return res.redirect('/');
  };

  module.exports.test = function(req, res) {
    res.json({
      "id": req.sesh.user_id,
      "name": "peter"
    });
  };

}).call(this);
