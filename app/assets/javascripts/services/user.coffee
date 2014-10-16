@app.factory "User", ["$resource"
  ($resource) ->
    $resource "/users/:id.json", id: "@id",
      create: method: "POST"
]
