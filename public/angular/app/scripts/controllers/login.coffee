'use strict'

class LoginCtrl

  constructor: (@$scope, @$location, @webService, @storageService) ->
    @setup()

  setup: ->
    @$scope.login = @login
    @$scope.signup = @signup

  signup: (user) =>
    promise = @webService.signup(user)
    promise.then @success, @error

  login: (user) =>
    promise = @webService.login(user)
    promise.then @success, @error

  success: (response) =>
    @storageService.store "token", response.data.token
    @storageService.store "email", response.data.email
    @storageService.store "username", response.data.username
    @$location.url "home"

  error: (response) =>
    console.log response

LoginCtrl.$inject = ["$scope", "$location", "webService", "storageService"]
angular.module("gamelendApp").controller "LoginCtrl", LoginCtrl
