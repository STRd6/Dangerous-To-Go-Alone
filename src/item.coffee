Item = (I) ->
  $.reverseMerge I,
    width: 16
    height: 16

  self = GameObject(I)

  self.bind "step", ->
    player = engine.find("Player").first()

    if Collision.rectangular(self.bounds(), player.collisionBounds())
      player.pickup(self)

  return self

