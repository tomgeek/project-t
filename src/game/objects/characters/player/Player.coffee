class Player extends Character
	speed: 1.5
	walkSpeed: 1.5
	runSpeed: 2.5
	altitude: 0
	direction: PlayerDirection.RIGHT
	constructor: (x, y) ->
		console.log "player init #{x}, #{y}"
		super x, y, gameConfig.tileDimension, gameConfig.tileDimension
		@controls = new Controls()
	update: ->
		if @controls.shift then @speed = @runSpeed else @speed = @walkSpeed
		if @controls.left
			@x -= @speed
			@direction = PlayerDirection.LEFT
		if @controls.right
			@x += @speed
			@direction = PlayerDirection.RIGHT
		@y += @speed if @controls.down
		@y -= @speed if @controls.up
