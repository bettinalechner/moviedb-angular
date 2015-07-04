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

		if $routeParams.keywords
			keywords = $routeParams.keywords.toLowerCase()
			$scope.movies = movies.filter (movie)-> movie.name.toLowerCase().indexOf(keywords) != -1
		else
			$scope.movies = []
])