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
				templateUrl: 'index.html',
				controller: 'MoviesController',
			)
			.when('/movies/new',
				templateUrl: 'form.html',
				controller: 'MovieController'
			)
			.when('/movies/:movieId',
				templateUrl: 'show.html',
				controller: 'MovieController'
			)
			.when('/movies/:movieId/edit',
				templateUrl: 'form.html',
				controller: 'MovieController'
			)

		flashProvider.errorClassnames.push('alert-danger')
		flashProvider.warnClassnames.push('alert-warning')
		flashProvider.infoClassnames.push('alert-info')
		flashProvider.successClassnames.push('alert-success')
])

controllers = angular.module('controllers', [])
