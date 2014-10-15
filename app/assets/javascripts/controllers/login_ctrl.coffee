@app.controller "LoginCtrl", ["$scope", "$rootScope", "$http", "$cacheFactory", "Session", "authService"
  ($scope, $root, $http, $cacheFactory, Session, authService) ->
    @user_session = {}
    $scope.guest_user = { id: 0, email: "guest" }

    $scope.current_user ||= $scope.guest_user

    $scope.login = ->
      Session.create sessions: @user_session

      .$promise.then(
        (sessionDetail) ->
          $scope.error = null
          $scope.LoginForm.$setPristine true
          authService.loginConfirmed(response: sessionDetail, input: $scope.user_session)
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

    $scope.logout = ->
       $root.$broadcast 'event:auth-loginRequired'

    $scope.$on "event:auth-loginRequired", ->
      # Crear cache
      $cacheFactory.get("Expense.index").removeAll()

      # Reset user
      $scope.current_user = $scope.guest_user
      delete $http.defaults.headers.common['Authorization']
      $root.unauthenticated = true

    $scope.$on "event:auth-loginConfirmed", (_, data)->
      credentials = data.input.identifier + ':' + data.input.password
      encoded_credentials = btoa credentials

      $http.defaults.headers.common['Authorization'] = 'Basic ' + encoded_credentials
      $scope.current_user = data.response.sessions.links.user
      $root.unauthenticated = false
]
