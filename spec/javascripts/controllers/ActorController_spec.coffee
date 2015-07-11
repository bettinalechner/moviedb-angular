describe 'ActorController', ->
	scope = null
	location = null
	httpBackend = null
	routeParams = null
	ctrl = null
	flash = null
	actorId = 42

	fakeActor =
		id: actorId
		firstName: 'Uma'
		lastName: 'Thurman'
		dateOfBirth: '1970-04-29'

	setupController =(actorExists = true)->
		inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
			scope = $rootScope.$new()
			location = $location
			httpBackend = $httpBackend
			routeParams = $routeParams
			routeParams.actorId = actorId
			flash = _flash_

			request = new RegExp("\/actors/#{actorId}")
			results = if actorExists
				[200, fakeActor]
			else
				[404]

			httpBackend.expectGET(request).respond(results[0], results[1])

			ctrl = $controller('ActorController',
													$scope: scope)
		)

	beforeEach(module('moviedb'))

	afterEach ->
		httpBackend.verifyNoOutstandingExpectation()
		httpBackend.verifyNoOutstandingRequest()

	describe 'controller initialization', ->
		describe 'actor is found', ->
			beforeEach(setupController())

			it 'loads the given actor', ->
				httpBackend.flush()
				expect(scope.actor).toEqualData(fakeActor)

		describe 'actor is not found', ->
			beforeEach(setupController(false))

			it 'loads no actor', ->
				httpBackend.flush()
				expect(scope.actor).toBe(null)
				expect(flash.error).toBe("There is no actor with ID #{actorId}")