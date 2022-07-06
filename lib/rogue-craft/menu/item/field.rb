class Menu::Item::Field < Menu::Item::BaseItem
  attr_reader :submit, :hint

  # @param name [String]
  # @param font [Gosu::Font]
  # @param hint [#call]
  # @param submit [#call]
  #
  def initialize(name, font, hint: nil, submit: nil)
    super()

    @name = "  #{name}  "
    @font = font
    @hint = hint
    @submit = submit
  end

  # @param ctx [Menu::Item::Context]
  #
  def draw(ctx)
    @font.draw_text(
      @name,
      ctx.x,
      ctx.y,
      1,
      1,
      1,
      ctx.active? ? Gosu::Color::BLACK : Gosu::Color::WHITE
    )

    ctx.window.draw_rect(
      ctx.x,
      ctx.y,
      ctx.width,
      height - PADDING,
      ctx.active? ? Gosu::Color::WHITE : Gosu::Color::BLACK,
      0
    )
  end

  def width
    @font.text_width(@name)
  end

  def height
    @font.height + PADDING
  end
end
