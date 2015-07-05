describe 'MovieController', ->
	scope = null
	ctrl = null
	routeParams = null
	httpBackend = null
	movieId = 42

	fakeMovie =
		id: movieId
		title: 'Serenity'
		year: '2005'
		rating: 8


	setupController =(movieExists=true)->
		inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
			scope = $rootScope.$new()
			location = $location
			httpBackend = $httpBackend
			routeParams = $routeParams
			routeParams.movieId = movieId

			request = new RegExp("\/movies/#{movieId}")
			results = if movieExists
				[200, fakeMovie]
			else
				[404]

			httpBackend.expectGET(request).respond(results[0], results[1])

			ctrl = $controller('MovieController',
												 $scope: scope)
		)

	beforeEach(module('moviedb'))

	afterEach ->
		httpBackend.verifyNoOutstandingExpectation()
		httpBackend.verifyNoOutstandingRequest()

	describe 'controller initializiation', ->
		describe 'movie is found', ->
			beforeEach(setupController())

			it 'loads the given movie', ->
				httpBackend.flush()
				expect(scope.movie).toEqualData(fakeMovie)

		describe 'movie is not found', ->
			beforeEach(setupController(false))

			it 'loads the given movie', ->
				httpBackend.flush()
				expect(scope.movie).toBe(null)