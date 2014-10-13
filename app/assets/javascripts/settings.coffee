@app.factory "httpRequestInterceptor", ->
  request: (config) ->
    config.headers = "API-VERSION": "v1"
    config

@app.config ['$locationProvider', '$httpProvider'
  ($locationProvider, $httpProvider) ->
    $locationProvider.html5Mode true
    $httpProvider.interceptors.push "httpRequestInterceptor"
]
