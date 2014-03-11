'use strict'

angular.module('gamelendApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'gamelendApp.webService',
  'gamelendApp.storageService',
  'gamelendApp.authService'
])
  .run ($rootScope, $location, authService) ->
    routesThatRequireAuth = ['/home']

    $rootScope.$on '$routeChangeStart', (event, next, current) ->
      if routesThatRequireAuth.indexOf($location.path()) >= 0 and not authService.isLoggedIn()
        $location.path('/login')
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/login.html'
        controller: 'LoginCtrl'
      .when '/home',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'
  .config ($httpProvider) ->
    interceptor = ["$rootScope", "$location", "$q", "storageService", ($scope, $location, $q, storageService) ->

      success = (resp) ->
        resp

      err = (resp) ->
        d = $q.defer()
        storageService.logout()
        $location.url "/"
        $scope.$broadcast("notify", {alertClass: "alert-danger", message: resp.data.message})
        return d.promise
        $q.reject resp

      (promise) ->
        promise.then success, err
    ]
    $httpProvider.responseInterceptors.push interceptor
