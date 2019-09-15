$dragon.require 'app/background.rb'
$dragon.require 'app/character.rb'
$dragon.require 'app/scene.rb'

$scene = Scene.new(1000, 500)
$scene.add_background_element(WoodenFloor.new([200, 160], 28, 14))
$scene.add_character(Character.new('sprites/hero.png', 640, 360))

def tick args
  $scene.tick(args.inputs, args.outputs)
end
