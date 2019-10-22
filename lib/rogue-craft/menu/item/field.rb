class Menu::Item::Field < Menu::Item::BaseItem

  attr_reader :data

  def initialize(name, data)
    @name = name
    @data = data
  end

  def display(active_index, index, window)
    window.move(index * 2, 0)
    window.attrset(index == active_index ? Ncurses::WA_STANDOUT : Ncurses::WA_NORMAL)
    window.addstr(@name)
    # window.mvaddstr(index + 1, 0, " ")
  end

  def width
    @name.length
  end

  def height
    2
  end
end
