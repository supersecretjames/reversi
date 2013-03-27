require 'rspec'
require './lib/w1d1'

describe Array do
  describe "my_uniq" do

    it "returns an empty array if array is empty" do
      array = []
      array.my_uniq.should be_empty
    end

    it "returns a one-item array if array has one item" do
      array = [1]
      array.my_uniq.should == [1]
    end

    it "returns same array if no duplicates" do
      array = [1, 2, 3, 4, 5, 6]
      array.my_uniq.should == [1, 2, 3, 4, 5, 6]
    end

    it "removes duplicates from an array" do
      array = [1, 1, 2, 3, 4, "cat", "cat", "dog"]
      array.my_uniq.should == [1, 1, 2, 3, 4, "cat", "cat", "dog"].uniq
    end

  end

  describe "two_sum?" do

    it "returns false if array is empty" do
      array = []
      two_sum?(array).should be_false
    end

    it "returns false if array contains one number" do
      array = [1]
      two_sum?(array).should be_false
    end

    it "returns false if array contains no numbers that add to zero" do
      array = [1, 2, 3]
      two_sum?(array).should be_false
    end

    it "returns false if array has one zero" do
      array = [0, 1, 2, 3]
      two_sum?(array).should be_false
    end

    it "returns true if array has two numbers that add to zero" do
      array = [1, 2, 3, -2]
      two_sum?(array).should be_true
    end

    it "returns true if array has two zeros" do
      array = [0, 1, 2, 0, 3]
      two_sum?(array).should be_true
    end
  end
end

describe Tower do
  it "can be initialized with discs" do
    tower = Tower.new(3)
    tower.discs.should == [3,2,1]
  end

  it "can be initialized without discs" do
    tower = Tower.new(0)
    tower.discs.should == []
  end

  describe "discs" do
    it "shows all discs in a tower" do
      tower = Tower.new(4)
      tower.discs.should == [4,3,2,1]
    end
  end

  describe "take_disc" do
    it "returns top disc" do
      tower = Tower.new(3)
      tower.take_disc.should == 1
    end

    it "returns nil if tower has no discs" do
      tower = Tower.new(0)
      tower.take_disc.should == nil
    end

    it "removes taken disc from origin tower" do
      tower = Tower.new(2)
      tower.take_disc
      tower.discs.should == [2]
    end
  end

  describe "#valid_move?" do
    it "takes disc and returns false if disc is larger than tower's top disc" do
      tower = Tower.new(3)
      tower.take_disc
      tower.valid_move?(5).should be_false
    end

    it "returns true if disc is smaller than tower's top disc" do
      tower = Tower.new(3)
      tower.take_disc
      tower.valid_move?(1).should be_true
    end
  end

  describe "#put_disc" do
    it "pushes a disc into the top of the tower" do
      tower = Tower.new(3)
      tower.take_disc
      tower.put_disc(1)
      tower.discs.should == [3,2,1]
    end

    it "doesn't push a bigger disc onto a smaller disc" do
      tower = Tower.new(3)
      expect do
        tower.put_disc(2)
      end.to raise_error("invalid move, disc too big")
    end

    it "always allows you to put a disc on an empty tower" do
      tower = Tower.new(0)
      tower.put_disc(1)
      tower.discs.should == [1]
    end
  end
end


describe Hanoi do
  describe "::start_game" do
    it "starts the game"
  end

  describe "initialize" do
    subject(:game) { Hanoi.new_game(5) }
    it "creates three towers" do
      game.towers.count.should == 3
    end

    it "makes first tower of specified size" do
      game.towers[0].discs.count.should == 5
    end

    it "second tower is empty" do
      game.towers[1].discs.count.should == 0
    end

    it "third tower is empty" do
      game.towers[2].discs.count.should == 0
    end
  end

  describe "#move" do
    subject(:game) { Hanoi.new_game(5) }
    let(:tower1) { double('tower') }
    let(:tower2) { double('tower') }
    let(:tower3) { double('tower') }

    before(:each) do
      tower1.stub(:take_disc)
      tower2.stub(:valid_move?)
      tower2.stub(:put_disc)
    end

    it "moves a disc from one tower to the next" do

      tower1.should_receive(:take_disc).and_return(1)
      tower2.should_receive(:valid_move?).and_return(true)
      tower2.should_receive(:put_disc).and_return(nil)

      game.move(tower1, tower2)
    end

    it "should ignore illegal moves" do

      tower1.should_receive(:take_disc).and_return(1)
      tower2.should_receive(:valid_move?).and_return(false)
      tower1.should_receive(:put_disc).with(1).and_return(nil)

      game.move(tower1, tower2)
    end
  end

  describe "#turn" do
    let(:tower1) { double('tower') }
    let(:tower2) { double('tower') }
    let(:tower3) { double('tower') }
    let(:player) { double('player') }
    subject(:game) { Hanoi.new([tower1, tower2, tower3], player) }

    before(:each) do
      player.stub(:get_move)
      game.stub(:move)
    end

    it "gets move from player" do
      player.should_receive(:get_move).and_return([tower1, tower2])

      game.turn
    end

    it "plays move" do
      player.stub(:get_move).and_return([tower1, tower2])
      game.should_receive(:move).with(tower1, tower2)

      game.turn
    end
  end

  describe "#game_over?" do
    let(:tower1) { double('tower') }
    let(:tower2) { double('tower') }
    let(:tower3) { double('tower') }
    subject(:game) { Hanoi.new([tower1, tower2, tower3]) }


    it "returns false if towers 1 and 2 aren't empty" do
      tower1.stub(:discs).and_return([1,2,3])
      tower2.stub(:discs).and_return([])
      game.game_over?.should be_false
    end

    it "should break when towers 1 and 2 are empty" do
      tower1.stub(:discs).and_return([])
      tower2.stub(:discs).and_return([])
      game.game_over?.should be_true
    end
  end

  describe "#play" do
    subject(:game) {Hanoi.new_game(5)}

    it "should make moves if game isn't over" do
      game.stub(:game_over?).and_return(false, true)
      game.stub(:turn)
      game.stub(:display)

      game.should_receive(:display)
      game.should_receive(:turn)
      game.should_receive(:game_over?).exactly(2).times

      game.play
    end
  end

end


describe Player do
  describe "get_move" do
    it "gets two towers to make a move"
    it "prompts user again until input is correct"
  end
end
