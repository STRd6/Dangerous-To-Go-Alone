Player = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  self = GameObject(I)

  self.bind "step", ->
    if keydown.left
      I.x -= 1

    if keydown.right
      I.x += 1

  self

