@app.controller "ExpenseListCtrl", ["$scope", "Expense",
  ($scope, Expense) ->
    $scope.expenseList = Expense.index()
]
