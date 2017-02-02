class MyApp.Objects.Game extends Backbone.Marionette.Object
  initialize: (options)->
    @listenTo MyApp.Channels.Game, 'get_spaces_info', @getSpacesInfo
    @listenTo MyApp.Channels.Game, 'turn_end', @checkGameEnd
    @spaces = options.collection
    @players = new MyApp.Objects.PlayerManager options.player1, options.player2, @spaces

  start: ->
    @gameEnd = false
    @intervalId = setInterval =>
      @players.loop()
    , 200

  checkGameEnd: (model)->
    result = @spaces.checkGameEnd(model)
    @doGameEnd(result) if result

  doGameEnd: (result)->
    clearInterval(@intervalId)
    @players.finish()
    obj =
      result: result
    MyApp.Channels.Game.trigger 'render:game_end', obj
    @destroy()
