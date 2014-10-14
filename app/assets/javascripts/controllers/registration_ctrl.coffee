@app.controller "RegistrationCtrl", ["$scope", "$http", "$state", "User"
  ($scope, $http, $state, User) ->
    @user = {}

    $scope.create = ->
      User.create(users: @user)

      .$promise.then(
        (user) ->
          $state.go "login"
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )
]
