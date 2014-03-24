'use strict'

class GamesCtrl

  constructor: (@$scope, @webService) ->
    @setup()

  setup: ->
    @blankGame = { title: '', system: '', developer: '' }
    @clearGameAttrs()
    @$scope.sortOrder = 'title'
    @$scope.createGame = @createGame
    @$scope.updateGame = @updateGame
    @$scope.deleteGame = @deleteGame
    @$scope.clearGameAttrs = @clearGameAttrs
    @$scope.getGames = @getGames
    @$scope.getGame = @getGame
    @$scope.isUnchanged = @isUnchanged
    @$scope.systems = [
      'PS3', 'Xbox 360', 'PC',
      'PS4', 'Xbox One', 'Wii',
      'Wii U'
    ]
    @getGames()

  isUnchanged: (game) =>
    angular.equals(game, {})

  getGame: (id) =>
    promise = @webService.getGame(id)
    promise.then @loadGame, @error

  loadGame: (result) =>
    # console.log "#{JSON.stringify(result.data)}"
    @$scope.game = angular.copy(result.data)

  getGames: =>
    games = @webService.getGames()
    games.then @setGames, @error

  setGames: (response) =>
    @$scope.games = response.data

  createGame: (game) =>
    promise = @webService.createGame(game)
    promise.then @gameSaved, @error

  updateGame: (game) =>
    promise = @webService.updateGame(game)
    promise.then @gameSaved, @error

  deleteGame: (id) =>
    promise = @webService.deleteGame(id)
    promise.then @gameDeleted, @error

  gameDeleted: =>
    @getGames()

  gameSaved: =>
    @clearGameAttrs()
    @getGames()

  clearGameAttrs: =>
    @$scope.game = angular.copy(@blankGame)

  error: (response) =>
    console.log response
    @$scope.message = response.message

GamesCtrl.$inject = ["$scope", "webService"]
angular.module("gamelendApp").controller "GamesCtrl", GamesCtrl
