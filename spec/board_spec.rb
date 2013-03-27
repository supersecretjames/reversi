require 'rspec'
require 'board'
require 'piece'

describe Board do

  describe "::make_start_grid" do
    subject(:grid) { Board.make_start_grid } #REV nice test
    it "returns an 8x8 grid" do
      grid.count.should == 8
      grid.each do |row|
        row.count.should == 8
      end
    end

    it "grid has starting pieces in correct location" do
      WHITES = [[3,3], [4,4]]
      BLACKS = [[3,4], [4,3]]

      grid.each_with_index do |rows, i|
        rows.each_with_index do |square, j|
          square.color.should == :white if WHITES.include?([i,j])
          square.color.should == :black if BLACKS.include?([i,j])
          square.should be_nil unless (WHITES + BLACKS).include?([i,j])
        end
      end
    end
  end

  describe "#grid" do
    let(:grid) { Board.make_start_grid }
    subject(:board) { Board.new(grid) }
    let(:position) { [3,3] }

    it "returns the grid" do
      board.grid.should == grid
    end

    it "should override [] method to lookup grid pos" do
      board[position].should == board.grid[position[0]][position[1]]
    end
  end

  #REV i feel like line builder is only used internally, so it's a bit weird to test it
  describe "#line_builder" do  
    subject(:board) { Board.new }
    let(:origin) { [2,3] }
    let(:bad_origin) { [3,3] }
    let(:color) { :black }
    let(:delta) { [1,0] }
    let(:bad_delta) { [1,1] }

    it "raises error if origin not nil" do
      expect do
         board.line_builder(bad_origin, delta, color)
       end.to raise_error("Origin not empty")
    end

    it "returns line from valid origin, delta, and color" do
      board.line_builder(origin, delta, color).should == [[2,3],[3,3],[4,3]]
    end

    it "returns end piece of specified color" do
      position = board.line_builder(origin, delta, color).last
      board[position].color.should == color
    end

    it "returns middle pieces of opposite color" do
      middle = board.line_builder(origin, delta, color)[1]
      board[middle].color.should_not == color
    end

    it "returns nil when no valid line" do
      board.line_builder(origin, bad_delta, color).should be_nil
    end
  end

  describe "#valid_lines" do
    subject(:board) { Board.new }
    let(:empty_position) { [2,3] }
    let(:full_position) { [3,3] }
    let(:off_position) { [9,3] }
    let(:color) { :black }

    it "returns nil if specified origin has piece" do
      board.valid_lines(full_position, color).should be_nil
    end

    it "returns nil if origin is off board" do
      board.valid_lines(off_position, color).should be_nil
    end

    it "returns all possible lines for example grid and origin" do
      board.valid_lines(empty_position, color).should == [[[2,3],[3,3],[4,3]]]
    end
  end

  #REV might be nice to check that the colors are flipped after a certain piece is placed
  describe "#place_piece" do
    subject(:board) { Board.new }
    let(:empty_position) { [2,3] }
    let(:full_position) { [3,3] }
    let(:color) { :black }
    let(:line) { [[2,3], [3,3], [4,3]] }

    it "raises error if there are no valid lines" do
      expect do
        board.place_piece(full_position, color).should
      end.to raise_error("No valid lines")
    end

    it "places a piece at location" do
      board.place_piece(empty_position, color)
      board[empty_position].should_not be_nil
    end

    it "placed piece is correct color" do
      board.place_piece(empty_position, color)
      board[empty_position].color.should == color
    end

    it "line for specified location is correct color" do
      board.place_piece(empty_position, color)
      line.each do |position|
        board[position].color.should == color
      end
    end
  end

  describe "#valid_moves?" do
    subject(:board) do
      grid = Array.new(8) {Array.new(8, nil)}
      grid = Board.place_pieces(grid, [[3,6]], :black)
      grid = Board.place_pieces(grid, [[3,7]], :white)
      Board.new(grid)
     end

    let(:no_moves_color) { :black }
    let(:has_moves_color) { :white }

    it "returns true if player has a valid move" do
      board.valid_moves?(has_moves_color).should be_true
    end

    it "returns false if player has no valid move" do
      board.valid_moves?(no_moves_color).should be_false
    end
  end

  describe "count_pieces" do
    let(:color) { :black }
    let(:no_pieces_color) { :white }
    subject (:board) do
      grid = Array.new(8) {Array.new(8, nil)}
      positions = (0...8).to_a.map { |i| [i,i] }
      grid = Board.place_pieces(grid, positions, color)
      board = Board.new(grid)
    end

    it "counts pieces of certain color" do
      board.count_pieces(color).should == 8
    end

    it "returns zero if no pieces matching color" do
      board.count_pieces(no_pieces_color).should == 0
    end
  end
end