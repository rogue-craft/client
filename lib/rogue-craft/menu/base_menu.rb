class Menu::BaseMenu
  SECTION_PADDING = 15

  def initialize(system, game_state, keymap, event, color_scheme)
    @system = system
    @game_state = game_state
    @keymap = keymap
    @event = event
    @color_scheme = color_scheme
    @items = []
    @active_index = 0

    @title_font = Gosu::Font.new(30)
    @item_font = Gosu::Font.new(16)

    @intialized = false

    create_items
  end

  private

  # @param window [Window]
  #
  def init(window)
    return if @intialized

    @width = @items.max_by(&:width).width
    @height = @items.reduce(1) { |acc, i| acc + i.height }

    max_width = window.width
    max_height = window.height

    @x = (max_width - @width) / 2
    @y = (max_height / 3)

    @intialized = true
  end

  public

  # @param window [Window]
  #
  def draw(window)
    init(window)

    x = @x
    y = @y

    if (title = create_title)
      @title_font.draw_text(title, x - (@title_font.text_width(title) - @width) / 2, y, 0)

      y += @title_font.height + SECTION_PADDING
    end

    if (hint = @items[@active_index].hint)
      @item_font.draw_text(hint, x - (@item_font.text_width(hint) - @width) / 2, y, 0)

      y += @item_font.height + SECTION_PADDING * 2
    end

    @items.each_with_index do |item, index|
      item.draw(
        Menu::Item::Context.new(window, x, y, @width, @height, index, @active_index == index)
      )
    end
  end

  def navigate(input)
    # Gosu.button_down?
    # if current.is_a?(Menu::Item::Form)
    #   current.navigate(input)
    #   return
    # end

    if @keymap.is?(input, :escape)
      @system.open_main
    elsif @keymap.is?(input, :menu_up)
      @active_index -= 1
    elsif @keymap.is?(input, :menu_down)
      @active_index += 1
    elsif @keymap.is?(input, :submit)
      @items[@active_index].submit.call
    end

    max = @items.count - 1
    @active_index = max if @active_index.negative?
    @active_index = 0 if @active_index > max
  end

  private

  def create_title; end

  def create_items
    raise NotImplementedError.new(__method__)
  end

  def item(name, hint: nil, submit: nil)
    @items << Menu::Item::Field.new(name, @item_font, hint: hint, submit: submit)
  end

  def form(fields, width, submit)
    @items << Menu::Item::Form.new(fields, @keymap, @color_scheme, width, submit)
  end

  def input(*args, **kwargs)
    Menu::Item::FormInput.new(*args, **kwargs)
  end
end
