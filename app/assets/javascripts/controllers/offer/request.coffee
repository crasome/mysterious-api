angular.module('api-demo').controller 'OfferRequest', [
  '$scope', '$stateParams', '$state', 'Offers'
  ($scope, $params, $state, Offers) ->
    'use strict'

    $scope.offer_request = {}
    $scope.offers = []

    $scope.requestOffers = ->
      Offers.get $scope.offer_request,
        (response) ->
          $scope.offers = response.offers

        (error_response) ->
          $scope.error = error_response.data.errors
          return

    return
]
