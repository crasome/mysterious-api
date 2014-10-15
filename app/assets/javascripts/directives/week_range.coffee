@app.directive("weekRange", ->
  restrict: "E"
  scope:
    min: "="
    max: "="
    value: "="

  template: """
      <button ng-click="value = value - 1" ng-disabled="value <= min">-</button>
      <ng-pluralize count="value"
            when="{
              '-1': 'All the time',
              '0': 'This week',
              '1': 'Last week',
              'other': '{} weeks ago'
              }"></ng-pluralize>
      <button ng-click="value = value + 1" ng-disabled="value >= max">+</button>
  """
)
