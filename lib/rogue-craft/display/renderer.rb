class Display::Renderer

  # include Dependency[:level_registry, :camera, :interface]

  def render
    # window = @interface.main_window
    # Ncurses.wclear(window)

    # level = @level_registry.current
    # level_height = level.count
    # level_width = level[0].count

    # @camera.height.times do |y| 
    #   break if y == level_height

    #   @camera.width.times do |x|
    #     break if x == level_width

    #     cell = level[y][x]

    #     Display.with_attr(window, cell.color) do
    #       Ncurses.mvwprintw(window, y, x, cell.char)
    #     end
    #   end
    # end

    # Ncurses.wrefresh(window)
  end
end
