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
    @walk_speed = 1.5
  end

  def tick(inputs)
    process_inputs(inputs)
  end

  def update_source_rect
    @file_offset = [@walk_sprites[@walk_counter] * @width,
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
    key_down = false

    if inputs.keyboard.key_held.left
      direction = Direction::WEST
      @x -= @walk_speed
      key_down = true
    end

    if inputs.keyboard.key_held.right
      direction = Direction::EAST
      @x += @walk_speed
      key_down = true
    end

    if inputs.keyboard.key_held.up
      direction = Direction::NORTH
      @y += @walk_speed
      key_down = true
    end

    if inputs.keyboard.key_held.down
      direction = Direction::SOUTH
      @y -= @walk_speed
      key_down = true
    end

    if !key_down
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

  def render(outputs)
    update_source_rect
    super(outputs, [@x, @y], 0)
  end
end