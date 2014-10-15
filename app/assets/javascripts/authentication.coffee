# TODO: move to directive and do not use $rootScope
# TODO: watchout for js minifiers
@app.run ($rootScope, $http) ->
  $rootScope.current_user = { id: 0, email: "guest" }

  $rootScope.$on "event:auth-loginRequired", ->
    $rootScope.unauthenticated = true

  $rootScope.$on "event:auth-loginConfirmed", (_, data)->
    credentials = data.input.identifier + ':' + data.input.password
    $http.defaults.headers.common['Authorization'] = 'Basic ' + btoa(credentials)

    $rootScope.current_user = data.response.sessions.links.user
    $rootScope.unauthenticated = false
