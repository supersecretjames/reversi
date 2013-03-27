require_relative 'board.rb'
require_relative 'player.rb'
require 'colorize'

class Game
  def initialize(options = {})   #nice use of defaults
    defaults = {
      :board => Board.new,
      :players => { :white => Player.new(:white),
                    :black => Player.new(:black)  }
    }

    options = defaults.merge(options)

    @board = options[:board]
    @players = options[:players]
    @current_player = :black
  end

  def game_over?
    !@board.valid_moves?(:white) && !@board.valid_moves?(:black)
  end

  def winner
    case @board.count_pieces(:black) <=> @board.count_pieces(:white) #REV nice way to do this
      when 1 then :black
      when -1 then :white
      when 0 then nil
    end
  end

  def play
    until game_over?
      if @board.valid_moves?(@current_player)
        move = @players[@current_player].get_move(@board)
        @board.place_piece(move, @current_player)
      end
      @current_player = (@current_player == :black ? :white : :black)
    end
    puts "Game over."
    puts "#{winner.capitalize} wins!" unless winner.nil?
    puts "Draw game." if winner.nil?
  end
end
