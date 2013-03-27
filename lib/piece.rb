class Piece
  attr_accessor :color  
  #REV usually, you don't want people to access your variables directly. what if they
  #set your color to :orange, or :green. you allow that, but are unable to recover from that.
  #this is why the flip method might be profitable. it ensures your state is consistent, while
  #making it easy to change the color.

  def initialize(color)
    @color = color
  end
end