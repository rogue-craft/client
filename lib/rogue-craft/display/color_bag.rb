class Display::ColorBag

  COLOR_NONE = -1.freeze

  def initialize
    @colors = []
  end

  def get(fg:, bg:)
    unless @colors.include?([fg, bg])
      Ncurses.init_pair(@colors.count + 1, fg, bg)
      @colors << [fg, bg]
    end

    Ncurses.COLOR_PAIR(@colors.find_index([fg, bg]) + 1)
  end
end
