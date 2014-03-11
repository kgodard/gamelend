'use strict'

class AuthService

  constructor: (@storageService) ->

  isLoggedIn: ->
    @storageService.get("email")? and @storageService.get("token")?

angular.module "gamelendApp.authService", [], ($provide) ->
  $provide.factory "authService", ["storageService", (storageService) -> new AuthService(storageService)]
