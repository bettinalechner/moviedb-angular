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

		flashProvider.errorClassnames.push('alert-danger')
		flashProvider.warnClassnames.push('alert-warning')
		flashProvider.infoClassnames.push('alert-info')
		flashProvider.successClassnames.push('alert-success')
])

actors = [
	{
		id: 1
		firstName: 'Uma'
		lastName: 'Thurman'
	},
	{
		id: 2
		firstName: 'Lucy'
		lastName: 'Liu'
	},
	{
		id: 3
		firstName: 'John'
		lastName: 'Travolta'
	}
]

controllers = angular.module('controllers', [])
controllers.controller('ActorsController', [ '$scope', '$routeParams', '$location'
	($scope, $routeParams, $location)->
		$scope.search = (keywords)-> $location.path('/actors').search('keywords', keywords)

		if $routeParams.keywords
			keywords = $routeParams.keywords.toLowerCase()
			$scope.actors = actors.filter (actor)-> actor.firstName.toLowerCase().indexOf(keywords) != -1
		else
			$scope.actors = []
])