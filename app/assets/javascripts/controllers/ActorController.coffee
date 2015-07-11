controllers = angular.module('controllers')
controllers.controller('ActorController', [ '$scope', '$routeParams', '$resource', 'flash',
	($scope, $routeParams, $resource, flash)->
		Actor = $resource('/actors/:actorId', { actorId: "@id", format: 'json' })

		Actor.get({ actorId: $routeParams.actorId },
			( (actor)-> $scope.actor = actor ),
			( (httpResponse)-> 
				$scope.actor = null
				flash.error = "There is no actor with ID #{$routeParams.actorId}"
			)
		)
])