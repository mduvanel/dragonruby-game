class Scene
  def initialize(width, height)
    @width = width
    @height = height
    @background_elements = Array.new
  end

  def add_background_element(element)
    @background_elements << element
  end

  def add_character(character)
    @character = character
  end

  def render(outputs, x, y, width, height)
    # for now render everything, even if out of screen
    @background_elements.each { |element|
      element.render(outputs)
    }
    @character.render(outputs)
  end

  def can_move(bounding_box)
    return @background_elements.all? { |elem|
      !elem.collides(bounding_box)
    }
  end

  def move_if_possible(offset)
    if offset.any? { |x| x != 0 }
      # Compute new character position
      new_bb = @character.bounding_box.zip(offset).collect { |x, y| x.to_f + y.to_f }

      # Check that character can move to the new position
      if can_move(new_bb)
        @character.move(offset)
      end
    end
  end

  def tick(inputs, outputs)
    offset = @character.process_inputs(inputs)

    move_if_possible([offset[0], 0])
    move_if_possible([0, offset[1]])

    render(outputs, 0, 0, 1280, 720)
  end
end
