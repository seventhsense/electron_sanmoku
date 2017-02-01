class MyApp.Views.Start extends Backbone.View
  template: JST['start']
  events:
    'click #start': 'start'
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
