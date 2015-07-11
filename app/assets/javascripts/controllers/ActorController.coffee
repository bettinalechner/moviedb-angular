controllers = angular.module('controllers')
controllers.controller('ActorController', [ '$scope', '$routeParams', '$resource',
	($scope, $routeParams, $resource)->
		Actor = $resource('/actors/:actorId', { actorId: "@id", format: 'json' })

		Actor.get({ actorId: $routeParams.actorId },
			( (actor)-> $scope.actor = actor ),
			( (httpResponse)-> $scope.actor = null )
		)
])