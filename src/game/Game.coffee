class Game
	level: 1
	constructor: (gfx) ->
		console.log "Game init"
		if gfx?
			@gfx = gfx
			@player = new Player(levels[@level].playerPosX * gameConfig.tileDimension, levels[@level].playerPosY * gameConfig.tileDimension)
			@gfx.load @graphicsLoaded
			@gfx.resizeCanvas levels[@level].widthTiles, levels[@level].heightTiles
		else
			alert "cannot run, need canvas"
			return

	gameStep: =>
		@gfx.clear()
		@gfx.drawLevel(levels[@level].map)
		@player.update()
		@gfx.drawPlayer(@player.x, @player.y, @player.direction)
		setTimeout @gameStep, 16.6 #60 fps

	graphicsLoaded: =>
		console.log "graphics loaded"
		@gfx.drawLevel(levels[@level].map)
		@gfx.drawPlayer(@player.x, @player.y)
		@gameStep()

