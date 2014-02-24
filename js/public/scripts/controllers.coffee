AppControllers = angular.module 'AppControllers', []

AppControllers.controller 'LoginCtrl', ['$scope', '$http', '$window', ($scope, $http, $window) ->
	$scope.err = true

	$scope.send = ()->
		if $scope.email and $scope.password
			$http.post('/login', {email: $scope.email, password: $scope.password}).success((data)->
				if data.id isnt 'fail'
					$window.location.href = '/user/'+data.id
					return
				if data.id is 'fail'
					$scope.err = false
					return
				return
			).error((data)->
				$scope.err = false
				return
			)
			return
		else 
			$scope.err = false
		return
	return
]

AppControllers.controller 'SignupCtrl', ['$scope', '$http', '$window',($scope, $http, $window) ->
	$scope.err = true
	
	$scope.send = ()->
		if $scope.username and $scope.email and $scope.password
			$http.post('/signup', {username: $scope.username, email: $scope.email, password: $scope.password}).success((data)->
				if data.id is 'fail'
					$scope.err = false
					return
				if data.id is 'good'
					$window.location.href = '/login'
					return
				return
			).error((data)->
				$scope.err = false
				return
			)
			return
		else
			$scope.err = false
		return
	return
]

AppControllers.controller 'LinkPostCtrl', ['$scope', '$http', '$window', ($scope, $http, $window)->
	
	$scope.err = true
	$scope.done = true

	$scope.post = ()->
		if $scope.link and $scope.description
			$http.post('/link', {link: $scope.link, title: $scope.title, description: $scope.description}).
			success((data)->
				if data.id is 'good'
					$window.location.href = '/'
					return
				if data.id is 'fail'
					$scope.err = false
			).
			error((data)->
				$scope.err = false
				return
			)
			return
		return
	return
]

#signup.ejs, user.ejs, link.ejs