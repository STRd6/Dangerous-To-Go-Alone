BombDoor = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    solid: true

  openSprite = Sprite.loadByName("cave_small")

  self = GameObject(I).extend
    open: ->
      I.solid = false
      I.sprite = openSprite
      Sound.play "secret"

  self.bind "step", ->

    if I.cat
      player = engine.find("Cat").first()
    else
      player = engine.find("Player").first()

    if player && Collision.rectangular(self.bounds(), player.collisionBounds())
      engine.loadMap I.destination, ->
        player.I.location = I.destination

        # Pretty hacky...
        engine.add player.I

        if I.cat && player.I.playerData.location == I.destination
          engine.add player.I.playerData

      if I.autoPosition
        if I.x == 0
          player.I.x = 416
        else if I.x == 448
          player.I.x = 32

        if I.y == 0
          player.I.y = 256
        else if I.y == 288
          player.I.y = 32

      if I.destinationPosition
        player.I.x = I.destinationPosition.x
        player.I.y = I.destinationPosition.y

  return self
