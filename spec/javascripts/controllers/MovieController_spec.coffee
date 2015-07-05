describe 'MovieController', ->
	scope = null
	ctrl = null
	routeParams = null
	httpBackend = null
	flash = null
	location = null
	movieId = 42

	fakeMovie =
		id: movieId
		title: 'Serenity'
		year: '2005'
		rating: 8


	setupController =(movieExists = true, movieId = 42)->
		inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
			scope = $rootScope.$new()
			location = $location
			httpBackend = $httpBackend
			routeParams = $routeParams
			routeParams.movieId = movieId if movieId
			flash = _flash_

			if movieId
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
				expect(flash.error).toBe("There is no movie with ID #{movieId}")

	describe 'create', ->
		newMovie =
			id: 42
			title: 'Serenity'
			year: '2005'
			rating: 8

		beforeEach ->
			setupController(false, false)
			request = new RegExp('\/movies')
			httpBackend.expectPOST(request).respond(201, newMovie)

		it 'posts to the backend', ->
			scope.movie.title = newMovie.title
			scope.movie.year = newMovie.year
			scope.movie.rating = newMovie.rating
			scope.save()
			httpBackend.flush()
			expect(location.path()).toBe("/movies/#{newMovie.id}")

	describe 'update', ->
		updatedMovie =
			title: 'Serenity'
			year: '2005'
			rating: 8

		beforeEach ->
			setupController()
			httpBackend.flush()
			request = new RegExp('\/movies')
			httpBackend.expectPUT(request).respond(204)

		it 'posts to the backend', ->
			scope.movie.title = updatedMovie.title
			scope.movie.year = updatedMovie.year
			scope.movie.rating = updatedMovie.rating
			scope.save()
			httpBackend.flush()
			expect(location.path()).toBe("/movies/#{scope.movie.id}")

	describe 'delete', ->
		beforeEach ->
			setupController()
			httpBackend.flush()
			request = new RegExp("\/movies/#{scope.movie.id}")
			httpBackend.expectDELETE(request).respond(204)

		it 'posts to the backend', ->
			scope.delete()
			httpBackend.flush()
			expect(location.path()).toBe('/')