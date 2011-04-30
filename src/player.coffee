Player = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    x: 160
    y: 160
    state: {}
    speed: 4
    excludedModules: ["Movable"]

  I.sprite = Sprite.loadByName("player")
  walkSprite = I.sprite
  pickupSprite = Sprite.loadByName("player_get")

  pickupItem = null

  self = GameObject(I).extend
    collisionBounds: (xOffset, yOffset) ->
      x: I.x + (xOffset || 0) + collisionMargin.x
      y: I.y + (yOffset || 0) + collisionMargin.y
      width: I.width - 2 * collisionMargin.x
      height: I.height - 2 * collisionMargin.y

    pickup: (item) ->
      I.state.pickup = 15
      pickupItem = item

  walkCycle = 0

  collisionMargin =
    x: 2
    y: 2

  self.bind "draw", (canvas) ->
    if I.state.pickup && pickupItem
      pickupItem.draw(canvas, 8, -8)

  self.bind "step", ->
    movement = Point(0, 0)

    if I.state.pickup
      I.state.pickup -= 1
      I.sprite = pickupSprite
    else
      I.sprite = walkSprite
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

