@app.config ['$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise '/offers'

    $stateProvider
      .state "offers", {
        url: "/offers",
        template: '<div ui-view />'
        abstract: true
      }
      .state "offers.form", {
        url: "",
        templateUrl: 'offers/form.html'
      }
]
