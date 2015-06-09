class Player
  attr_accessor :name, :move, :score
  
  # initialize method
  #
  # name  - The String that sets the player's name
  # score - The Integer number of times the player has won games.  Initialized 
  # at 0.
  #
  # Returns self
  def initialize(name, score: 0)
    @name = name
    @score = score  
  end
end