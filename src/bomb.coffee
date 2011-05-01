Bomb = (I) ->
  $.reverseMerge I,
    width: 16
    height: 16

  I.sprite = Sprite.loadByName("bomb")

  self = GameObject(I)

  self.bind "step", ->
    if I.age >= 60
      self.destroy()

  self.bind "destroy", ->
    engine.find("BombDoor").select (door) ->
      Collision.rectangular(self.bounds(), door.bounds())
    .each (door) ->
      door.open()

  self

