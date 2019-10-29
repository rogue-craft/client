class Menu::Item::BaseItem

  def display(active_index, index, window)
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
