class Menu::Item::BaseItem
  PADDING = 10

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

  def selectable?
    true
  end

  def submit; end

  def hint; end
end
