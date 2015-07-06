describe 'MoviesController', ->
	scope = null
	ctrl = null
	location = null
	routeParams = null
	resource = null
	httpBackend = null

	setupController =(keywords,results)->
		inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
			scope = $rootScope.$new()
			location = $location
			resource = $resource
			routeParams = $routeParams
			routeParams.keywords = keywords
			httpBackend = $httpBackend

			if results
				request = new RegExp("\/?keywords=#{keywords}")
				httpBackend.expectGET(request).respond(results)

			ctrl = $controller('MoviesController',
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

			it 'defaults to no movies', ->
				expect(scope.movies).toEqualData([])

		describe 'with keywords', ->
			keywords = 'foo'
			movies = [
				{
					id: 1
					title: 'Pulp Fiction'
					year: '1994'
					rating: 9
				},
				{
					id: 4
					title: 'Kill Bill: Vol. 2'
					year: '2003'
					rating: 8
				}
			]

			beforeEach ->
				setupController(keywords,movies)
				# resolve asynchronous promises
				httpBackend.flush()

			it 'calls the back-end', ->
				expect(scope.movies).toEqualData(movies)

	describe 'search()', ->
		beforeEach ->
			setupController()

		it 'redirects to itself with a keyword param', ->
			keywords = 'foo'
			scope.search(keywords)
			expect(location.path()).toBe('/')
			expect(location.search()).toEqualData({ keywords: keywords })