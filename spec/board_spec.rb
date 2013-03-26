require 'rspec'
require 'board'
require 'piece'

describe Board do

  describe "::make_start_grid" do
    it "returns an 8x8 grid" do
      board.grid.count.should == 8
      board.grid.each do |row|
        row.count.should == 8
      end
    end

    it "grid has starting pieces in correct location" do
      board.grid.each_with_index do |rows, i|
    end
  end

  describe "#new" do
    it "takes a grid and sets board.grid accordingly"
  end

  describe "#grid" do
    it "returns the grid"
  end

  describe "#valid_lines" do
    it "checks that specified origin is empty"
    it "checks that the origin is on the board"
    it "returns all possible lines for example grid and origin"
    it "calls #line_builder for each delta"
  end

  describe "#line_builder" do
    it "returns line when given valid origin, color, and delta"
    it "returned line is an array of positions"
    it "returned line starts with origin"
    it "returned line ends in a piece of specified color"
    it "returned line has middle pieces that are opposite of specified color"
    it "returns nil if there is no valid line from origin for given delta"
  end

  describe "#place_piece" do
    it "checks to see if the specified location is empty"
    it "places a piece of the specified color at specified location"
    it "flips the middle pieces for all valid lines for specified location"
  end

  describe "#set_line_color" do
    it "sets all pieces in a given line to a specified color"
  end
end