class HumanPlayer
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def move   
    print "Move from? "
    start_pos = gets.chomp.split(', ').map! {|el| el.to_i}
    print "Move to? "
    end_pos = gets.chomp.split(', ').map! {|el| el.to_i}
    [start_pos, end_pos]
  end

end

class ComputerPlayer
  
end