require_relative 'board.rb'

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
    i = "87654321".index(input[-1])
    j = "abcdefgh".index(input[0])
    [i,j]
  end

  def display(board)
    grid = board.grid
    print "   ".black.on_white
    ("a".."h").each {|letter| print " #{letter} ".black.on_white }
    print "   ".black.on_white
    puts
    grid.each_with_index do |row, rank|
      print " #{8-rank} ".black.on_white
      row.each_with_index do |piece, file|
        print display_tile(piece, rank, file)
      end
      print " #{8-rank} ".black.on_white
      puts
    end
    print "   ".black.on_white
    ("a".."h").each {|letter| print " #{letter} ".black.on_white }
    print "   ".black.on_white
    puts
    nil
  end

  def display_tile(piece, rank=0, file=0)
     background = (rank + file).odd? ? :green : :light_green
     foreground = :red
     piece_display = "   "
     unless piece.nil?
       foreground = piece.color == :black ? :black : :white
       piece_display = " \u25cf "
     end
     piece_display.colorize(:color => foreground, :background => background)
   end
end