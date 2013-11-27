class Player
  speed: 1.5
  walkSpeed: 1.5
  runSpeed: 2.5
  altitude: 0
  direction: PlayerDirection.RIGHT
  constructor: (x, y) ->
    console.log "player init #{x}, #{y}"
    @x = x
    @y = y
  update: ->
    if keys.shift then @speed = @runSpeed else @speed = @walkSpeed
    if keys.left
      @x -= @speed
      @direction = PlayerDirection.LEFT
    if keys.right
      @x += @speed
      @direction = PlayerDirection.RIGHT
    @y += @speed if keys.down
    @y -= @speed if keys.up
