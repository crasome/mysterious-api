@app.controller "ExpenseCtrl", ["$scope", "$state", "$rootScope", "$stateParams", "Expense",
  ($scope, $state, $root, $stateParams, Expense) ->

    Expense.show(id: $stateParams.id, (expenseDetail)->
      $scope.expense = expenseDetail.expenses
      $scope.expense.time = new Date $scope.expense.time
    ) if $stateParams.id

    $scope.remove = ->
      Expense.delete id: $scope.expense.id
      .$promise.then(
        ->
          $root.$broadcast 'expense:delete', $scope.expense
          $state.go "expenses.list"
      )

    $scope.update = ->
      Expense.update id: $scope.expense.id, expenses: $scope.expense

      .$promise.then(
        (expenseDetail)->
          $root.$broadcast 'expense:update', $scope.expense
          $state.go "expenses.detail", expenseDetail.expenses
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

    $scope.add = ->
      Expense.create expenses: $scope.expense
      .$promise.then(
        ->
          $root.$broadcast 'expense:create', $scope.expense
          resetForm()
        ,
        (errorResponse) ->
          $scope.error = errorResponse.data.errors
      )

    resetForm = ->
      $scope.expense = null
      $scope.error = null
      $scope.ExpenseForm.$setPristine true
]
