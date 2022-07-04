class Menu::Item::Context
  attr_reader :x, :y, :width, :height, :index, :font_size

  def initialize(x, y, width, height, index, active)
    @x = x
    @y = y
    @width = width
    @height = height
    @index = index
    @active = active
    @font_size = 30
  end

  def active?
    @active
  end
end
