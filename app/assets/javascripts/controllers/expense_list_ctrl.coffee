@app.controller "ExpenseListCtrl", ["$scope", "$rootScope", "$cacheFactory", "Expense",
  ($scope, $root, $cacheFactory, Expense) ->
    reloadList = ->
      $cacheFactory.get("Expense.index").removeAll()
      loadList()

    loadList = ->
      current_week = $scope.week if $scope.week >= 0
      $scope.expenseList = Expense.index(week: current_week, description: $scope.description)

    $scope.week = 0
    $scope.$watch "week", (newValue, oldValue)->
      loadList() unless newValue == oldValue

    $scope.$watch "description", (newValue, oldValue)->
      loadList() unless newValue == oldValue

    loadList()

    $scope.remove = (expense) ->
      Expense.delete id: expense.id

      .$promise.then(
        -> $root.$broadcast 'expense:delete', $scope.expense
      )

    $root.$on 'expense:create', (_, expense) ->
      reloadList()

    $root.$on 'expense:update', (_, expense) ->
      reloadList()

    $root.$on 'expense:delete', (_, expense) ->
      reloadList()
]
