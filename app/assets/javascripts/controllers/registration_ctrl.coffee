@app.controller "RegistrationCtrl", ["$scope", "$state", "$rootScope", "User"
  ($scope, $state, $rootScope, User) ->
    $rootScope.unauthenticated = false
    @user = {}

    $scope.submit = ->
      User.create users: @user

      .$promise.then(
        (user) ->
          $state.go "expenses.list"
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )
]
