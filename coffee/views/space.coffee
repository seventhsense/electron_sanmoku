class MyApp.Views.Space extends Backbone.Marionette.View
  template: JST['space']
  tagName: 'td'
  className: 'space'
  events:
    'click': 'onClick'
  id: ->
    "space_#{@model.get('x')}_#{@model.get('y')}"
  modelEvents:
    'change': 'render'
  render: ->
    if @model.get('value') is 1
      value = '○'
    else if @model.get('value') is -1
      value = '×'
    else
      value = ''
    @$el.html @template value: value
    @

  onClick: (event)->
    MyApp.Channels.Game.trigger 'click:space', @model
