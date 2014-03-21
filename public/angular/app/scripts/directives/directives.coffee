'use strict'
#
# A generic confirmation for risky actions.
# Usage: Add attributes:
# * ng-confirm-message="Are you sure?"
# * ng-confirm-click="takeAction()" function
# * ng-confirm-condition="mustBeEvaluatedToTrueForTheConfirmBoxBeShown" expression
#
angular.module('gamelendApp').directive 'ngConfirmClick', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      condition = scope.$eval(attrs.ngConfirmCondition)
      if condition
        message = attrs.ngConfirmMessage
        if message and confirm(message)
          scope.$apply(attrs.ngConfirmClick)
      else
        scope.$apply(attrs.ngConfirmClick)

angular.module('gamelendApp').directive 'myDirective', ->
  restrict: 'AE'
  replace: true
  template: '<a href="http://google.com">Go to Google</a>'
