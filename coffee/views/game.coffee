class MyApp.Views.Game extends Backbone.Marionette.View
  template: JST['game']
  initialize: ->
    @listenTo MyApp.Channels.Game, 'render:game_info', @render
    @listenTo MyApp.Channels.Game, 'render:game_end', @render_end
    @listenTo MyApp.Channels.Game, 'restart_auto', @restartAuto
  events:
    'click #restart': 'restart'
  id: 'game_info'

  render: (obj)->
    console.log 'obj', obj
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
      message = "Winner is Player1!"
    else if obj.result is -1
      message = "Winner is Player2!"
    else
      message = 'Draw...'
    obj.message = message
    @render(obj)

  restart: ()->
    @collection.resetValue()
    start_view = new MyApp.Views.Start
      collection: @collection
    $('#main').append start_view.render().el
    @remove()

  restartAuto: (obj)->
    @collection.resetValue()
    console.log obj.remain
    game_info = new MyApp.Views.Game
      collection: @collection
    $('#main').append game_info.render().el

    game = new MyApp.Objects.Game
      collection: @collection
      player1: obj.player1
      player2: obj.player2
      remain: obj.remain - 1
    game.start()

    @remove()
