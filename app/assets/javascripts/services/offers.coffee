@app.factory "Offers", ["$resource"
  ($resource) ->
    $resource "/offers.json"
]
