
app = angular.module 'app', ['AppControllers', 'ngRoute']


app.config ['$routeProvider', ($routeProvider) ->
	$routeProvider.when '/login', controller: 'LoginCtrl'
	.when '/signup', controller: 'SignupCtrl'
	.when '/link', controller: 'LinkPostCtrl'
	.otherwise redirectTo: '/'
	return
]



