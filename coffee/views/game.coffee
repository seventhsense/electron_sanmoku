class MyApp.Views.Game extends Backbone.Marionette.View
  template: JST['game']
  initialize: ->
    @listenTo MyApp.Channels.Game, 'render:game_info', @render
    @listenTo MyApp.Channels.Game, 'render:game_end', @render_end
  events:
    'click #restart': 'restart'
  id: 'game_info'

  render: (obj)->
    turn = obj.turn if obj
    message = obj.message if obj
    result = obj.result if obj
    @$el.html @template
      turn: turn
      message: message
      result: result
    @

  render_end: (obj)->
    if obj.result is 1
      message = "Winner is Player1"
    else if obj.result is -1
      message = "Winner is Player2"
    else
      message = 'Draw...'
    obj.message = message
    @render(obj)

  restart: ()->
    console.log 'restart'
    console.log @collection
    @collection.resetValue()
    game = new MyApp.Objects.Game
      collection: @collection
    game.start()
