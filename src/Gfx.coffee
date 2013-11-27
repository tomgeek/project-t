class Gfx
  tileDimension: config.tileDimension
  playerLeftSpriteX: 2
  playerLeftSpriteY: 0
  playerRightSpriteX: 0
  playerRightSpriteY: 0
  constructor: () ->
    console.log "Gfx init"
    canvas = document.getElementById("game")
    @w =canvas.width = @tileDimension * config.levelWidth
    @h = canvas.height = @tileDimension * config.levelHeight
    @context = canvas?.getContext?("2d")

  clear: -> @context.clearRect 0, 0, @w, @h
  clear: -> @context.clearRect 0, 0, @w, @h

  load: (onLoadCallback) ->
    console.log "loading sprite"
    @sprite = new Image
    @sprite.onload = onLoadCallback
    @sprite.src = "resources/sprites.png"

  drawSprite: (spritePosX, spritePosY, x, y) ->
    @context.drawImage @sprite,
    spritePosX * @tileDimension, spritePosY * @tileDimension, @tileDimension, @tileDimension,
    x, y, @tileDimension, @tileDimension

  drawLevel: (level) ->
    levelMap = config.getLevel(level)
    colNum = rowNum = 0
    for tile in levelMap
      if tile == "\n"
        ++rowNum
        colNum = 0
        continue

      if tile isnt "."
        tilePos = config.tiles[tile]
        @drawSprite tilePos.x, tilePos.y, colNum * @tileDimension, rowNum * @tileDimension
      ++colNum

  drawPlayer: (x, y, direction) ->
    if direction == PlayerDirection.LEFT then playerSpriteX = @playerLeftSpriteX else playerSpriteX = @playerRightSpriteX
    if direction == PlayerDirection.LEFT then playerSpriteY = @playerLeftSpriteY else playerSpriteY = @playerRightSpriteY
    @drawSprite playerSpriteX, playerSpriteY, x, y
