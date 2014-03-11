'use strict'

class NavigationCtrl

  constructor: (@$scope, @$location, @webService, @storageService) ->
    @setup()

  setup: ->
    @$scope.logout = @logout
    @$scope.username = @storageService.get('username')

  logout: (user) =>
    promise = @webService.logout()
    promise.then @success, @error

  success: (response) =>
    @storageService.logout()
    @$location.url "/"

  error: (response) =>
    console.log response
    @storageService.logout()
    @$location.url "/"

NavigationCtrl.$inject = ["$scope", "$location", "webService", "storageService"]
angular.module("gamelendApp").controller "NavigationCtrl", NavigationCtrl
