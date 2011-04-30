Player = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    speed: 4

  self = GameObject(I)

  walkCycle = 0

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

    unless movement.equal(Point(0, 0))
      walkCycle += 1
      movement = movement.norm().scale(I.speed)
      I.x += movement.x
      I.y += movement.y

  self

