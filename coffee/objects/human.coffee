class MyApp.Objects.Human extends Backbone.Marionette.Object
  initialize: (my_turn)->
    @listenTo MyApp.Channels.Game, 'click:space', @onClickSpace
    @my_turn = my_turn
    @allow_click = false

  move: ->
    @allow_click = true
    # show message
    obj =
      turn: @my_turn
      message: 'your turn'
    MyApp.Channels.Game.trigger 'render:game_info', obj

  onClickSpace: (model)->
    return if @allow_click is false
    if model.get('value')
      obj =
        message: 'already taken..'
      MyApp.Channels.Game.trigger 'render:game_info', obj
    else
      @allow_click = false
      model.set(value: @my_turn)
      MyApp.Channels.Game.trigger 'turn_end' , model
