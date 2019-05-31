$dragon.require 'app/background.rb'
$dragon.require 'app/character.rb'

$character = Character.new('sprites/old_man.png', 640, 360)
$house = House.new([300, 300])

def tick args
  $house.tick(args.outputs)
  $character.tick(args.inputs, args.outputs)
end
