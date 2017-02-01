class MyApp.Objects.PlayerManager extends Backbone.Marionette.Object
  initialize: (player1, player2, spaces)->
    @listenTo MyApp.Channels.Game, 'turn_end', @turnChange
    @turn = 1
    @player1 = switch player1
      when 'human' then new MyApp.Objects.Human @turn 
      when 'cpu'   then new MyApp.Objects.Cpu @turn, spaces 
    @player2 = switch player2
      when 'human' then new MyApp.Objects.Human @turn * -1
      when 'cpu'   then new MyApp.Objects.Cpu @turn * -1, spaces
    
  loop: ->
    if @turn is 1 then @player1.move() else @player2.move()
    # return

  turnChange: ->
    @turn = @turn * -1

  finish: ->
    @player1.destroy()
    @player2.destroy()
    @destroy()
