require './board_class.rb'
require './piece_class.rb'
require './player_classes.rb'

class CheckersGame
  
  def initialize
    @board = Board.new
    @players = { :white => HumanPlayer.new(:white), 
                   :red => HumanPlayer.new(:red) }
    @active_player = @players[:red]
    play
  end
  
  def play
    @board.render
    
    until @board.has_no_pieces?(@active_player.color)
      begin  
        one_turn
      rescue StandardError => err
        puts err.message
        retry
      end
      @board.render
      switch_active_player
    end
    loser = @active_player.color.to_s.capitalize
    winner = (@active_player.color == :red) ? @players[:white] : @players[:red]
    winner = winner.color.to_s.capitalize
    
    puts "#{loser} has no more peices! #{winner} wins!"
  end
  
  def one_turn(second_jump = false)
    puts "#{@active_player.color.to_s.capitalize}'s turn!" unless second_jump
    start_pos, end_pos = ask_player_move_input #validate input in player class
    is_jump = @board.is_jump?(start_pos, end_pos)
    
    if !@board.valid_move?(start_pos, end_pos, is_jump)
      if second_jump
        puts "That is not a valid jump."
        return
      else 
        raise StandardError, "You can't move like that."
      end
    end
    @board.move_piece(start_pos, end_pos)
    @board.piece_at(end_pos).king_me if @board.king_move?(end_pos, @active_player.color)
    jump(start_pos, end_pos) if is_jump
  end
  
  def switch_active_player
    @active_player = (@active_player.color == :red) ? @players[:white] : @players[:red]
  end
  
  def ask_player_move_input
    start_pos, end_pos = @active_player.move
    raise StandardError, "There's no piece there!" if @board.piece_at(start_pos).nil?
    raise StandardError, "That's not your piece!" if @board.piece_at(start_pos).color != @active_player.color
    [start_pos, end_pos]
  end
  
  def jump(start_pos, end_pos)
    @board.remove_jumped_piece(@board.jump_square(start_pos, end_pos))
    @board.render
    puts "Piece captured! Do you have another jump? (y/n)" 
    jump_again = gets.chomp
    one_turn(true) if jump_again == "y"
  end
  
  def make_king
    @board.make_king(position)
  end
  
end