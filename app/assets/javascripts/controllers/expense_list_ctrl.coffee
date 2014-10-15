@app.controller "ExpenseListCtrl", ["$scope", "$cacheFactory", "Expense",
  ($scope, $cacheFactory, Expense) ->
    $scope.expenseList = Expense.index()

    $scope.remove = (expense) ->
      Expense.delete id: expense.id
      .$promise.then(
        ->
          $cacheFactory.get("Expense.index").removeAll()
          $scope.expenseList = Expense.index()
      )
]
