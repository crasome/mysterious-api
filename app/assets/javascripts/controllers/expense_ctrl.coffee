@app.controller "ExpenseCtrl", ["$scope", "$state", "$cacheFactory", "$stateParams", "Expense",
  ($scope, $state, $cacheFactory, $stateParams, Expense) ->
    # TODO: use @expense

    # HACK
    if $stateParams.id
      Expense.show({ id: $stateParams.id }, (expenseDetail)->
        $scope.expense = expenseDetail.expenses
      )
    else
      $scope.expense = {}


    $scope.update = ->
      Expense.update(id: $scope.expense.id, expenses: $scope.expense)

      .$promise.then(
        (expenseDetail)->
          $state.go "expenses.detail", expenseDetail.expenses
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

    $scope.add = ->
      Expense.create expenses: $scope.expense
      .$promise.then(
        ->
          $scope.expense = {}
          $cacheFactory.get("Expense.index").removeAll()
          $state.go "expenses.list"
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

]
