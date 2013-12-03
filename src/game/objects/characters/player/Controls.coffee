class Controls
	constructor: ->
		@up = @down = @left = @right = @space = @shift = false
		self = @
		document.addEventListener "keydown", (e) ->
			self.trigger e.keyCode, true
		, false

		document.addEventListener "keyup", (e) ->
			self.trigger e.keyCode, false
		, false
	reset: ->
		@up = @down = @left = @right = @space = @shift = false
	trigger: (keyCode, isDown) ->
		console.log keyCode
		switch keyCode
			when 37 then @left = isDown
			when 39 then @right = isDown
			when 38 then @up = isDown
			when 40 then @down = isDown
			when 32 then @space = isDown
			when 16 then @shift = isDown
