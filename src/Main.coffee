Main =
  init: () ->
    console.log "Main init"
    gfx = new Gfx()
    new Game(gfx)

Main.init()