class Display::Interface
  def initialize
    init_ncurses
  end

  def read_input
    Ncurses.getch
  end

  def close
    Ncurses.echo
    Ncurses.nl
    Ncurses.endwin
  end

  def world_window
    @world_window ||= center_window(Ncurses.getmaxy(Ncurses.stdscr), Ncurses.getmaxx(Ncurses.stdscr))
  end

  def center_window(height, width)
    max_y = Ncurses.getmaxy(Ncurses.stdscr)
    max_x = Ncurses.getmaxx(Ncurses.stdscr)

    height = [height, max_y].min
    width = [width, max_x].min

    y = (max_y - height) / 2
    x = (max_x - width) / 2

    Ncurses::WINDOW.new(height, width, y, x)
  end

  def clear
    Ncurses.clear
    Ncurses.refresh
  end

  private

  def init_ncurses
    # Ncurses.initscr
    # Ncurses.start_color
    # Ncurses.use_default_colors
    # Ncurses.cbreak
    # Ncurses.noecho
    # # Ncurses.curs_set(0)
    # Ncurses.stdscr.intrflush(false)
    # Ncurses.stdscr.keypad(true)
    # Ncurses.stdscr.nodelay(true)
  end
end
