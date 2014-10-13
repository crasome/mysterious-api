@app.controller "ExpenseListCtrl", ["$scope", "$http", "Expense"
  ($scope, $http, Expense) ->
    $scope.expenseList = Expense.index()
]
