class MyApp.Collections.Spaces extends Backbone.Collection
  model: MyApp.Models.Space

  resetValue: ->
    @.each (model)-> model.set(value: 0)

  checkGameEnd: (model)->
    x = model.get('x')
    y = model.get('y')
    turn = model.get('value')
    sum_x = @getXSum turn, x
    sum_y = @getYSum turn, y
    sum_a = @getASum turn
    sum_b = @getBSum turn
    checker = _.max [sum_x, sum_y, sum_a, sum_b]
    return turn if checker is 3
    return 'draw' if @where(value: 0).length is 0
    false

  checkValues: (turn=1, array)->
    turn * _.reduce array, (sum, i)->
      sum + i.get('value')
    ,0

  getXSum: (turn=1, x)->
    @checkValues turn, @getXAray(x)

  getYSum: (turn=1, y)->
    @checkValues turn, @getYAray(y)

  getASum: (turn=1)->
    @checkValues turn, @getAAray() # ななめチェック１

  getBSum: (turn=1)->
    @checkValues turn, @getBAray() # ななめチェック２

  getXAray: (x)->
    @where(x: x)

  getYAray: (y)->
    @where(y: y)

  getAAray: ->
    _.union @where(x:0, y:0), @where(x:1, y:1), @where(x:2, y:2)

  getBAray: ->
    _.union @where(x:2, y:0), @where(x:1, y:1), @where(x:0, y:2)

  shallow_clone: ->
    clone = new MyApp.Collections.Spaces()
    @each (model)->
      clone.add new MyApp.Models.Space model.toJSON()
    clone
