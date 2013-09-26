class Piece
  attr_accessor :is_king
  attr_reader :color # :white or :red
  
  def initialize(color) #should be a symbol
    @color = color
    @is_king = false
  end
  
  def display
    "()".colorize( :color => color, :background => :green )
  end
  
  def move_delta(start_pos, end_pos)
    #does math on the start_pos and end_pos
    #returns the delta
  end
  
  def valid_move?(start_pos, end_pos) 
    # pieces can only move forward
    # red starts at the bottom of the board, so row deltas in game notation (array accession) will be negative
    # white starts at top, so row deltas in game notation will be positive
    delta = move_delta(start_pos, end_pos)
    if @color == :white
      
    elsif @color == :red
      
    end
    #return true or false
  end
  
end
