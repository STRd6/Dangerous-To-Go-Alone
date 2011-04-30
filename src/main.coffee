window.engine = Engine 
  canvas: $("canvas").powerCanvas()
  includedModules: "Tilemap"

# Add a red square to the scene
engine.loadMap "start"

engine.start()

