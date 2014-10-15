@app.controller "ExpenseCtrl", ["$scope", "$state", "$stateParams", "Expense",
  ($scope, $state, $stateParams, Expense) ->
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
]
