@app.config(
  ['$stateProvider', '$urlRouterProvider',
  ( $stateProvider,   $urlRouterProvider ) ->

    $urlRouterProvider.otherwise '/expenses'

    $stateProvider
      .state "register", {
        url: "/register",
        templateUrl: 'register.html'
      }
      .state "expenses", {
        abstract: true,
        url: "/expenses",
        templateUrl: 'expenses.html'
      }
      .state "expenses.list", {
        url: "",
        views: {
          'expense_list': { templateUrl: 'expenses/list.html' },
          'new_expense': { templateUrl: 'expenses/new.html' }
        }
      }
      .state "expenses.detail", {
        url: "/:id",
        templateUrl: 'expenses/detail.html'
      }
      .state "expenses.edit", {
        url: "/:id/edit",
        templateUrl: 'expenses/edit.html'
      }
  ])
