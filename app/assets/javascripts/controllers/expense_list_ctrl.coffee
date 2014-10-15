@app.controller "ExpenseListCtrl", ["$scope", "$rootScope", "$cacheFactory", "Expense",
  ($scope, $root, $cacheFactory, Expense) ->
    $scope.expenseList = Expense.index()

    $scope.remove = (expense) ->
      Expense.delete id: expense.id

      .$promise.then(
        -> $root.$broadcast 'expense:delete', $scope.expense
      )

    reloadList = ->
      $cacheFactory.get("Expense.index").removeAll()
      $scope.expenseList = Expense.index()

    $scope.$on 'expense:create', (_, expense) ->
      reloadList()

    $scope.$on 'expense:update', (_, expense) ->
      reloadList()

    $scope.$on 'expense:delete', (_, expense) ->
      reloadList()
]
