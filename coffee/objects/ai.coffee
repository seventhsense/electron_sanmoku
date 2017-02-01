class MyApp.Objects.Ai
  constructor: (cpu_turn)->
    @cpu_turn = cpu_turn

  choose: (spaces)->
    choosen = @checkReach(spaces)
    unless choosen
      console.log 'check player reach'
      choosen = @checkPlayerReach(spaces)
    unless choosen
      console.log 'random'
      choosen =  _.sample @validChoice(spaces)
    return choosen

  validChoice: (spaces)->
    spaces.where(value: 0)

  checkReach: (spaces)->
    choosen
    validChoice = @validChoice(spaces)
    asum = spaces.getASum()
    bsum = spaces.getBSum()
    reach = 2 * @cpu_turn
    # ななめリーチ
    if asum is reach
      s = _.first _.filter spaces.getAAray(), (s)-> return s.get('value') is 0
      return choosen = s
    if bsum is reach
      s = _.first _.filter spaces.getBAray(), (s)-> return s.get('value') is 0
      return choosen = s 
    # 縦横リーチ
    choosen = _.first _.filter validChoice, (space)->
      x = space.get('x')
      y = space.get('y')
      xsum = spaces.getXSum(1, x)
      if xsum is reach
        s = _.first _.filter spaces.getXAray(x), (s)-> return s.get('value') is 0
        return true
      ysum = spaces.getYSum(1, y)
      if ysum is reach
        s = _.first _.filter spaces.getYAray(y), (s)-> return s.get('value') is 0
        return true
    if choosen then return choosen else return false

  checkPlayerReach: (spaces)->
    choosen
    validChoice = @validChoice(spaces)
    asum = spaces.getASum()
    bsum = spaces.getBSum()
    reach = 2 * @cpu_turn * -1
    # ななめリーチ
    if asum is reach
      s = _.first _.filter spaces.getAAray(), (s)-> return s.get('value') is 0
      return choosen = s
    if bsum is reach
      s = _.first _.filter spaces.getBAray(), (s)-> return s.get('value') is 0
      return choosen = s
    # 縦横リーチ
    choosen = _.first _.filter validChoice, (space)->
      x = space.get('x')
      y = space.get('y')
      xsum = spaces.getXSum(1, x)
      if xsum is reach
        s = _.first _.filter spaces.getXAray(x), (s)-> return s.get('value') is 0
        return true
      ysum = spaces.getYSum(1, y)
      if ysum is reach
        s = _.first _.filter spaces.getYAray(y), (s)-> return s.get('value') is 0
        return true
    if choosen then return choosen else return false

# 優先順位 勝ち > 負けを防ぐ > ２重取り > リーチ > 有効手
