class MyApp.Objects.Cpu extends Backbone.Marionette.Object
  initialize: (my_turn, spaces)->
    @my_turn = my_turn
    @ai = new MyApp.Objects.Ai @my_turn
    @spaces = spaces

  move: ->
    # show message
    obj =
      turn: @turn
      message: 'cpu turn'
    MyApp.Channels.Game.trigger 'render:game_info', obj
    # choice
    model = @ai.choose(@spaces)
    model.set(value: @my_turn)
    MyApp.Channels.Game.trigger 'turn_end' , model
