Text = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  GameObject(I).extend
    draw: (canvas) ->
      canvas.font("bold 11pt consolas, 'Courier New', 'andale mono', 'lucida console', monospace")
      canvas.fillColor "#FFF"
      canvas.centerText I.message, I.y

