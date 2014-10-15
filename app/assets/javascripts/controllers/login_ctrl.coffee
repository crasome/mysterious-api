@app.controller "LoginCtrl", ["$scope", "Session", "authService"
  ($scope, Session, authService) ->
    @user_session = {}

    $scope.submit = ->
      Session.create sessions: @user_session

      .$promise.then(
        (sessionDetail) ->
          authService.loginConfirmed(response: sessionDetail, input: $scope.user_session)
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )
]
