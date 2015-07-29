controllers = angular.module('controllers')
controllers.controller('MovieController', ['$scope', '$routeParams', '$resource', '$location', 'flash'
	($scope, $routeParams, $resource, $location, flash)->
		Movie = $resource('/movies/:movieId', { movieId: "@id", format: 'json' }, {
			'save': { method: 'PUT' },
			'create': { method: 'POST' }
		})

		if $routeParams.movieId
			Movie.get({ movieId: $routeParams.movieId },
				( (movie) -> $scope.movie = movie.movie ),
				( (httpResponse) -> 
					$scope.movie = null
					flash.error = "There is no movie with ID #{$routeParams.movieId}"
				)
			)
		else
			$scope.movie = {}

		$scope.actor = (id) -> $location.path("/actors/#{id}")
		$scope.back = -> $location.path('/')
		$scope.edit = -> $location.path("/movies/#{$scope.movie.id}/edit")
		$scope.cancel = ->
			if $scope.movie.id
				$location.path("/movies/#{$scope.movie.id}")
			else
				$location.path('/')

		$scope.save = ->
			onError = (_httpResponse_) -> flash.error = 'Something went wrong.'
			if $scope.movie.id
				$scope.movie.$save(
					(() -> $location.path("/movies/#{$scope.movie.id}")), onError
				)
			else
				Movie.create($scope.movie,
					((newMovie) -> $location.path("/movies/#{newMovie.id}")), onError
				)

		$scope.delete = ->
			$scope.movie.$delete()
			$scope.back()
])