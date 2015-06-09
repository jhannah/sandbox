require "./rps_player_class.rb"


class Game
  attr_accessor :total_number_of_games, :games_to_win, :game_count, :player1,
  :player2
  
  # initialize method
  #
  # total_number_of_games  - The Integer amount of how many games the player 
  # selects.
  # game_count - The Integer number of times the game has been played. 
  # Initialized at 0.
  #
  # Returns self
  def initialize(total_number_of_games, game_count: 0)
    @total_number_of_games = total_number_of_games
  end

  
  # method gets arguments of player number and name to instantiate a new
  # instance of the PlayerClass.
  # class with the name entered.
  #
  # name  - The String that sets the player's name
  # score - The Integer number of times the player has won games.  Initialized 
  # at 0.
  #
  # Returns self
  def get_name(player_number, name)
   if player_number == 1
     then @player1 = Player.new(name)
   else
    @player2 = Player.new(name)
   end
  end

    

  # method receives player(1 or 2) move and checks if it is true, if true,
  # assigns it to current move, otherwise returns false. 
  def get_move(player_number, current_move)
    if check_if_valid(current_move) == true
      if player_number == 1
        then
        @player1.move = current_move
      else
        @player2.move = current_move
      end
    else
      return false
    end
    return true
  end

  # method used to check if move is valid, returns boolean
  def check_if_valid(player_move)
    ["rock", "paper", "scissors", "spock", "lizard"].include?(player_move.downcase)
  end

  
  # receives the player1 and player2 objects and calls the move method.  Using
  # the result it then applies the game logic to determine the winner. 
  # (Does this by using p1's move as the key to see if p2's is contained, 
  # making them the loswer if so)
  def determine_game_winner(p1, p2)
    winning_choices = {spock: ["scissors", "rock"], paper: ["rock", "spock"], scissors: ["paper", "lizard"], rock: ["scissors", "lizard"], lizard: ["spock", "paper"]}
    
    if p1.move == p2.move
      winner = Player.new("Neither")
    elsif
      winning_choices[p1.move.to_sym].include?(p2.move.to_s)
      winner = p1
    else
      winner = p2
    end
    winner.score += 1
    return winner
  end

  #uses the number of games that the players input to determine the amount needed to win, then checks to see if either player's score attribute equals that number.  If so, returns that player, else returns nil
  def determine_match_winner
    @games_to_win = ((total_number_of_games / 2.0).floor) + 1
    if player1.score == games_to_win
      return player1
    elsif player2.score == games_to_win
      return player2
    else
      return nil
    end
  end
end




  
  
  