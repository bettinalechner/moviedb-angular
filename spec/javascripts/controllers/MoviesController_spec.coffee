describe 'MoviesController', ->
	scope = null
	ctrl = null
	location = null
	routeParams = null
	resource = null

	setupController =(keywords)->
		inject(($location, $routeParams, $rootScope, $resource, $controller)->
			scope = $rootScope.$new()
			location = $location
			resource = $resource
			routeParams = $routeParams
			routeParams.keywords = keywords

			ctrl = $controller('MoviesController',
													$scope: scope,
													$location: location)
		)

	beforeEach(module('moviedb'))
	beforeEach(setupController())

	it 'defaults to no movies', ->
		expect(scope.movies).toEqualData([])