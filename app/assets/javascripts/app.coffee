moviedb = angular.module('moviedb', [
	'templates',
	'ngRoute',
	'ngResource',
	'controllers',
	'angular-flash.service',
	'angular-flash.flash-alert-directive'
])

moviedb.config([ '$routeProvider', 'flashProvider',
	($routeProvider, flashProvider)->
		$routeProvider
			.when('/',
				templateUrl: 'movies/index.html',
				controller: 'MoviesController',
			)
			.when('/movies/new',
				templateUrl: 'movies/form.html',
				controller: 'MovieController'
			)
			.when('/movies/:movieId',
				templateUrl: 'movies/show.html',
				controller: 'MovieController'
			)
			.when('/movies/:movieId/edit',
				templateUrl: 'movies/form.html',
				controller: 'MovieController'
			)
			.when('/actors',
				templateUrl: 'actors/index.html',
				controller: 'ActorsController'
			)
			.when('/actors/new',
				templateUrl: 'actors/form.html',
				controller: 'ActorController'
			)
			.when('/actors/:actorId',
				templateUrl: 'actors/show.html',
				controller: 'ActorController'
			)
			.when('/actors/:actorId/edit',
				templateUrl: 'actors/form.html',
				controller: 'ActorController'
			)

		flashProvider.errorClassnames.push('alert-danger')
		flashProvider.warnClassnames.push('alert-warning')
		flashProvider.infoClassnames.push('alert-info')
		flashProvider.successClassnames.push('alert-success')
])

controllers = angular.module('controllers', [])