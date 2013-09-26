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
        puts "green square"
        if row_idx == 0 || row_idx == 1 || row_idx == 2
          puts "white row"
          @grid[row_idx][col_idx] = Piece.new(:white)
        elsif row_idx == 5 || row_idx == 6 || row_idx == 7
          puts "red row"
          @grid[row_idx][col_idx] = Piece.new(:red)
        end
      else  
        puts "yellow square"
        square_contents = nil
      end
    end
  end
  
  def render
    iterate_through_grid do |square_contents, row_idx, col_idx|
      background_col = :green if (row_idx + col_idx).odd?
      background_col = :yellow if (row_idx + col_idx).even?
      if square_contents.nil?
        print "  ".colorize( :background => background_col)
      elsif square_contents.class == Piece
        print square_contents.display
      end 
      puts if col_idx == 7
    end
  end
  
  def piece_at(position) #position will be two-element array of row, col
    # returns the piece at the given coordinates
    row, column = position
    @grid[row][column] #will return piece object or nil
  end
  
  def move_piece(start_pos, end_pos)
    
  end
  
  def make_king(position)
    piece_at(position).is_king = true
  end
  
  def iterate_through_grid(&code_block)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square_contents, col_idx|
        code_block.call(square_contents, row_idx, col_idx)
      end
    end
  end
    
  
end