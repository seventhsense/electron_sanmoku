class MyApp.Objects.Game extends Backbone.Marionette.Object
  initialize: (options)->
    @listenTo MyApp.Channels.Game, 'click:space', @onClickSpace
    @spaces = options.collection
    @turn = 1 # 先手 1 後手 -1
    @game_on = 1 # ゲーム中

  start: ->
    obj =
      turn: @turn
      message: 'Start!'
    MyApp.Channels.Game.trigger 'render:game_info', obj

  onClickSpace: (model)->
    return if @game_on is 0
    if model.get('value')
      obj =
        turn: @turn
        message: 'already taken..'
      MyApp.Channels.Game.trigger 'render:game_info', obj
    else
      model.set(value: @turn)
      result = @spaces.checkGameEnd(model)
      return @gameEnd(result) if result

      @turn = -1 * @turn
      obj =
        turn: @turn
        message: 'change turn'
      MyApp.Channels.Game.trigger 'render:game_info', obj

  gameEnd: (result)->
    @game_on = 0
    obj =
      result: result
    MyApp.Channels.Game.trigger 'render:game_end', obj
    @destroy()
