class MyApp.Objects.Game extends Backbone.Marionette.Object
  initialize: (options)->
    @listenTo MyApp.Channels.Game, 'click:space', @onClickSpace
    @spaces = options.collection
    @turn = 1 # 先手 1 後手 -1
    @game_on = false # 動行可能
    @player = options.player * 1 # 整数化
    @cpu = -1 * @player
    @ai = new MyApp.Objects.Ai @cpu

  start: ->
    obj =
      turn: @turn
      message: 'Start!'
    MyApp.Channels.Game.trigger 'render:game_info', obj
    if @player is 1
      @playerTurn()
    else
      @cpuTurn()

  cpuTurn: ->
    # show message
    obj =
      turn: @turn
      message: 'cpu turn'
    MyApp.Channels.Game.trigger 'render:game_info', obj
    # click event off
    @game_on = false
    # choice
    sample = @ai.choose(@spaces)
    sample.set(value: @cpu)
    # check game end
    result = @spaces.checkGameEnd(sample)
    return @gameEnd(result) if result
    # turn change
    @turn = -1 * @turn
    return @playerTurn()

  playerTurn: ->
    # show message
    obj =
      turn: @turn
      message: 'your turn'
    MyApp.Channels.Game.trigger 'render:game_info', obj
    # accept click
    @game_on = true 

  onClickSpace: (model)->
    return if @game_on is false
    if model.get('value')
      obj =
        turn: @turn
        message: 'already taken..'
      MyApp.Channels.Game.trigger 'render:game_info', obj
    else
      model.set(value: @player)
      # end check
      result = @spaces.checkGameEnd(model)
      return @gameEnd(result) if result
      # turn change
      @turn = -1 * @turn
      return @cpuTurn()

  gameEnd: (result)->
    @game_on = 0
    obj =
      result: result
    MyApp.Channels.Game.trigger 'render:game_end', obj
    @destroy()
