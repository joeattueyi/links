/*var mysql = require('mysql');

var pool = mysql.createPool({
	host: 'testdb.cxploeysj4ic.us-west-2.rds.amazonaws.com',
	user: 'joeatt',
	password: 'qwerty123',
	database: 'testdb'
});

pool.getConnection(function(err, conn){
	if (err) console.log(err);
	conn.query('select * from users', function(err, rows){
		for (var i =0; i<rows.length;i++){
			console.log(rows[i]['user_id']);
			console.log(rows[i]['user_name']);
			console.log(rows[i]['user_description']);
			console.log("_-_-_-_-_-_-_-_-_-_-_")
		}
		conn.destroy();
	})
}); */

//username,email, hash, salt, user id, description, no_of_links


//link id, url, poster, tags, collection
var hash = require('./utils/hash').hash

hash('a', function(err, salt, hash){                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
  if (err) throw err;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
  // store the salt & hash in the "db"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
  console.log(salt.length);
  console.log("JOSEPH CHUKwuka Attueyi".length);
  console.log(hash.toString().length);
}); 

create table links(
link_id INT NOT NULL AUTO_INCREMENT,
link_url VARCHAR(255) NOT NULL,
link_title VARCHAR(100) NOT NULL,
link_description VARCHAR(255),
link_date DATE,
link_poster INT NOT NULL,
PRIMARY KEY (link_id)
);


