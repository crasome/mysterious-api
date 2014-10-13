@app.config(
  ['$stateProvider', '$urlRouterProvider',
  ( $stateProvider,   $urlRouterProvider ) ->

    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state "expenses", {
        url: "/",
        templateUrl: 'expenses/list.html'
      }
      .state "login", {
        url: "/login",
        templateUrl: 'login.html'
      }
      .state "register", {
        url: "/register",
        templateUrl: 'register.html'
      }
  ])
