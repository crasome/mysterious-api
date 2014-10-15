@app.controller "ExpenseCtrl", ["$scope", "$state", "$cacheFactory", "$stateParams", "Expense",
  ($scope, $state, $cacheFactory, $stateParams, Expense) ->
    Expense.show({ id: $stateParams.id }, (expenseDetail)->
      $scope.expense = expenseDetail.expenses
    )

    $scope.update = ->
      Expense.update(id: $scope.expense.id, expenses: $scope.expense)

      .$promise.then(
        (expenseDetail)->
          $state.go "expenses.detail", expenseDetail.expenses
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

    $scope.remove = ->
      # TODO: use events
      Expense.delete id: $scope.expense.id
      .$promise.then(
        ->
          $cacheFactory.get("Expense.index").removeAll()
          $state.go "expenses.list"
      )

]
