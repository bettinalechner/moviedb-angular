controllers = angular.module('controllers')
controllers.controller('MovieController', ['$scope', '$routeParams', '$resource'
	($scope, $routeParams, $resource)->
		Movie = $resource('/movies/:movieId', { movieId: "@id", format: 'json' })

		Movie.get({ movieId: $routeParams.movieId },
			( (movie) -> $scope.movie = movie ),
			( (httpResponse) -> $scope.movie = null )
		)
])