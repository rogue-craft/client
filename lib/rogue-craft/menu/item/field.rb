class Menu::Item::Field < Menu::Item::BaseItem
  attr_reader :submit, :hint

  # @param name [String]
  # @param hint [#call]
  # @param submit [#call]
  #
  def initialize(name, hint: nil, submit: nil)
    super()

    @hint = hint
    @submit = submit
    @backgrounded = true

    create_componenets(name)
  end

  # @param ctx [Menu::Item::Context
  #
  def update(ctx)
    @text.x = ctx.x
    @text.y = ctx.y + ctx.index * 2 * ctx.font_size
    @text.size = ctx.font_size
    @text.color = ctx.active? ? 'black' : 'white'

    @bg.x = ctx.x
    @bg.y = ctx.y + ctx.index * ctx.font_size * 2
    @bg.width = ctx.width
    @bg.color = ctx.active? ? 'white' : 'black'
    @bg.color.opacity = ctx.active? ? 1 : 0

    return unless @backgrounded

    Ruby2D::Window.add(@text)
    Ruby2D::Window.add(@bg)

    @backgrounded = false
  end

  private

  def create_componenets(name)
    @text = Ruby2D::Text.new(
      '  ' + name,
      z: 1
    )

    @bg = Ruby2D::Rectangle.new(
      height: @text.height,
      color: 'red',
      z: 0
    )
  end

  public

  def width
    @text.width
  end

  def height
    @text.height
  end

  def close
    Ruby2D::Window.remove(@text)
    Ruby2D::Window.remove(@bg)
    @backgrounded = true
  end
end
