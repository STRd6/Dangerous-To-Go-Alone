Player = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    speed: 4

  self = GameObject(I)

  self.bind "step", ->
    if keydown.left
      I.x -= I.speed
    if keydown.right
      I.x += I.speed
    if keydown.up
      I.y -= I.speed
    if keydown.down
      I.y += I.speed

  self

