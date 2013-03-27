class Array
  def my_uniq
    uniq_array = []
    self.each do |item|
      uniq_array << item unless uniq_array.include?(item)
    end
    uniq_array
  end
end

def two_sum?(array)
  array.each_with_index do |item1, i|
    array.each_with_index do |item2, j|
      return true if item1 + item2 == 0 && i != j
    end
  end
  false
end

class Tower
  attr_reader :discs

  def initialize(size = 0)
    @discs = (1..size).to_a.reverse
  end

  def take_disc
    return nil if discs.empty?
    @discs.pop
  end

  def put_disc(disc)
    raise "invalid move, disc too big" if !discs.empty? && discs.last < disc
    @discs << disc
  end

  def valid_move?(disc)
    discs.last > disc
  end

end

class Hanoi
  def self.new_game(size)
    towers = [Tower.new(size), Tower.new, Tower.new]
    Hanoi.new(towers, Player.new)
  end

  attr_reader :towers
  def initialize(towers, player = Player.new)
    @towers, @player = towers, player
  end

  def move(tower1, tower2)
    disc = tower1.take_disc
    if tower2.valid_move?(disc)
      tower2.put_disc(disc)
    else
      tower1.put_disc(disc)
    end
  end

  def turn
    tower1, tower2 = @player.get_move(@towers)
    move(tower1, tower2)
  end

  def game_over?
    @towers[0].discs.empty? && @towers[1].discs.empty?
  end

  def play
    until game_over?
      display
      turn
    end
  end

  def display
    @towers.each_with_index do |tower, index|
      puts "Tower#{index+1}: #{tower.discs}"
    end
  end

end

class Player
  def get_move(towers)
    from_tower, to_tower = 7, 7
    until [0, 1, 2].include?(from_tower)
      print "Select a tower (1, 2, or 3) to take a disc from: "
      from_tower = gets.chomp.to_i - 1
    end

    until [0, 1, 2].delete(from_tower).include?(to_tower)
      print "Select a destination tower for the disc: "
      to_tower = gets.chomp.to_i - 1
    end
    [towers[from_tower], towers[to_tower]]
  end
end



