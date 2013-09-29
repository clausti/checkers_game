require 'colorize'


class Piece
  attr_reader :color
  
  def initialize(color) #should be a symbol
    @color = color
    @is_king = false
  end
  
  def display
    if @is_king
      "(K".colorize( :color => color, :background => :green )
    else
      "()".colorize( :color => color, :background => :green )
    end
  end
  
  def king_me
    @is_king = true
  end
  
  def valid_move?(delta, jump)
    row_delta, col_delta = delta
    return false if row_delta == 0
    return false if col_delta == 0
    
    return false unless (row_delta.abs == col_delta.abs)
    return false if col_delta.abs > 1 unless (jump || @is_king)
    return false if col_delta.abs > 2 #make one move at a time
    
    if @color == :white && !@is_king
      return false if row_delta < 0
    elsif @color == :red && !@is_king
      return false if row_delta > 0
    end
    
    true
  end
  
end
