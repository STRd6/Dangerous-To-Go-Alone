Stream = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  self = GameObject(I)

  Stream.sprites ||= [
    Sprite.loadByName "water"
    Sprite.loadByName "water1"
  ]

  self.bind "step", ->
    I.sprite = Stream.sprites.wrap (I.age / 4).floor()

  self

