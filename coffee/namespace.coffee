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

    player1_win = new MyApp.Models.Counter
    player2_win = new MyApp.Models.Counter
    draw = new MyApp.Models.Counter

    counter_view = new MyApp.Views.Counter
      player1_win: player1_win
      player2_win: player2_win
      draw: draw
    $('#main').append counter_view.render().el

    start_view = new MyApp.Views.Start
      collection: spaces
    $('#main').append start_view.render().el


$ ->
  MyApp.initialize()
