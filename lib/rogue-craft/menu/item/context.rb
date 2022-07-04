# @!attribute [r] window
#   @return [Gosu::Window]
#
class Menu::Item::Context
  attr_reader :window, :x, :y, :width, :height, :index

  # @param window [GameWindow]
  #
  def initialize(window, x, y, width, height, index, active)
    @window = window
    @x = x
    @y = y
    @width = width
    @height = height
    @index = index
    @active = active
  end

  def active?
    @active
  end
end
