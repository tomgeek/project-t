CollisionManager =
	process: (blocks, player) ->
		for block in blocks
			@isCollision block, player
	isCollision: (obj1, obj2) ->
		return obj1.isCollidable and
		obj2.isCollidable and
		@isLineCollision(obj1.x, obj1.x + obj1.width, obj2.x, obj2.x + obj2.width) and
		@isLineCollision(obj1.y, obj1.y + obj1.height, obj2.y, obj2.y + obj2.height)
	isLineCollision: (line1Start, line1End, line2Start, line2End) ->
		return line1Start <= line2Start <= line1End || line1Start <= line2End <= line1End