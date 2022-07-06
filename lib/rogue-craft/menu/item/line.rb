class Menu::Item::Line < Menu::Item::BaseItem

  # @param ctx [Menu::Item::Context]
  #
  def draw(ctx)
    ctx.window.draw_line(
      ctx.x - (width - ctx.width) / 2,
      ctx.y,
      Gosu::Color::WHITE,
      ctx.x + width,
      ctx.y,
      Gosu::Color::WHITE
    )
  end

  def width
    100
  end

  def height
    PADDING
  end

  def selectable?
    false
  end
end
