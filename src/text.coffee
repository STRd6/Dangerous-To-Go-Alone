Text = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  GameObject(I).extend
    draw: (canvas)
      canvas.fillColor "#FFF"
      canvas.centerText I.message, I.y

