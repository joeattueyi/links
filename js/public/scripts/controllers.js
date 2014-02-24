// Generated by CoffeeScript 1.7.1
(function() {
  var AppControllers;

  AppControllers = angular.module('AppControllers', []);

  AppControllers.controller('LoginCtrl', [
    '$scope', '$http', '$window', function($scope, $http, $window) {
      $scope.err = true;
      $scope.send = function() {
        if ($scope.email && $scope.password) {
          $http.post('/login', {
            email: $scope.email,
            password: $scope.password
          }).success(function(data) {
            if (data.id !== 'fail') {
              $window.location.href = '/user/' + data.id;
              return;
            }
            if (data.id === 'fail') {
              $scope.err = false;
              return;
            }
          }).error(function(data) {
            $scope.err = false;
          });
          return;
        } else {
          $scope.err = false;
        }
      };
    }
  ]);

  AppControllers.controller('SignupCtrl', [
    '$scope', '$http', '$window', function($scope, $http, $window) {
      $scope.err = true;
      $scope.send = function() {
        if ($scope.username && $scope.email && $scope.password) {
          $http.post('/signup', {
            username: $scope.username,
            email: $scope.email,
            password: $scope.password
          }).success(function(data) {
            if (data.id === 'fail') {
              $scope.err = false;
              return;
            }
            if (data.id === 'good') {
              $window.location.href = '/login';
              return;
            }
          }).error(function(data) {
            $scope.err = false;
          });
          return;
        } else {
          $scope.err = false;
        }
      };
    }
  ]);

  AppControllers.controller('LinkPostCtrl', [
    '$scope', '$http', '$window', function($scope, $http, $window) {
      $scope.err = true;
      $scope.done = true;
      $scope.post = function() {
        if ($scope.link && $scope.description) {
          $http.post('/link', {
            link: $scope.link,
            title: $scope.title,
            description: $scope.description
          }).success(function(data) {
            if (data.id === 'good') {
              $window.location.href = '/';
              return;
            }
            if (data.id === 'fail') {
              return $scope.err = false;
            }
          }).error(function(data) {
            $scope.err = false;
          });
          return;
        }
      };
    }
  ]);

}).call(this);