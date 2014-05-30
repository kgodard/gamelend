'use strict'

class WebService

  constructor: (@$http, @storageService) ->
    @baseUrl = "/api/v1/"

  createLending: (lending) ->
    @$http.post(@baseUrl + "lendings", {lending: {game_id: lending.gameId, borrower_id: lending.borrower.id, return_on: lending.returnOn}}, {headers: @getAuthHeaders()})

  signup: (user) ->
    @$http.post(@baseUrl + "signup", {user: {email: user.email, password: user.password, username: user.username}})

  login: (user) ->
    @$http.post(@baseUrl + "login", {user: {email: user.email, password: user.password}})

  getAuthHeaders: () ->
    {email: @storageService.get("email"), token: @storageService.get("token")}

  logout: () ->
    @$http.delete(@baseUrl + "logout", {headers: @getAuthHeaders()})

  getGreeting: () ->
    @$http.get(@baseUrl + "greet", {headers: @getAuthHeaders()})

  getUsers: ->
    @$http.get(@baseUrl + "users", {headers: @getAuthHeaders()})

  getGames: ->
    @$http.get(@baseUrl + "games", {headers: @getAuthHeaders()})

  getGame: (id) ->
    @$http.get(@baseUrl + "games/#{id}", {headers: @getAuthHeaders()})

  deleteGame: (id) ->
    @$http.delete(@baseUrl + "games/#{id}", {headers: @getAuthHeaders()})

  updateGame: (game) ->
    @$http.put(@baseUrl + "games/#{game.id}", {game: {title: game.title, system: game.system, developer: game.developer}}, {headers: @getAuthHeaders()})

  createGame: (game) ->
    @$http.post(@baseUrl + "games", {game: {title: game.title, system: game.system, developer: game.developer}}, {headers: @getAuthHeaders()})

angular.module "gamelendApp.webService", [], ($provide) ->
  $provide.factory "webService", ["$http", "storageService", ($http, storageService) -> new WebService($http, storageService)]
