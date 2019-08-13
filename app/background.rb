$dragon.require('app/my_sprite.rb')

class BackgroundElement

  include BoundingBox

  def initialize(offset)
    @offset = offset
  end

  def render(outputs)
    @sprites.each { |s|
      s.render(outputs, @offset, 0)
    }
  end

  def z_order()
    return @bounding_box[1]
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
    @bounding_box = [offset[0], offset[1], 64, 64]
    super
  end
end

class WoodenFloor < BackgroundElement
  def initialize(offset, x, y)
    @sprites = Array.new
    for i in 0..x - 1
      for j in 0..y - 1
        @sprites << MySprite.new(32, 32, [0, 128], 'sprites/TileA5.png', 32 * i, 32 * j)
      end
    end
    # Z order is bounding_box[1]
    @bounding_box = [0, 20000, 0, 0]
    super(offset)
  end
end