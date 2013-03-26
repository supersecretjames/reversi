require "piece"
require "rspec"

describe Piece do

  it "has color" do
    piece = Piece.new(:black)
    piece.color.should == :black
  end

  describe "#color=" do
    it "sets the color of a piece" do
      piece = Piece.new(:black)
      piece.color = :white
      piece.color.should == :white
    end
  end
end

#REV might be nice to have a flip method, to flip the color