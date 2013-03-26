class Player
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def get_move(board)
    display(board)
    move = get_user_input
    return move if board.valid_move?(move, color)
    puts "Not a valid move. Please enter a valid move."
    move = get_move(board)
  end

  def get_user_input
    puts "#{color.upcase} player, please enter your move (e.g. 'a2')"
    input = gets.chomp
    i = "12345678".index(input.last)
    j = "abcdefgh".index(input.first)
    [i,j]
  end

  def display(board)
    puts
  end
end