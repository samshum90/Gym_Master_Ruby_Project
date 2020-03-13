require_relative('../models/groupexercise')

require("pry-byebug")

GroupExercise.delete_all

groupexercises1 = GroupExercise.new({'name' => 'pilates', 'start_time' => '13:00:00', 'price' => 5.00, 'capacity' => 10})
groupexercises1.save


binding.pry
nil
