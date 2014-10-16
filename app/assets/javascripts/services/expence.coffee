@app.factory "Expense", ["$resource", "$cacheFactory", "$rootScope"
  ($resource, $cacheFactory, $root) ->
    clearCache = ->
      $cacheFactory.get("Expense.index").removeAll() if $cacheFactory.get("Expense.index")

    $root.$on 'expense:create', clearCache
    $root.$on 'expense:update', clearCache
    $root.$on 'expense:delete', clearCache
    $root.$on 'event:auth-loginRequired', clearCache

    $resource("/expenses/:id.json", id: "@id",
      index:
        cache: $cacheFactory("Expense.index")
        method: "GET"

      show: method: "GET"
      update: method: "PUT"
      create: method: "POST"
      delete: method: "DELETE"
    )
]
