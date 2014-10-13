@app.config(
  ['$stateProvider', '$urlRouterProvider',
  ( $stateProvider,   $urlRouterProvider ) ->

    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state "login", {
        url: "/",
        templateUrl: 'login.html'
      }
  ])
