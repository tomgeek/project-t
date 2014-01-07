class Character extends Object
	interfaces: Movable
	isCollidable: true
	constructor: (x, y, width, height) ->
		console.log "Character init"
		super x, y, width, height