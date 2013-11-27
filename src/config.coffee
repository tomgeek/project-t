config =
  tileDimension: 24
  levelWidth: 8
  levelHeight: 9
  playerPosX: 0
  playerPosY: 4
  levels:
    0: """
       ........
       ....@...
       00000000
       ........
       ........
       ........
       0000.000
       ........
       0000000e
       """
  getLevel: (level) ->
    @levels[level]
  tiles:
    "s": # start, must be only one
      x: 0
      y: 0
    "e": # end, at least one
      x: 6
      y: 1
    "0": # ground
      x: 4
      y: 1
    "@": # ninja
      x: 0
      y: 1
