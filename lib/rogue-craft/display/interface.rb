class Display::Interface

  attr_reader :main_window, :info_window

  def initialize
    init_ncurses

    @main_window = Ncurses::WINDOW.new(Ncurses.getmaxy(Ncurses.stdscr), Ncurses.getmaxx(Ncurses.stdscr) * 0.8, 0, 0)
  end

  def read_input
    input = Ncurses.getch
    Ncurses.flushinp

    input
  end

  def close
    # @main_window.delwin
    # @info_window.delwin

    Ncurses.echo
    Ncurses.nl
    Ncurses.endwin
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

  private
  def init_ncurses
    Ncurses.initscr
    Ncurses.start_color
    Ncurses.use_default_colors
    Ncurses.cbreak
    Ncurses.noecho
    # Ncurses.curs_set(0)
    Ncurses.stdscr.intrflush(false)
    Ncurses.stdscr.keypad(true)
    Ncurses.stdscr.nodelay(true)
  end
end
