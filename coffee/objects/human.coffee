class MyApp.Objects.Human extends Backbone.Marionette.Object
  initialize: (my_turn)->
    @listenTo MyApp.Channels.Game, 'click:space', @onClickSpace
    @my_turn = my_turn
    @player_turn = false

  move: ->
    console.log "player #{@my_turn} turn"
    @player_turn = true
    # show message
    obj =
      turn: @my_turn
      message: 'your turn'
    MyApp.Channels.Game.trigger 'render:game_info', obj

  onClickSpace: (model)->
    console.log 'on click'
    return if @player_turn is false
    if model.get('value')
      obj =
        message: 'already taken..'
      MyApp.Channels.Game.trigger 'render:game_info', obj
    else
      @player_turn = false
      model.set(value: @my_turn)
      MyApp.Channels.Game.trigger 'turn_end' , model
