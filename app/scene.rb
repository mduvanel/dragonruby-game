class Scene
  def initialize(width, height)
    @width = width
    @height = height
    @background_elements = Array.new
  end

  def addBackgroundElement(element)
    @background_elements << element
  end

  def addCharacter(character)
    @character = character
  end

  def render(outputs, x, y, width, height)
    # for now render everything, even if out of screen
    @background_elements.each { |element|
      element.render(outputs)
    }
    @character.render(outputs)
  end

  def tick(inputs, outputs)
    @character.tick(inputs)
    render(outputs, 0, 0, 1280, 720)
  end
end
