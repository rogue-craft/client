module Display

  def self.with_attr(win, attr, &block)
    Ncurses.wattron(win, Ncurses.COLOR_PAIR(1))
    block.call
    Ncurses.wattroff(win, Ncurses.COLOR_PAIR(1))
  end
end
