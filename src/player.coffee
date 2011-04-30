Player = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    speed: 4
    excludedModules: ["Movable"]

  self = GameObject(I)

  walkCycle = 0

  collisionMargin =
    x: 2
    y: 2

  collisionBounds = (xOffset, yOffset) ->
    x: I.x + (xOffset || 0) + collisionMargin.x
    y: I.y + (yOffset || 0) + collisionMargin.y
    width: I.width - 2 * collisionMargin.x
    height: I.height - 2 * collisionMargin.y

  self.bind "step", ->
    movement = Point(0, 0)

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
      walkCycle += 1

      movement = movement.norm().scale(I.speed)
      I.velocity = movement

      I.velocity.x.abs().times ->
        if !engine.collides(collisionBounds(I.velocity.x.sign(), 0), self)
          I.x += I.velocity.x.sign()
        else 
          I.velocity.x = 0

      I.velocity.y.abs().times ->
        if !engine.collides(collisionBounds(0, I.velocity.y.sign()), self)
          I.y += I.velocity.y.sign()
        else 
          I.velocity.y = 0

  self

