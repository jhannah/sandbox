require "./rps_game_class.rb"

puts "Welcome to the game. Let's play Rock Paper Scissors, Spock, Lizard! "

puts "How many games would you like to play? "

#instantiates a new instance of the game class and passes it the number #indicated by the user.
game1 = Game.new(gets.chomp.to_f)

#asks for the name of each player and calls the get_name method
puts " Please enter your name: "
name = gets.chomp
game1.get_name(1, name)
puts " Please enter your name: "
name = gets.chomp
game1.get_name(2, name)
  

#sets game_winner to nil and starts a while loop so the correct number of games #can be played.  In the while loop we ask for moves and make sure they are valid.
game_winner = nil

while game_winner == nil
  puts "Make your move: #{game1.player1.name}" 
    is_valid = game1.get_move(1, gets.chomp)
  while is_valid == false
    puts "Invalid entry: Please enter your move: "
    is_valid = game1.get_move(1, gets.chomp)
  end
  puts " Please enter your move: #{game1.player2.name} "
  is_valid = game1.get_move(2, gets.chomp)
 while is_valid == false
   puts "Invalid entry: Please enter your move: "
   is_valid = game1.get_move(2, gets.chomp)
 end

#calls the determine game winner method (which takes both player objects as arguemnts) and then iterpolates the answer and calls the name attribute)

puts "#{game1.determine_game_winner(game1.player1, game1.player2).name} wins!"

#calls determine match winner to see if it is still nil, or if one of the players has met the required wins.  If so, puts it.
game_winner = game1.determine_match_winner
  if game_winner != nil
    puts "#{game_winner.name} wins it all."
  end
end