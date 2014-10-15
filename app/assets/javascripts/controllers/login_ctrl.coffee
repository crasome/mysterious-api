@app.controller "LoginCtrl", ["$scope", "Session", "authService"
  ($scope, Session, authService) ->
    @user_session = {}

    $scope.submit = ->
      Session.create sessions: @user_session

      .$promise.then(
        (session_data) ->
          authService.loginConfirmed(response: session_data, input: $scope.user_session)
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )
]
