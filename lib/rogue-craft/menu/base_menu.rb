class Menu::BaseMenu
  SECTION_PADDING = 15

  # @param window [GameWindow]
  #
  def initialize(window, system, keymap, event, color_scheme)
    @window = window
    @system = system
    @keymap = keymap
    @event = event
    @color_scheme = color_scheme
    @items = []
    @active_index = 0

    @title_font = Gosu::Font.new(30)
    @item_font = Gosu::Font.new(16)

    create_items
    init
  end

  private

  def init
    @width = @items.max_by(&:width).width
    @height = @items.reduce(1) { |acc, i| acc + i.height }

    max_width = @window.width
    max_height = @window.height

    @x = (max_width - @width) / 2
    @y = (max_height / 3)

    @intialized = true
  end

  public

  def draw(input_text)
    current = @items[@active_index]

    current.text = input_text if current.is_a?(Menu::Item::Input)

    x = @x
    y = @y

    if (title = create_title)
      @title_font.draw_text(title, x - (@title_font.text_width(title) - @width) / 2, y, 0)

      y += @title_font.height + SECTION_PADDING
    end

    has_any_hint = @items.find { |i| !i.hint.nil? }

    if has_any_hint
      hint = @items[@active_index].hint.to_s
      @item_font.draw_text(hint, x - (@item_font.text_width(hint) - @width) / 2, y, 0)

      y += @item_font.height + SECTION_PADDING * 2
    end

    @items.each_with_index do |item, index|
      item.draw(
        Menu::Item::Context.new(@window, x, y, @width, @height, index, @active_index == index)
      )
      y += item.height
    end
  end

  def navigate(input)
    max_index = @items.count - 1

    prev_active_index = @active_index

    if @keymap.is?(input, :escape)
      @system.open_main
    elsif @keymap.is?(input, :menu_up)
      set_active_index(max_index, -1)
    elsif @keymap.is?(input, :menu_down)
      set_active_index(max_index, 1)
    elsif @keymap.is?(input, :submit)
      @items[@active_index].submit&.call
    end

    current = @items[@active_index]

    return unless current.is_a?(Menu::Item::Input)

    @window.text_input.text = current.text if prev_active_index != @active_index
  end

  private

  def set_active_index(max_index, modfier)
    return unless @items.find(&:selectable?)

    loop do
      @active_index += modfier
      @active_index = max_index if @active_index.negative?
      @active_index = 0 if @active_index > max_index

      break if @items[@active_index]&.selectable?
    end
  end

  def create_title; end

  def create_items
    raise NotImplementedError.new(__method__)
  end

  def field(name, hint: nil, submit: nil)
    @items << Menu::Item::Field.new(name, @item_font, hint: hint, submit: submit)
  end

  def form(fields, width, submit)
    @items << Menu::Item::Form.new(fields, @keymap, @color_scheme, width, submit)
  end

  def input(*args, **kwargs)
    args << @item_font
    args << @keymap

    @items << Menu::Item::Input.new(*args, **kwargs)
  end

  def line
    @items << Menu::Item::Line.new
  end
end
