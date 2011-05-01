Lava = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32
    solid: true

  self = GameObject(I).extend
    draw: (canvas) ->
      offsetX = (-I.age/7).floor().mod(I.width)
      offsetY = (-I.age/16).floor().mod(I.height)
      source = Lava.fillSource.element()
      canvas.drawImage source, offsetX, offsetY, I.width, I.height, I.x, I.y, I.width, I.height

  unless Lava.fillSource
    Lava.fillSource = $("<canvas width='128' height='128'></canvas>").powerCanvas()

    Sprite.loadByName "lava", (lavaSprite) ->
      lavaSprite.fill(Lava.fillSource, 0, 0, 128, 128)

  self

