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

    start_view = new MyApp.Views.Start
      collection: spaces
    $('#main').append start_view.render().el


$ ->
  MyApp.initialize()
