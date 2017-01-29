class MyApp.Views.Row extends Backbone.View
  tagName: 'tr'
  initialize: (options)->
    @array = options.array
  render: ()->
    for i in [0..2]
      view = new MyApp.Views.Space
        model: @array[i]
      @$el.append view.render().el
    @
