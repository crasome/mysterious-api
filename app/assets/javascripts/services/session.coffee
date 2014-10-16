@app.factory "Session", ["$resource"
  ($resource) ->
    $resource "/sessions/:id.json", id: "@id",
      create: method: "POST"
]
