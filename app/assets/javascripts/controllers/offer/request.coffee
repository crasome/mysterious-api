angular.module('api-demo').controller 'OfferRequest', [
  '$scope', '$stateParams', '$state', 'Offers'
  ($scope, $params, $state, Offers) ->
    'use strict'

    $scope.offer_request = {}
    $scope.offers = []
    $scope.offers_loaded = false

    $scope.requestOffers = ->
      Offers.get $scope.offer_request,
        (response) ->
          $scope.offers = response.offers
          $scope.offers_loaded = true

        (error_response) ->
          $scope.error = error_response.data.errors
          return

    return
]
