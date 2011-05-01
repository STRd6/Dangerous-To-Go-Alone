Gate = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    solid: true

  if leverTriggered I.lever
    I.sprite = Sprite.NONE
    I.solid = false

  self = GameObject(I)

  return self

