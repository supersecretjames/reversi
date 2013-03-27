require_relative 'piece.rb'

class Board
  def self.make_start_grid
    grid = Array.new(8) {Array.new(8, nil)}

    grid = place_pieces(grid, [[3,3], [4,4]], :white)
    grid = place_pieces(grid, [[3,4], [4,3]], :black)
  end

  def self.place_pieces(grid, positions, color)
    positions.each do |pos|
      i, j = pos
      grid[i][j] = Piece.new(color)
    end
    grid
  end

  attr_accessor :grid

  def initialize(grid = nil)
    @grid = grid
    @grid = Board.make_start_grid if grid.nil?
  end

  def [](position)
    i, j = position
    grid[i][j]
  end

  def []=(position, new_value)
    i, j = position
    grid[i][j] = new_value
  end

  def on_board?(position)
    i, j = position
    (0...8).include?(i) && (0...8).include?(j)
  end

  def valid_move?(position, color)
    return true if valid_lines(position, color)
    false
  end

  def valid_moves?(color)
    (0...8).each do |i|
      (0...8).each do |j|
        position = [i,j]

        return true if valid_move?(position, color)
      end
    end
    false
  end

  def count_pieces(color)
    counter = 0

    grid.each do |row|
      row.each do |square|
        next if square.nil?
        counter += 1 if square.color == color
      end
    end

    counter
  end

  def place_piece(position, color)
    lines = valid_lines(position, color)

    raise "No valid lines" unless lines

    self[position] = Piece.new(color)

    color_lines(lines, color)
  end

  def line_builder(origin, delta, color)
    raise "Origin not empty" unless self[origin].nil?
    line = [origin]
    current_position = origin

    while true
      current_position = step_by_delta(current_position, delta)

      if !on_board?(current_position)
        return nil
      elsif self[current_position].nil?
        return nil
      elsif self[current_position].color == color && line.count > 1
        line << current_position
        return line
      elsif self[current_position].color != color
        line << current_position
      else
        return nil
      end
    end
  end

  def valid_lines(origin, color)
    return nil unless on_board?(origin)
    return nil unless self[origin].nil?

    dir_deltas = [0, 1, -1].product([0, 1, -1])
    dir_deltas.delete([0, 0])

    lines = []

    dir_deltas.each do |delta|
      line = line_builder(origin, delta, color)
      lines << line unless line.nil?
    end

    return nil if lines.empty?
    lines
  end

  private

  def step_by_delta(position, delta)
    i, j = position
    di, dj = delta
    [i + di, j + dj]
  end

  def color_lines(lines, color)
    lines.each do |line|
      line.each do |position|
        self[position].color = color
      end
    end
  end
end
