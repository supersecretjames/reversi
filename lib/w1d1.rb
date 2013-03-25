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

  def initialize(size)
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

end

class Hanoi
end



