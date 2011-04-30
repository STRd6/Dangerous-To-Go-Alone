Door = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  I.sprite = Sprite.NONE unless I.keepSprite

  self = GameObject(I)

  self.bind "step", ->
    if I.cat
      player = engine.find("Cat").first()
    else
      player = engine.find("Player").first()

    if player && Collision.rectangular(self.bounds(), player.collisionBounds())
      engine.loadMap I.destination, ->
        # Pretty hacky...
        engine.add player.I

      if I.destinationPosition
        player.I.x = I.destinationPosition.x
        player.I.y = I.destinationPosition.y

  return self

