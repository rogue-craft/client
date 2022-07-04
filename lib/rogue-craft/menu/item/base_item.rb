class Menu::Item::BaseItem
  # @param _ctx [Menu::Item::Context]
  #
  def draw(_ctx)
    raise NotImplementedError.new(__method__)
  end

  def width
    raise NotImplementedError.new(__method__)
  end

  def height
    raise NotImplementedError.new(__method__)
  end
end
