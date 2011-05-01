window.engine = Engine 
  canvas: $("canvas").powerCanvas()
  includedModules: "Tilemap"

# Add a red square to the scene
engine.loadMap "start", ->
  engine.add
    class: "Player"

engine.start()

parent.gameControlData =
  Movement: "Arrow Keys"
  "Deploy/Return Cat": "spacebar"

