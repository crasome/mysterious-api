@app.controller "ExpenseListCtrl", ["$scope", "$rootScope", "Expense",
  ($scope, $root, Expense) ->
    $scope.week = 0

    loadList = ->
      current_week = $scope.week if $scope.week >= 0
      $scope.expenseList = Expense.index(week: current_week, description: $scope.description)

    loadList()

    $scope.remove = (expense) ->
      Expense.delete id: expense.id

      .$promise.then(
        -> $root.$broadcast 'expense:delete', $scope.expense
      )

    $scope.$watch "week", (newValue, oldValue)->
      loadList() unless newValue == oldValue

    $scope.$watch "description", (newValue, oldValue)->
      loadList() unless newValue == oldValue

    $scope.$on 'expense:create', loadList
    $scope.$on 'expense:update', loadList
    $scope.$on 'expense:delete', loadList
    $scope.$on 'event:auth-loginConfirmed', loadList
]
