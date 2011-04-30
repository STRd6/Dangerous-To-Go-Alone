window.engine = Engine 
  canvas: $("canvas").powerCanvas()
  includedModules: "Tilemap"

# Add a red square to the scene
engine.loadMap "start"

engine.add
  sprite: Sprite.loadByName("player")
  x: 96
  y: 96

engine.start()
