keys =
  up: false,
  down: false,
  left: false,
  right: false,
  space: false,
  shift: false,
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


document.addEventListener "keydown", (e) ->
  keys.trigger e.keyCode, true
, false

document.addEventListener "keyup", (e) ->
  keys.trigger e.keyCode, false
, false
