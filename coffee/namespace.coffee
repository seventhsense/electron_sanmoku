window.MyApp =
  Views: {}
  Collections: {}
  Models: {}
  Channels: {}
  Objects: {}
  initialize: ->
    spaces = new MyApp.Collections.Spaces
    for i in [0..2]
      for j in [0..2]
        spaces.add
          y: i
          x: j
    board = new MyApp.Views.Board
      collection: spaces
    $('#main').html board.render().el 
    MyApp.Channels.Game = Radio.channel('game')
    game = new MyApp.Objects.Game
      collection: spaces

    game_info = new MyApp.Views.Game
      collection: spaces
    $('#main').append game_info.render().el

    game.start()

$ ->
  MyApp.initialize()
