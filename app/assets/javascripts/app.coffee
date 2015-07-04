moviedb = angular.module('moviedb', [
	'templates',
	'ngRoute',
	'controllers'
])

moviedb.config([ '$routeProvider',
	($routeProvider)->
		$routeProvider
			.when('/',
				templateUrl: 'index.html'
				controller: 'MoviesController'
			)
])

controllers = angular.module('controllers', [])
controllers.controller('MoviesController', ['$scope', 
	($scope)->
])