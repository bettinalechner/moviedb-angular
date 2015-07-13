controllers = angular.module('controllers')
controllers.controller('ActorsController', [ '$scope', '$routeParams', '$location', '$resource'
	($scope, $routeParams, $location, $resource)->
		$scope.search = (keywords)-> $location.path('/actors').search('keywords', keywords)
		Actor = $resource('/actors/:actorId', { actorId: "@id", format: 'json' })

		if $routeParams.keywords
			Actor.query(keywords: $routeParams.keywords, (results)-> $scope.actors = results)
		else
			$scope.actors = []

		$scope.view = (actorId)-> $location.path("/actors/#{actorId}")
		$scope.newActor = -> $location.path('/actors/new')
		$scope.edit = (actorId)-> $location.path("/actors/#{actorId}/edit")
])