module Direction
  SOUTH = 0
  WEST = 1
  EAST = 2
  NORTH = 3
  NONE = 4
end

class MySprite
  attr_accessor :width, :height, :file, :opacity, :saturation, :offset

  def initialize(width, height, offset, file)
    @width = width
    @height = height
    @offset = [offset, width, height]
    @file = file
    @opacity = 255
    @saturation = [255, 255, 255]
  end

  def render(outputs, position, angle)
    outputs.sprites << [position,
                        @width,
                        @height,
                        @file,
                        angle,
                        @opacity,
                        @saturation,
                        @offset]
  end
end
