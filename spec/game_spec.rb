require 'rspec'
require 'game'
#require 'piece'

describe Game do

  describe "#game_over?" do
    let(:board) { double("board") }
    subject(:game) { Game.new(:board => board) }

    it "returns true if neither player has a valid move" do
      board.stub(:valid_moves?).and_return(false)
      game.game_over?.should be_true
    end

    it "returns false if one player has a valid move" do
      board.stub(:valid_moves?).and_return(false,true)
      game.game_over?.should be_false
    end
  end

  describe "#play" do
    subject(:board) do
      grid = Array.new(8) {Array.new(8, nil)}
      grid = Board.place_pieces(grid, [[3,6]], :black)
      grid = Board.place_pieces(grid, [[3,7]], :white)
      Board.new(grid)
    end
    let(:has_moves_player) { Player.new(:white) }
    let(:no_moves_player) { Player.new(:black) }
    let (:players) { {:white => has_moves_player, :black => no_moves_player} }

    it "skips player if player has no valid move" do
      game = Game.new(:board => board, :players => players)
      no_moves_player.should_not_receive(:get_move)
      has_moves_player.stub(:get_move).and_return([3,5])

      game.play
    end
  end
end
