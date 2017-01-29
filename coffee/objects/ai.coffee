class MyApp.Objects.Ai
  constructor: (cpu)->
    @cpu = cpu

  choose: (spaces)->
    choosen = spaces.sample()
    if choosen.get('value') isnt 0
      @choose(spaces)
    else
      return choosen
