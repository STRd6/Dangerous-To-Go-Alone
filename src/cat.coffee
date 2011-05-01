Cat = (I) ->
  $.reverseMerge I,
    width: 16
    height: 16
    speed: 2
    excludedModules: ["Movable"]

  collisionMargin =
    x: 1
    y: 1

  walkCycle = 0
  mewDown = 0
  carriedItem = null

  I.sprite = Sprite.loadByName("cat")

  walkSprites =
    up: [Sprite.loadByName("cat_walk_up0"), Sprite.loadByName("cat_walk_up1")]
    right: [Sprite.loadByName("cat_walk_right0"), Sprite.loadByName("cat_walk_right1")]
    down: [Sprite.loadByName("cat_walk_down0"), Sprite.loadByName("cat_walk_down1")]
    left: [Sprite.loadByName("cat_walk_left0"), Sprite.loadByName("cat_walk_left1")]

  self = GameObject(I).extend
    collisionBounds: (xOffset, yOffset) ->
      x: I.x + (xOffset || 0) + collisionMargin.x
      y: I.y + (yOffset || 0) + collisionMargin.y
      width: I.width - 2 * collisionMargin.x
      height: I.height - 2 * collisionMargin.y

  self.bind "step", ->
    mewDown = mewDown.approach(0, 1)

    movement = Point(0, 0)
    inStream = false

    if I.age > 10 && keydown.space
      player = engine.find("Player").first()

      pickupItem = engine.find("Item").select (item) ->
        Collision.rectangular(self.bounds(), item.bounds())
      .first()

      if player && Collision.rectangular(self.bounds(), player.collisionBounds())
        I.active = false
        player.I.state.cat = false
        player.pickup self
      else if pickupItem
        carriedItem = pickupItem
        carriedItem.I.x = I.x
        carriedItem.I.y = I.y
        Sound.play "pickup"
      else
        unless mewDown
          Sound.play "mew"
          mewDown += 60

    engine.find("Stream").select (tile) ->
      Collision.rectangular(self.bounds(), tile.bounds())
    .each (stream) ->
      inStream = true
      movement = movement.add(stream.I.flow)

    if inStream
      unless mewDown
        Sound.play "mew"
        mewDown += 30

      if player = engine.find("Player").first()
        player.I.state.cat = false

      return

    if keydown.left
      movement = movement.add(Point(-1, 0))
      I.sprite = walkSprites.left.wrap((walkCycle/4).floor())
    if keydown.right
      movement = movement.add(Point(1, 0))
      I.sprite = walkSprites.right.wrap((walkCycle/4).floor())
    if keydown.up
      movement = movement.add(Point(0, -1))
      I.sprite = walkSprites.up.wrap((walkCycle/4).floor())
    if keydown.down
      movement = movement.add(Point(0, 1))
      I.sprite = walkSprites.down.wrap((walkCycle/4).floor())

    if movement.equal(Point(0, 0))
      I.velocity = movement
    else
      walkCycle += 1

      movement = movement.norm().scale(I.speed)
      I.velocity = movement

      I.velocity.x.abs().times ->
        if !engine.collides(self.collisionBounds(I.velocity.x.sign(), 0), self)
          I.x += I.velocity.x.sign()
        else 
          I.velocity.x = 0

      I.velocity.y.abs().times ->
        if !engine.collides(self.collisionBounds(0, I.velocity.y.sign()), self)
          I.y += I.velocity.y.sign()
        else 
          I.velocity.y = 0

      if carriedItem
        carriedItem.I.x = I.x
        carriedItem.I.y = I.y

  self

