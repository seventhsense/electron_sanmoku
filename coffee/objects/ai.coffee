class MyApp.Objects.Ai
  constructor: (cpu)->
    @cpu = cpu

  choose: (spaces)->
    choosen = spaces.sample()
    if choosen.get('value') isnt 0
      @choose(spaces)
    else
      return choosen

# 優先順位 勝ち > 負けを防ぐ > ２重取り > リーチ > 有効手
