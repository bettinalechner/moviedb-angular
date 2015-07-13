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

	setupController =(actorExists = true, actorId = 42)->
		inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
			scope = $rootScope.$new()
			location = $location
			httpBackend = $httpBackend
			routeParams = $routeParams
			routeParams.actorId = actorId if actorId
			flash = _flash_

			if actorId
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

		describe 'create', ->
			newActor =
				id: 42
				firstName: 'Maggie'
				lastName: 'Smith'
				dateOfBirth: '1934-12-28'

			beforeEach ->
				setupController(false, false)
				request = new RegExp("\/actors")
				httpBackend.expectPOST(request).respond(201, newActor)

			it 'posts to the backend', ->
				scope.actor.firstName = newActor.firstName
				scope.actor.lastName = newActor.lastName
				scope.actor.dateOfBirth = newActor.dateOfBirth
				scope.save()
				httpBackend.flush()
				expect(location.path()).toBe("/actors/#{newActor.id}")

		describe 'update', ->
			updatedActor =
				firstName: 'Zoe'
				lastName: 'Saldana'

			beforeEach ->
				setupController()
				httpBackend.flush()
				request = new RegExp("\/actors")
				httpBackend.expectPUT(request).respond(204)

			it 'posts to the backend', ->
				scope.actor.firstName = updatedActor.firstName
				scope.actor.lastName = updatedActor.lastName
				scope.save()
				httpBackend.flush()
				expect(location.path()).toBe("/actors/#{scope.actor.id}")

		describe 'delete', ->
			beforeEach ->
				setupController()
				httpBackend.flush()
				request = new RegExp("\/actors/#{scope.actor.id}")
				httpBackend.expectDELETE(request).respond(204)

			it 'posts to the backend', ->
				scope.delete()
				httpBackend.flush()
				expect(location.path()).toBe('/actors')
