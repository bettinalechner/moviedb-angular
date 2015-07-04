moviedb = angular.module('moviedb', [
	'templates',
	'ngRoute',
	'ngResource',
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
