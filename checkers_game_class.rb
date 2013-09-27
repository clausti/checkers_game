require './board_class.rb'
require './piece)_class.rb'
require './checkers_errors.rb'

class CheckersGame
  
  def initialize
    @board = Board.new
  end
  
  
  def make_king
    @board.make_king(position)
  end
  
end