'use strict'

class GamesCtrl

  constructor: (@$scope, @webService) ->
    @setup()

  setup: ->
    @blankGame = { title: '', system: '', developer: '' }
    @clearGameAttrs()
    @$scope.sortOrder = 'title'
    @$scope.createGame = @createGame
    @$scope.clearGameAttrs = @clearGameAttrs
    @$scope.getGames = @getGames
    @$scope.isUnchanged = @isUnchanged
    @$scope.systems = [
      'PS3', 'Xbox 360', 'PC',
      'PS4', 'Xbox One', 'Wii',
      'Wii U'
    ]
    @getGames()

  isUnchanged: (game) =>
    angular.equals(game, {})

  getGames: =>
    games = @webService.getGames()
    games.then @setGames, @error

  setGames: (response) =>
    @$scope.games = response.data

  createGame: (game) =>
    promise = @webService.createGame(game)
    promise.then @gameCreated, @error

  gameCreated: =>
    @clearGameAttrs()
    @getGames()

  clearGameAttrs: =>
    @$scope.game = angular.copy(@blankGame)

  error: (response) =>
    console.log response
    @$scope.message = response.message

GamesCtrl.$inject = ["$scope", "webService"]
angular.module("gamelendApp").controller "GamesCtrl", GamesCtrl
