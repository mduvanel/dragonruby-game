class BackgroundElement
  def initialize(offset)
    @offset = offset
  end

  def render(outputs)
    @sprites.each { |s|
      s.render(outputs, @offset, 0)
    }
  end

  def tick(outputs)
    render(outputs)
  end
end

class House < BackgroundElement
  def initialize(offset)
    @sprites = Array[
      MySprite.new(64, 128, [128, 0], 'sprites/TileA3.png'),
      MySprite.new(32, 64, [224, 128], 'sprites/TileC.png', 16, 0),
    ]
    super
  end
end