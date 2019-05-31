module Direction
  SOUTH = 0
  WEST = 1
  EAST = 2
  NORTH = 3
  NONE = 4
end

class MySprite
  def initialize(width, height, file_offset, file, x_offset = 0, y_offset = 0)
    @width = width
    @height = height
    @file_offset = [file_offset, width, height]
    @file = file
    @opacity = 255
    @saturation = [255, 255, 255]
    @x_offset = x_offset
    @y_offset = y_offset
  end

  def render(outputs, position, angle)
    zipped = position.zip([@x_offset, @y_offset])
    new_offset = position.zip([@x_offset, @y_offset]).map{ |elem|
      elem.inject(0, :+)
    }
    #puts 'Rendering sprite ' + @file.to_s
    #puts ' position = ' + position.to_s
    #puts ' new_offset = ' + new_offset.to_s
    outputs.sprites << [new_offset,
                        @width,
                        @height,
                        @file,
                        angle,
                        @opacity,
                        @saturation,
                        @file_offset]
  end
end
