class MyApp.Objects.Ai2
  constructor: (cpu_turn)->
    @cpu_turn = cpu_turn

  choose: (spaces)->
    # clone for candidates
    clone_spaces = spaces.shallow_clone()
    valid_choice = @validChoice(clone_spaces)
    candidates = []
    _.each valid_choice, (model)=>
      win = 0
      for i in [1..100]
        test_spaces = clone_spaces.shallow_clone()
        test_model = _.first test_spaces.where
          x: model.get('x')
          y: model.get('y')
        result = @doRandomGame(test_model, test_spaces)
        # console.log 'result', test_model.get('x'), test_model.get('y'), result
        # console.log '@cpu_turn', @cpu_turn
        win += 1 if result is @cpu_turn
        win += 0.5 if result is 'draw'
      candidates.push {model: model, win: win}
    candidate = _.max candidates, (candidate)-> return candidate.win
    # console.log candidates, candidate
    choosen = _.first spaces.where
      x: candidate.model.get('x')
      y: candidate.model.get('y')
    return choosen

  validChoice: (spaces)->
    spaces.where(value: 0)

  doRandomGame: (model, test_spaces)->
    # ai1 = new MyApp.Objects.Ai @cpu_turn
    # ai2 = new MyApp.Objects.Ai(@cpu_turn * -1)
    # 初手は決まり
    model.set(value: @cpu_turn)
    result = test_spaces.checkGameEnd(model)
    # 終わりまでランダムゲーム
    # console.log 'first result', result
    return result if result
    clone_turn = @cpu_turn * -1
    while result is false
      model = _.sample @validChoice(test_spaces)
      # if clone_turn is @cpu_turn
        # model = ai1.choose test_spaces
      # else
        # model = ai2.choose test_spaces
      model.set value: clone_turn
      result = test_spaces.checkGameEnd(model)
      clone_turn = clone_turn * -1
    result
