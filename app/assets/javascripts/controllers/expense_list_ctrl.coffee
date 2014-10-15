@app.controller "ExpenseListCtrl", ["$scope", "$rootScope", "$cacheFactory", "Expense",
  ($scope, $root, $cacheFactory, Expense) ->
    reloadList = ->
      $cacheFactory.get("Expense.index").removeAll()
      $scope.expenseList = Expense.index(week: $scope.week)

    $scope.week = 0
    $scope.$watch "week", -> reloadList()

    $scope.remove = (expense) ->
      Expense.delete id: expense.id

      .$promise.then(
        -> $root.$broadcast 'expense:delete', $scope.expense
      )

    $scope.$on 'expense:create', (_, expense) ->
      reloadList()

    $scope.$on 'expense:update', (_, expense) ->
      reloadList()

    $scope.$on 'expense:delete', (_, expense) ->
      reloadList()
]
