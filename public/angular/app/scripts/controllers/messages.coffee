'use strict'

class MessagesCtrl

  constructor: (@$scope, @$location, @webService, @storageService) ->
    @setup()

  setup: ->
    @$scope.$on("notify", @handleNotification)
    @$scope.clearMessage = @clearMessage

  clearMessage: =>
    @$scope.message = undefined

  handleNotification: (event, args) =>
    @$scope.alertClass = args.alertClass ? 'alert-info'
    @$scope.message = args.message

MessagesCtrl.$inject = ["$scope", "$location", "webService", "storageService"]
angular.module("gamelendApp").controller "MessagesCtrl", MessagesCtrl
