describe 'ActorsController', ->
	scope = null
	ctrl = null
	location = null
	routeParams = null
	resource = null
	httpBackend = null

	setupController = (keywords, results)->
		inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
			scope = $rootScope.$new()
			location = $location
			resource = $resource
			routeParams = $routeParams
			routeParams.keywords = keywords
			httpBackend = $httpBackend

			if results
				request = new RegExp("\/actors.*keywords=#{keywords}")
				httpBackend.expectGET(request).respond(results)

			ctrl = $controller('ActorsController',
												 $scope: scope
												 $location: location)
		)

	beforeEach(module('moviedb'))

	afterEach ->
		httpBackend.verifyNoOutstandingExpectation()
		httpBackend.verifyNoOutstandingRequest()

	describe 'controller initialization', ->
		describe 'when no keywords present', ->
			beforeEach(setupController())
				
			it 'defaults to no actors', ->
				expect(scope.actors).toEqualData([])

		describe 'with keywords', ->
			keywords = 'foo'
			actors = [
				{
					id: 1
					firstName: 'Uma'
					lastName: 'Thurman'
				},
				{
					id: 2
					firstName: 'Lucy'
					lastName: 'Liu'
				},
				{
					id: 3
					firstName: 'John'
					lastName: 'Travolta'
				}
			]

			beforeEach ->
				setupController(keywords, actors)
				httpBackend.flush()

			it 'calls the back-end', ->
				expect(scope.actors).toEqualData(actors)

		describe 'search()', ->
			beforeEach ->
				setupController()

			it 'redirects to itself with a keywords param', ->
				keywords = 'foo'
				scope.search(keywords)
				expect(location.path()).toBe('/actors')
				expect(location.search()).toEqualData({ keywords: keywords })