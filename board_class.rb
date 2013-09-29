require 'colorize'
require './piece_class.rb'

class Board
  
  def initialize
    @grid = Array.new(8){Array.new(8)}
    populate_board
  end
  
  def populate_board
    iterate_through_grid do |square_contents, row_idx, col_idx|
      if (row_idx + col_idx).odd?
        if row_idx == 0 || row_idx == 1 || row_idx == 2
          @grid[row_idx][col_idx] = Piece.new(:white)
        elsif row_idx == 5 || row_idx == 6 || row_idx == 7
          @grid[row_idx][col_idx] = Piece.new(:red)
        end
      else  
        square_contents = nil
      end
    end
  end
  
  def render
    iterate_through_grid do |square_contents, row_idx, col_idx|
      background_col = :green if (row_idx + col_idx).odd?
      background_col = :yellow if (row_idx + col_idx).even?
      print "Row: #{8 - row_idx} " if col_idx == 0
      if square_contents.nil?
        print "  ".colorize( :background => background_col)
      elsif square_contents.class == Piece
        print square_contents.display
      end 
      puts if col_idx == 7
    end
    puts " a b c d e f g h ".rjust(23, " ")
  end
  
  def has_no_pieces?(color)
    iterate_through_grid do |square_contents, row_idx, col_idx|
      next if square_contents.nil?
      return false if square_contents.color == color
    end
    true
  end
  
  def valid_move?(start_pos, end_pos, jump)
    return false unless piece_at(end_pos).nil?
    delta = move_delta(start_pos, end_pos)
    piece_at(start_pos).valid_move?(delta, jump)
  end
  
  def piece_at(position) #position will be two-element array of row, col
    row, column = position
    @grid[row][column] #will return piece object or nil
  end
  
  def move_delta(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos
    [(end_row - start_row), (end_col - start_col)]
  end
  
  def move_piece(current_pos, end_pos) #for multiple jumps or a long slide, make one move at a time
    piece = piece_at(current_pos)
    @grid[current_pos[0]][current_pos[1]] = nil
    @grid[end_pos[0]][end_pos[1]] = piece
  end
  
  def is_jump?(start_pos, end_pos)
    return false unless piece_at(end_pos).nil?
    
    piece = piece_at(start_pos)
    row_delta, col_delta = move_delta(start_pos, end_pos)
    return false unless row_delta.abs == 2 #one jump at a time
    
    jumped_square = jump_square(start_pos, end_pos) 
    return false if piece_at(jumped_square).nil?
    return false if piece.color == piece_at(jumped_square).color
    true
  end
  
  def jump_square(start_pos, end_pos) #assumes valid jump, [2, 2] move delta
    start_row, start_col = start_pos
    end_row, end_col = end_pos
    jumped_row = (start_row + end_row) / 2
    jumped_col = (start_col + end_col) / 2
    [jumped_row, jumped_col]
  end
  
  def remove_jumped_piece(jumped_square) #coordinates
    jumped_row, jumped_col = jumped_square
    @grid[jumped_row][jumped_col] = nil
  end
  
  def king_move?(end_pos, color)
    row, col = end_pos
    if color == :red
      return false unless row == 0
    end
    if color == :white
      return false unless row == 7
    end
    true
  end
  
  def make_king(position)
    piece_at(position).king_me
  end
  
  def iterate_through_grid(&code_block)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square_contents, col_idx|
        code_block.call(square_contents, row_idx, col_idx)
      end
    end
  end
    
end