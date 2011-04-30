Door = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  self = GameObject(I)

  self.bind "step", ->
    player = engine.find("Player").first()

    if Collision.rectangular(self.bounds(), player.collisionBounds())
      engine.loadMap I.destination

      if I.destinationPosition
        player.I.x = I.destinationPosition.x
        player.I.y = I.destinationPosition.y



  return self

