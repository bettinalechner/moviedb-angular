controllers = angular.module('controllers')
controllers.controller('MoviesController', ['$scope', '$routeParams', '$location', '$resource'
	($scope, $routeParams, $location, $resource)->
		$scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
		$scope.view = (movieId) -> $location.path("/movies/#{movieId}")
		
		Movie = $resource('/movies/:movieId', { movieId: "@id", format: 'json' })

		if $routeParams.keywords
			Movie.query(keywords: $routeParams.keywords, (results)-> $scope.movies = results)
		else
			$scope.movies = []
])