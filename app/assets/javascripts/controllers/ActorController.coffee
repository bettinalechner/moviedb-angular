controllers = angular.module('controllers')
controllers.controller('ActorController', [ '$scope', '$routeParams', '$resource', 'flash', '$location',
	($scope, $routeParams, $resource, flash, $location)->
		Actor = $resource('/actors/:actorId', { actorId: "@id", format: 'json' }, {
			'save': { method: 'PUT'},
			'create': { method: 'POST'}
		})

		if $routeParams.actorId
			Actor.get({ actorId: $routeParams.actorId },
				( (actor)-> $scope.actor = actor ),
				( (httpResponse)-> 
					$scope.actor = null
					flash.error = "There is no actor with ID #{$routeParams.actorId}"
				)
			)
		else
			$scope.actor = {}

		$scope.back = -> $location.path('/actors')
		$scope.edit = -> $location.path("/actors/#{$scope.actor.id}/edit")
		$scope.cancel = ->
			if $scope.actor.id
				$location.path("/actors/#{$scope.actor.id}")
			else
				$location.path('/actors')
		$scope.save = ->
			onError = (_httpResponse)-> flash.error = 'Something went wrong!'
			if $scope.actor.id
				$scope.actor.$save(
					( ()-> $location.path("/actors/#{$scope.actor.id}") ), onError
				)
			else
				Actor.create($scope.actor,
					( (newActor)-> $location.path("/actors/#{newActor.id}") ), onError
				)
		$scope.delete = ->
			$scope.actor.$delete()
			$scope.back()
])