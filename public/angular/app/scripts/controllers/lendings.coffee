'use strict'

class LendingsCtrl

  constructor: (@$scope, @webService) ->
    @setup()

  setup: ->
    @$scope.createLending = @createLending
    @getUsers()

  createLending: (lending) =>
    promise = @webService.createLending(lending)
    promise.then @lendingSaved, @error

  lendingSaved: =>
    console.log "saved lending"

  getUsers: =>
    users = @webService.getUsers()
    users.then @setUsers, @error

  setUsers: (response) =>
    @$scope.users = response.data

  error: (response) =>
    console.log response
    @$scope.message = response.message

LendingsCtrl.$inject = ["$scope", "webService"]
angular.module("gamelendApp").controller "LendingsCtrl", LendingsCtrl

