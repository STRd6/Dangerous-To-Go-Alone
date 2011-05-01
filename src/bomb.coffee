Wall = (I) ->
  $.reverseMerge I,
    width: 16
    height: 16

  self = GameObject(I)

  self.bind "step", ->
    if I.age >= 60
      self.destroy()

  self.bind "destroy", ->


  self
