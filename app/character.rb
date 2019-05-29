$dragon.require('app/my_sprite.rb')

class Character < MySprite
  attr_accessor :x, :y, :direction, :walk_counter

  def initialize(file, x, y)
    super(32, 48, [0, 0], file)
    @x = x
    @y = y
    @direction = Direction::SOUTH
    @walk_sprites = [0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1]
    @walk_counter = @walk_sprites.size - 1
  end

  def tick(inputs, outputs)
    process_inputs(inputs)
    render_char(outputs)
  end

  def update_source_rect
    @offset = [@walk_sprites[@walk_counter] * @width,
               @direction * @height,
               @width,
               @height]
  end

  def reset_walk_sprite
    @walk_counter = @walk_sprites.size - 1
  end

  def increment_walk_sprite
    @walk_counter = (@walk_counter + 1) % @walk_sprites.size
  end

  def first_walk_sprite
    @walk_counter = 0
  end

  def process_inputs(inputs)
    if inputs.keyboard.key_held.left
      direction = Direction::WEST
    elsif inputs.keyboard.key_held.right
      direction = Direction::EAST
    elsif inputs.keyboard.key_held.up
      direction = Direction::NORTH
    elsif inputs.keyboard.key_held.down
      direction = Direction::SOUTH
    else
      direction = Direction::NONE
      reset_walk_sprite
      return
    end

    if direction == @direction
      increment_walk_sprite
    else
      first_walk_sprite
    end

    @direction = direction
  end

  def render_char(outputs)
    update_source_rect
    render(outputs, [x, y], 0)
  end
end