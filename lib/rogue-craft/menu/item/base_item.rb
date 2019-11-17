class Menu::Item::BaseItem

  def display(_active_index, _index, _window)
    raise NotImplementedError.new(__method__)
  end

  def width
    raise NotImplementedError.new(__method__)
  end

  def height
    raise NotImplementedError.new(__method__)
  end

  def close
  end

  def clear
  end
end
