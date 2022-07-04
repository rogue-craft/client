class Menu::BaseMenu
  SECTION_PADDING = 15

  def initialize(system, game_state, keymap, event, color_scheme)
    @system = system
    @game_state = game_state
    @keymap = keymap
    @event = event
    @color_scheme = color_scheme
    @title_text = Ruby2D::Text.new('', size: 16 * 2)
    @hint_text = Ruby2D::Text.new('', size: 16)
    @items = []

    @backgrounded = true

    create_items
    init
  end

  private

  def init
    @active_index = 0

    @width = @items.max_by(&:width).width
    @height = @items.reduce(1) { |acc, i| acc + i.height }

    max_width = Ruby2D::Window.width
    max_height = Ruby2D::Window.height

    @x = (max_width - @width) / 2
    @y = (max_height / 3)

    title = create_title

    return unless title

    @title_text.text = title
    @title_text.y = @y
    @title_text.x = @x - (@title_text.width - @width) / 2

    close
  end

  public

  def update
    x = @x
    y = @title_text ? @y + @title_text.height + SECTION_PADDING : @y

    hint = @items[@active_index].hint

    if hint
      @hint_text.text = hint
      @hint_text.y = y
      @hint_text.x = x - (@hint_text.width - @width) / 2

      y = y + @hint_text.height + SECTION_PADDING * 2
    end

    if @backgrounded
      Ruby2D::Window.add(@title_text) if @title_text
      Ruby2D::Window.add(@hint_text)

      @backgrounded = false
    end

    @items.each_with_index do |item, index|
      item.update(
        Menu::Item::Context.new(x, y, @width, @height, index, @active_index == index)
      )
    end
  end

  def navigate(input)
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

  def close
    @items.each(&:close)

    Ruby2D::Window.remove(@title_text)
    Ruby2D::Window.remove(@hint_text)

    @backgrounded = true
  end

  def clear
    @items.each(&:clear)
  end

  private

  def create_title; end

  def create_items
    raise NotImplementedError.new(__method__)
  end

  def item(name, hint: nil, submit: nil)
    @items << Menu::Item::Field.new(name, hint: hint, submit: submit)
  end

  def form(fields, width, submit)
    @items << Menu::Item::Form.new(fields, @keymap, @color_scheme, width, submit)
  end

  def input(*args, **kwargs)
    Menu::Item::FormInput.new(*args, **kwargs)
  end
end
