class Display::Renderer::World

  include Dependency[:snapshot_history, :interface]

  def render
    return unless snapshot = @snapshot_history.relevant

    player = snapshot[:player]
    win = @interface.world_window
    # elapsed_time = (Time.now.to_f * 1000) - snapshot[:timestamp]

    center_y = win.getmaxy / 2
    center_x = win.getmaxx / 2

    display_entity(player, win, center_x, center_y, player)

    snapshot[:entities].each do |entity|
      display_entity(entity, win, center_x, center_y, player)
    end
  end

  private
  def display_entity(entity, win, center_x, center_y, player)
    y = center_y - (player[:y] - entity[:y])
    x = center_x - (player[:x] - entity[:x])

    win.mvprintw(y, x, "%lc", '*')
  end
end
