class MyApp.Objects.Cpu extends Backbone.Marionette.Object
  initialize: (my_turn, spaces, type)->
    @my_turn = my_turn
    @ai = switch type
      when 'normal' then new MyApp.Objects.Ai @my_turn
      when 'monte calro' then new MyApp.Objects.Ai2 @my_turn
    @spaces = spaces

  move: ->
    # show message
    obj =
      turn: @my_turn
      message: 'cpu turn'
    MyApp.Channels.Game.trigger 'render:game_info', obj
    # choice
    model = @ai.choose(@spaces)
    model.set(value: @my_turn)
    MyApp.Channels.Game.trigger 'turn_end' , model
