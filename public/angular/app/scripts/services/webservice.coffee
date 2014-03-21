'use strict'

class WebService

  constructor: (@$http, @storageService) ->
    @baseUrl = "/api/v1/"

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

  getGames: ->
    @$http.get(@baseUrl + "games", {headers: @getAuthHeaders()})

  deleteGame: (id) ->
    @$http.delete(@baseUrl + "games/#{id}", {headers: @getAuthHeaders()})

  createGame: (game) ->
    @$http.post(@baseUrl + "games", {game: {title: game.title, system: game.system, developer: game.developer}}, {headers: @getAuthHeaders()})

angular.module "gamelendApp.webService", [], ($provide) ->
  $provide.factory "webService", ["$http", "storageService", ($http, storageService) -> new WebService($http, storageService)]
