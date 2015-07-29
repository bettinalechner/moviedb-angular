controllers = angular.module('controllers')
controllers.controller('RoleController', ['$scope', '$routeParams', '$resource', 'flash', '$location',
	($scope, $routeParams, $resource, flash, $location)->
		Role = $resource('/roles/:roleId', { roleId: "@id", format: 'json' }, {
			'save': { method: 'PUT' },
			'create': { method: 'POST' }
		})

		if $routeParams.roleId
			Role.get({ roleId: $routeParams.roleId },
				( (role)-> $scope.role = role ),
				( (httpResponse)->
					$scope.role = null
					flash.error = "There is no role with ID #{$routeParams.roleId}"
				)
			)
		else
			$scope.role = {}
])