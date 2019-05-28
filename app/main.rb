#$dragon.require 'app/background.rb'
$dragon.require 'app/character.rb'

$character = Character.new('sprites/old_man.png', 640, 360)
$character2 = Character.new('sprites/old_man.png', 800, 500)

def tick args
  $character.tick(args.inputs, args.outputs)
  $character2.tick(args.inputs, args.outputs)
end
