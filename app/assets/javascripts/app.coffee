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
			.when('/recipes/:recipeId',
				templateUrl: 'show.html',
				controller: 'MovieController'
			)
])

controllers = angular.module('controllers', [])
