Stream = (I) ->
  $.reverseMerge I,
    width: 32
    height: 32

  self = GameObject(I).extend
    draw: (canvas) ->
      offset = (-I.age/2).floor().mod(32)
      source = Stream.fillSource.element()
      canvas.drawImage source, 0, offset, I.width, I.height, I.x, I.y, I.width, I.height

  unless Stream.fillSource
    Stream.fillSource = $("<canvas width='128' height='128'></canvas>").powerCanvas()

    Sprite.loadByName "water0", (waterSprite) ->
      waterSprite.fill(Stream.fillSource, 0, 0, 128, 128)

  self

