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

movies = [
	{
		id: 1
		name: 'Pulp Fiction'
	},
	{
		id: 2
		name: 'Kill Bill Vol. 1'
	}
]

controllers = angular.module('controllers', [])
controllers.controller('MoviesController', ['$scope', '$routeParams', '$location', '$resource'
	($scope, $routeParams, $location, $resource)->
		$scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
		Movie = $resource('/movies/:movieId', { movieId: "@id", format: 'json' })

		if $routeParams.keywords
			Movie.query(keywords: $routeParams.keywords, (results)-> $scope.movies = results)
		else
			$scope.movies = []
])