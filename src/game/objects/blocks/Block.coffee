class Block extends Object
	constructor: (@type, x, y) ->
		super x, y, gameConfig.tileDimension, gameConfig.tileDimension
		@isCollidable = @type isnt "."
