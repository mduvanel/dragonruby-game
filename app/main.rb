#require_relative 'character'
module Direction
  SOUTH = 0
  WEST = 1
  EAST = 2
  NORTH = 3
  NONE = 4
end

class Character
  attr_accessor :x, :y, :width, :height, :direction, :walk_counter, :inputs, :outputs

  def tick
  	defaults
    process_inputs
    render
  end

  def defaults
    @x ||= 640
    @y ||= 360
    @width ||= 32
    @height ||= 48
    @direction ||= Direction::SOUTH
    @walk_sprites ||= [0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1]
    @walk_counter ||= @walk_sprites.size - 1
  end

  def get_source_rect
    [@walk_sprites[@walk_counter] * @width, @direction * @height, @width, @height]  
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

  def process_inputs
    if @inputs.keyboard.key_held.left
      direction = Direction::WEST
    elsif @inputs.keyboard.key_held.right
      direction = Direction::EAST
    elsif @inputs.keyboard.key_held.up
      direction = Direction::NORTH
    elsif @inputs.keyboard.key_held.down
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

  def render
    @outputs.sprites << [
      x, y, @width, @height, # target rect
      'sprites/old_man.png',
      0, # rotation
      255, # opacity
      255, 255, 255, # saturation
      get_source_rect] # source rect
  end
end

$character = Character.new

def tick args
  $character.outputs = args.outputs
  $character.inputs = args.inputs
  $character.tick
  args.outputs.labels << [ 475, 150, '(Consider reading README.txt now.)' ]
  #args.outputs.sprites << [640, 360, 32, 48, 'sprites/old_man.png']
end
