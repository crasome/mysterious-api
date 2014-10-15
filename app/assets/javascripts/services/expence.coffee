@app.factory "Expense", ["$resource", "$cacheFactory", "$rootScope"
  ($resource, $cacheFactory, $rootScope) ->
    clearCache = ->
      $cacheFactory.get("Expense.index").removeAll()  if $cacheFactory.get("Expense.index")

    $rootScope.$on "expense:create", clearCache
    $rootScope.$on "expense:update", clearCache
    $rootScope.$on "expense:destroy", clearCache

    $resource("/expenses/:id.json", id: "@id",
      index:
        cache: $cacheFactory("Expense.index")
        method: "GET"

      show: method: "GET"
      update: method: "PUT"
      delete: method: "DELETE"
    )
]
