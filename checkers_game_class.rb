require './board_class.rb'
require './piece)_class.rb'

class CheckersGame
  
  def initialize
    @board = Board.new
    @players = { :white => HumanPlayer.new(:white), 
                   :red => HumanPlayer.new(:red) }
    @active_player = @players(:red)
    play
  end
  
  def play
    @board.render
    
    until @board.has_no_pieces(@active_player.color)
      begin  
        one_turn
      rescue StandardError => err
        puts err.message
        retry
      end
      @board.render
      @active_player = (@active_player.color == :red) ? @players[:white] : @players[:red]
    end
    loser = @active_player.color.to_s.capitalize
    winner = (@active_player.color == :red) ? @players[:white] : @players[:red]
    winner = winner.color.to_s.capitalize
    
    puts "#{loser} has no more peices! #{winner} wins!"
  end
  
  def one_turn
    start_pos, end_pos = ask_player_move_input
    raise StandardError, "You can't move like that!" unless @board.valid_move?(start_pos, end_pos)
  end
  
  def ask_player_move_input
    @active_player.move
    #needs to return a two-D two_element array [[start_row, start_col], [end_row, end_col]]
  end
  
  def make_king
    @board.make_king(position)
  end
  
end