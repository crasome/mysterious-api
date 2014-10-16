@app.controller "RegistrationCtrl", ["$scope", "$state", "$rootScope", "User"
  ($scope, $state, $root, User) ->

    $root.unauthenticated = false
    $scope.user = {}

    $scope.submit = ->
      User.create users: $scope.user

      .$promise.then(
        (user) ->
          $state.go "expenses.list"
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )
]
