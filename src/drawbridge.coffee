Drawbridge = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    solid: true

  I.sprite = Sprite.NONE

  #TODO Trigger lowering

  GameObject(I)

