class MyApp.Views.Start extends Backbone.View
  template: JST['start']
  events:
    'click': 'start'
  id: 'game_info'
  render: ->
    @$el.html @template
    @

  start: (event)->
    game = new MyApp.Objects.Game
      collection: @collection
    game_info = new MyApp.Views.Game
      collection: @collection
    $('#main').append game_info.render().el

    game.start()
    @remove()
