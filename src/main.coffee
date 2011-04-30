window.engine = Engine 
  canvas: $("canvas").powerCanvas()
  includedModules: "Tilemap"

# Add a red square to the scene
engine.loadMap "start"

engine.add
  x: 128
  y: 128
  sprite: Sprite.loadByName "cat"

engine.start()

