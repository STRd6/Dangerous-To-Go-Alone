Player = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  self = GameObject(I)

  self.bind "step", ->
    if keydown.left
      I.x -= 2
    if keydown.right
      I.x += 2
    if keydown.up
      I.y -= 2
    if keydown.down
      I.y += 2

  self

