Drawbridge = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    solid: true

  I.sprite = Sprite.NONE

  if leverTriggered "bridgeLever"
    I.sprite = Sprite.loadByName("wood_floor")
    I.solid = false

  GameObject(I)

