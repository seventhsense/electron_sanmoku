class MyApp.Views.Start extends Backbone.View
  template: JST['start']
  events:
    'click #start': 'start'
  id: 'game_info'
  render: ->
    @$el.html @template
    @

  start: (event)->
    player = $('input[name=player]:checked').val()
    game = new MyApp.Objects.Game
      collection: @collection
      player: player
    game_info = new MyApp.Views.Game
      collection: @collection
    $('#main').append game_info.render().el

    game.start()
    @remove()
