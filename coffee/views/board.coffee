class MyApp.Views.Board extends Backbone.View
  tagName: 'table'
  id: 'board'
  render: ->
    for i in [0..2]
      array = @collection.where y: i
      view = new MyApp.Views.Row
        array: array
      @$el.append view.render().el
    @
