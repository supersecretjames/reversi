class Piece
  attr_accessor :color

  def initialize(color)
    @color = color
  end
end
#REV: no flip method? If you flip everything manually in the board,
# what's the point of a Piece class?