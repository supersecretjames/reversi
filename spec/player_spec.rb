require 'rspec'
require 'player'
require 'board'

describe Player do
  let(:color) { :black }
  subject(:player) { Player.new(color) }

  it "has a color" do
    player.color.should == color
  end

  describe "#get_move" do
    let(:color) { :black }
    subject(:player) { Player.new(color)}  #REV i feel like this could probably be a double
    let(:board) { Board.new }

    it "returns a valid position" do
      player.stub(:get_user_input => [2, 3])
      move = player.get_move(board)
      #REV this looks like its testing the board. maybe you could just do
      #move.should be something?
      board.valid_lines(move, color).should_not be_nil 
    end
  end
end