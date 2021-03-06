Lever = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    triggered: false

  if leverTriggered I.id
    I.sprite = Sprite.loadByName("lever_triggered")    

  self = GameObject(I)

  self.bind "step", ->
    unless I.triggered
      player = engine.find("Cat").first()

      if player && Collision.rectangular(self.bounds(), player.collisionBounds())
        I.triggered = true
        triggerLever I.id
        I.sprite = Sprite.loadByName("lever_triggered")
        Sound.play "trigger"

  return self

