class Game
  level: 0
  constructor: (gfx) ->
    console.log "init"
    if gfx?
      @gfx = gfx
      @player = new Player(config.playerPosX * config.tileDimension, config.playerPosY * config.tileDimension)
      @gfx.load @graphicsLoaded
    else
      alert "cannot run, need canvas"
      return

  gameStep: =>
    @gfx.clear()
    @gfx.drawLevel(@level)
    @player.update()
    @gfx.drawPlayer(@player.x, @player.y, @player.direction)
    setTimeout @gameStep, 16.6 #60 fps

  graphicsLoaded: =>
    @gfx.drawLevel(@level)
    @gfx.drawPlayer(@player.x, @player.y)
    @gameStep()

