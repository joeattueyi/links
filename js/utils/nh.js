// Generated by CoffeeScript 1.7.1
(function() {
  var crypto, hasher;

  crypto = require('crypto');

  hasher = function(opts, callback) {

    /*
    if not opts.plaintext
      return crypto.randomBytes 6, (err, buf) ->
        callback err if err
        opts.plaintext = buf.toString 'base64'
        hasher opts, callback
     */
    var _ref;
    if (!opts.salt) {
      return crypto.randomBytes(64, function(err, buf) {
        if (err) {
          callback(err);
        }
        opts.salt = buf;
        return hasher(opts, callback);
      });
    }
    opts.hash = 'sha1';
    opts.iterations = (_ref = opts.iterations) != null ? _ref : 10000;
    return crypto.pbkdf2(opts.plaintext, opts.salt, opts.iterations, 64, function(err, key) {
      if (err) {
        callback(err);
      }
      opts.key = new Buffer(key);
      callback(null, opts);
    });
  };

  module.exports.hasher = hasher;

}).call(this);