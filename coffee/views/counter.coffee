class MyApp.Views.Counter extends Backbone.View
  template: JST['counter']
  initialize: (options)->
    @listenTo MyApp.Channels.Game, 'count_up', @countUp
    @player1 = options.player1_win
    @player2 = options.player2_win
    @draw = options.draw
  events:
    'click #reset': 'resetCounter'
  render: ->
    @$el.html @template
      player1: @player1.get('count')
      player2: @player2.get('count')
      draw: @draw.get('count')
    @

  countUp: (result)->
    if result is 1
      @player1.set
        count: @player1.get('count') + 1
    else if result is -1
      @player2.set
        count: @player2.get('count') + 1
    else
      @draw.set
        count: @draw.get('count') + 1
    @render()

  resetCounter: ->
    @player1.set count: 0
    @player2.set count: 0
    @draw.set count: 0
    @render()
