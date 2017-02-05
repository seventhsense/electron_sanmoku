class MyApp.Objects.Game extends Backbone.Marionette.Object
  initialize: (options)->
    @listenTo MyApp.Channels.Game, 'get_spaces_info', @getSpacesInfo
    @listenTo MyApp.Channels.Game, 'turn_end', @checkGameEnd
    @spaces = options.collection
    @remain = options.remain
    @player1 = options.player1
    @player2 = options.player2
    @players = new MyApp.Objects.PlayerManager @player1, @player2, @spaces

  start: ->
    @gameEnd = false
    if @player1 is 'human' or @player2 is 'human' then interval = 200 else interval = 1
    @intervalId = setInterval =>
      @players.loop()
    , interval

  checkGameEnd: (model)->
    result = @spaces.checkGameEnd(model)
    @doGameEnd(result) if result

  doGameEnd: (result)->
    clearInterval(@intervalId)
    @players.finish()
    MyApp.Channels.Game.trigger 'count_up', result

    if @remain > 0
      obj =
        result: result
        remain: @remain
        player1: @player1
        player2: @player2
      MyApp.Channels.Game.trigger 'restart_auto', obj
    else
      obj =
        result: result
      MyApp.Channels.Game.trigger 'render:game_end', obj

    @destroy()
