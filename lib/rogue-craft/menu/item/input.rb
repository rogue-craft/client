class Menu::Item::Input < Menu::Item::BaseItem
  attr_accessor :text

  # @param font [Gosu::Font]
  # @param keymap [Keymap]
  #
  def initialize(id, label, font, keymap, password: false)
    super()

    @id = id
    @label = label
    @font = font
    @keymap = keymap
    @password = password
    @text = ''
  end

  # @param ctx [Menu::Item::Context]
  #
  def draw(ctx)
    draw_label(ctx)

    line_y = ctx.y + height - PADDING * 2

    draw_underline(ctx, line_y)
    draw_text(ctx, line_y)
    draw_rect(ctx, line_y)
    draw_cursor(ctx, line_y)
  end

  private

  # @param ctx [Menu::Item::Context]
  #
  def draw_label(ctx)
    @font.draw_text(
      @label,
      ctx.x,
      ctx.y,
      2,
      1,
      1,
      Gosu::Color::WHITE
    )
  end

  # @param ctx [Menu::Item::Context]
  #
  def draw_underline(ctx, y)
    ctx.window.draw_line(
      ctx.x,
      y,
      Gosu::Color::WHITE,
      ctx.x + width,
      ctx.y + height - PADDING * 2,
      Gosu::Color::WHITE,
      1
    )
  end

  # @param ctx [Menu::Item::Context]
  #
  def draw_text(ctx, line_y)
    @font.draw_text(
      @text,
      ctx.x,
      line_y - @font.height,
      2,
      1,
      1,
      ctx.active? ? Gosu::Color::BLACK : Gosu::Color::WHITE
    )
  end

  # @param ctx [Menu::Item::Context]
  #
  def draw_rect(ctx, line_y)
    ctx.window.draw_rect(
      ctx.x,
      line_y - @font.height,
      ctx.width,
      @font.height,
      ctx.active? ? Gosu::Color::WHITE : Gosu::Color::BLACK,
      0
    )
  end

  # @param ctx [Menu::Item::Context]
  #
  def draw_cursor(ctx, line_y)
    return unless ctx.active?

    x = ctx.x + @font.text_width(@text[...ctx.window.text_input.caret_pos])

    ctx.window.draw_line(
      x,
      line_y - @font.height,
      Gosu::Color::BLACK,
      x,
      line_y,
      Gosu::Color::BLACK,
      1
    )
  end

  public

  def width
    150
  end

  def height
    @font.height + PADDING * 6
  end
end
