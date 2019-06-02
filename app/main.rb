$dragon.require 'app/background.rb'
$dragon.require 'app/character.rb'
$dragon.require 'app/scene.rb'

$scene = Scene.new(1000, 500)
$scene.addBackgroundElement(House.new([300, 300]))
$scene.addCharacter(Character.new('sprites/old_man.png', 640, 360))

def tick args
  $scene.tick(args.inputs, args.outputs)
end
