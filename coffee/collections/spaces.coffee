class MyApp.Collections.Spaces extends Backbone.Collection
  model: MyApp.Models.Space
  resetValue: ->
    @.each (model)-> model.set(value: 0)
  checkGameEnd: (model)->
    x = model.get('x')
    y = model.get('y')
    turn = model.get('value')
    sum_x = @checkValues(turn, @where(x: x))
    sum_y = @checkValues(turn, @where(y: y))
    sum_a = @checkValues turn, _.union @where(x:0, y:0), @where(x:1, y:1), @where(x:2, y:2) # ななめチェック１
    sum_b = @checkValues turn, _.union @where(x:2, y:0), @where(x:1, y:1), @where(x:0, y:2) # ななめチェック２
    checker = _.max [sum_x, sum_y, sum_a, sum_b]
    return turn if checker is 3
    return 'draw' if @where(value: 0).length is 0
    false

  checkValues: (turn, array)->
    turn * _.reduce array, (sum, i)->
      sum + i.get('value')
    ,0
