Mouse = (I) ->
  $.reverseMerge I,
    name: "mouse"
    width: 12
    height: 12
    speed: 1
    excludedModules: ["Movable"]

  collisionMargin =
    x: 2
    y: 1

  I.sprite = Sprite.loadByName("mouse")

  self = GameObject(I).extend
    collisionBounds: (xOffset, yOffset) ->
      x: I.x + (xOffset || 0) + collisionMargin.x
      y: I.y + (yOffset || 0) + collisionMargin.y
      width: I.width - 2 * collisionMargin.x
      height: I.height - 2 * collisionMargin.y

  self.bind "step", ->
    movement = Point(0, 0)

    cooldown = cooldown.approach(0, 1)

    if I.age > 10 && keydown.space
      cat = engine.find("Cat").first()

      if cat && Collision.rectangular(self.bounds(), cat.bounds())
        I.active = false
        cat.I.state.mouse = false
        cat.pickup self
      else
        unless cooldown
          Sound.play "squeak"
          cooldown += 30

    if keydown.left
      movement = movement.add(Point(-1, 0))
    if keydown.right
      movement = movement.add(Point(1, 0))
    if keydown.up
      movement = movement.add(Point(0, -1))
    if keydown.down
      movement = movement.add(Point(0, 1))

    if movement.equal(Point(0, 0))
      I.velocity = movement
    else
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

    I.x = I.x.clamp(0, 480 - I.width)
    I.y = I.y.clamp(0, 320 - I.height)

  self
