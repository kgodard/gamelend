"use strict"

class StorageService

  store: (key, value) ->
    localStorage.setItem(key, value)

  get: (key) ->
    localStorage.getItem key

  deleteItem: (key) ->
    localStorage.removeItem(key)

  logout: ->
    localStorage.removeItem("email")
    localStorage.removeItem("token")
    localStorage.removeItem("username")

angular.module "gamelendApp.storageService", [], ($provide) ->
  $provide.factory "storageService", -> new StorageService()
