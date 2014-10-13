@app.controller "LoginCtrl", ["$scope", "$http", "authService"
  ($scope, $http, authService) ->
    $scope.submit = ->
      $http.post("sessions").success ->
        authService.loginConfirmed()
]
