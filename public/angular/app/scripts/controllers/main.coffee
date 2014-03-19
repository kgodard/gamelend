'use strict'

class MainCtrl

  constructor: (@$scope, @webService, @storageService) ->
    @setup()

  setup: ->
    @getData()

  getData: ->
    promise = @webService.getGreeting()
    promise.then @success, @error

    # games = @webService.getGames()
    # games.then @setGames, @error

  # setGames: (response) =>
  #   @$scope.games = response.data

  success: (response) =>
    @$scope.$broadcast("notify", {message: "Welcome back :)"})
    @$scope.message = response.data.message

  error: (response) =>
    console.log "error"
    @$scope.message = "Error retrieving data from server!"


MainCtrl.$inject = ["$scope", "webService", "storageService"]
angular.module("gamelendApp").controller "MainCtrl", MainCtrl
