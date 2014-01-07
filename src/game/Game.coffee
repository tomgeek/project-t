class Game
	level: 1
	constructor: (gfx) ->
		console.log "Game init"
		if gfx?
			@gfx = gfx
			@levelCfg = levels[@level]

			colNum = rowNum = 0
			@blocks = []
			for block in @levelCfg.map
				if block isnt "\n"
					@blocks.push @generateBlock block, colNum * gameConfig.tileDimension, rowNum * gameConfig.tileDimension
					++colNum
				else
					++rowNum
					colNum = 0
			console.log @blocks
			@player = new Player @levelCfg.playerPosX * gameConfig.tileDimension, @levelCfg.playerPosY * gameConfig.tileDimension
			@gfx.load @gameStep
			@gfx.resizeCanvas @levelCfg.widthTiles, @levelCfg.heightTiles

		else
			alert "cannot run, need canvas"
			return

	gameStep: =>
		# update movable objects inner state
		@player.update()
		CollisionManager.process(@blocks, @player)

		@gfx.clear()
		@gfx.drawLevel(@blocks)
		@gfx.drawPlayer(@player.x, @player.y, @player.direction)
		setTimeout @gameStep, 16.6 #60 fps (1000 / # fps = millis per tick)

	generateBlock: (blockType, x, y) ->
		console.log blockType
		new Block blockType, x, y