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
    movement = Point(0, 0)

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

    if I.age > 10 && keydown.space
      player = engine.find("Player").first()

      if player && Collision.rectangular(self.bounds(), player.collisionBounds())
        I.active = false
        player.I.state.cat = false
        player.pickup self

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

  self

