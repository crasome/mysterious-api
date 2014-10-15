@app.directive "equals", ->
  restrict: "A"
  require: "?ngModel"
  link: (scope, elem, attrs, ngModel) ->
    console.log "install ngmodel" unless ngModel

    # watch own value and re-validate on change
    scope.$watch attrs.ngModel, ->
      validate()

    # observe the other value and re-validate on change
    attrs.$observe "equals", (val) ->
      validate()

    validate = ->
      val1 = ngModel.$viewValue
      val2 = attrs.equals

      ngModel.$setValidity "equals", not val1 or not val2 or val1 is val2
