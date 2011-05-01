Lever = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    triggered: false

  self = GameObject(I)

  self.bind "step", ->
    unless I.triggered
      if I.cat
        player = engine.find("Cat").first()

      if player && Collision.rectangular(self.bounds(), player.collisionBounds())
        I.triggered = true
        I.sprite = Sprite.loadByName("lever_triggered")
        Sound.play "trigger"


  return self
