class Display::Renderer::World

  include Dependency[:interface, :color_scheme]

  def render(snapshot)
    player = snapshot[:player]
    win = @interface.world_window
    win.clear
    # elapsed_time = (Time.now.to_f * 1000) - snapshot[:timestamp]

    center_y = win.getmaxy / 2
    center_x = win.getmaxx / 2

    display_entity(player, win, center_x, center_y, player)

    snapshot[:entities].each do |entity|
      display_entity(entity, win, center_x, center_y, player)
    end

    win.refresh
  end

  private
  def display_entity(entity, win, center_x, center_y, player)
    y = center_y - (player[:y] - entity[:y])
    x = center_x - (player[:x] - entity[:x])

    if style = @color_scheme[entity[:type]]
      char = style[:char] || '*'
      color = style[:color_pair]
    else
      char = '*'
      color = nil
    end

    win.attron(color) if color
    win.mvprintw(y, x, char)
    win.attroff(color) if color
  end
end
