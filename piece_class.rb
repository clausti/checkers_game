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
    start_row, start_col = start_pos
    end_row, end_col = end_pos
    [(end_row - start_row), (end_col - start_col)]
  end
  
  def valid_move?(start_pos, end_pos, jump = false) 
    row_delta, col_delta = move_delta(start_pos, end_pos)
    
    return false if row_delta == 0
    return false if col_delta == 0
    return false unless (row_delta.abs == col_delta.abs)
    return false if col_delta > 1 unless (jump || is_king)
    
    if @color == :white && !is_king
      return false if row_delta < 0
    elsif @color == :red && !is_king
      return false if row_delta > 0
    end
    
    true
  end
  
end
