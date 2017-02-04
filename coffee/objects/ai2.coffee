class MyApp.Objects.Ai2
  constructor: (cpu_turn)->
    @cpu_turn = cpu_turn

  choose: (spaces)->
    clone_spaces = spaces.shallow_clone()
    valid_choice = @validChoice(clone_spaces)
    candidates = []
    _.each valid_choice, (model)=>
      win = 0
      for i in [1..300]
        test_spaces = spaces.shallow_clone()
        result = @doRandomGame(model, test_spaces)
        win += 1 if result is @cpu_turn
      candidates.push {model: model, win: win}
    candidate = _.max candidates, (candidate)-> return candidate.win
    choosen = _.first spaces.where
      x: candidate.model.get('x')
      y: candidate.model.get('y')
    return choosen

  validChoice: (spaces)->
    spaces.where(value: 0)

  doRandomGame: (model, test_spaces)->
    model.set(value: @cpu_turn)
    result = test_spaces.checkGameEnd(model)
    clone_turn = @cpu_turn * -1
    while result is false
      model = _.sample @validChoice(test_spaces)
      model.set value: clone_turn
      result = test_spaces.checkGameEnd(model)
      clone_turn = clone_turn * -1
    result
