@app.controller "LoginCtrl", ["$scope", "$rootScope", "$http", "Session", "authService"
  ($scope, $root, $http, Session, authService) ->

    $scope.user_session = {}
    $scope.guest_user = { id: 0, email: "guest" }
    $scope.current_user = $scope.guest_user

    $scope.login = ->
      Session.create sessions: $scope.user_session

      .$promise.then(
        (sessionDetail) ->
          authService.loginConfirmed(
            response: sessionDetail,
            input: $scope.user_session
          )
          resetForm()
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

    $scope.logout = ->
       $root.$broadcast 'event:auth-loginRequired'

    $scope.$on "event:auth-loginRequired", ->
      setGuestUser()

    $scope.$on "event:auth-loginConfirmed", (_, data)->
      setCurrentUser(data)


    resetForm = ->
      $scope.error = null
      $scope.user_session = null
      $scope.LoginForm.$setPristine true

    # TODO: Move to service
    setCurrentUser = (data)->
      credentials = data.input.identifier + ':' + data.input.password
      encoded_credentials = btoa credentials

      $http.defaults.headers.common['Authorization'] = 'Basic ' + encoded_credentials
      $scope.current_user = data.response.sessions.links.user
      $root.unauthenticated = false

    setGuestUser = ->
      $scope.current_user = $scope.guest_user
      delete $http.defaults.headers.common['Authorization']
      $root.unauthenticated = true
]
