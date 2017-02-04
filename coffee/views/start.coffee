class MyApp.Views.Start extends Backbone.View
  template: JST['start']
  events:
    'click #start': 'start'
    'click #start1000': 'start1000'
  id: 'game_info'
  render: ->
    @$el.html @template
    @

  start: (event)->
    player1 = $('#player1').val()
    player2 = $('#player2').val()
    game = new MyApp.Objects.Game
      collection: @collection
      player1: player1
      player2: player2
    game_info = new MyApp.Views.Game
      collection: @collection
    $('#main').append game_info.render().el
    game.start()
    @remove()

  start1000: (event)->
    player1 = $('#player1').val()
    player2 = $('#player2').val()
    return if player1 is 'human' or player2 is 'human'

    game_info = new MyApp.Views.Game
      collection: @collection
    $('#main').append game_info.render().el

    game = new MyApp.Objects.Game
      collection: @collection
      player1: player1
      player2: player2
      remain: 1000
    game.start()
    @remove()
