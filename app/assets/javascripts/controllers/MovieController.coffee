controllers = angular.module('controllers')
controllers.controller('MovieController', ['$scope', '$routeParams', '$resource', '$location', 'flash'
	($scope, $routeParams, $resource, $location, flash)->
		Movie = $resource('/movies/:movieId', { movieId: "@id", format: 'json' })

		Movie.get({ movieId: $routeParams.movieId },
			( (movie) -> $scope.movie = movie ),
			( (httpResponse) -> 
				$scope.movie = null
				flash.error = "There is no movie with ID #{$routeParams.movieId}"
			)
		)

		$scope.back = -> $location.path('/')
])